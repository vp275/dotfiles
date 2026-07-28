# Ranger and Bat preview latency

Research date: 2026-07-27

## Question

Can Ranger keep Bat-highlighted Markdown previews in a large Obsidian vault
without making navigation feel sluggish?

## Short answer

Yes, with an important limit. Bat is designed to run as a short-lived command
and has been optimized heavily for startup, but every cold preview still has a
non-zero startup cost. Ranger adds its own shell process and several utility
processes around Bat. Rapid navigation can also expose a Ranger queueing
problem because old preview work is paused and retained instead of being
discarded.

The installed Ranger 1.9.4 also contains a confirmed macOS subprocess-signal
bug. Fixing that comes first. Afterward, the best preview optimization is to
restore external previews in the vault and add an early Markdown fast path to
`scope.sh`. That path should invoke Bat directly, before MIME detection, with
an explicit Markdown language and a bounded line range. This preserves the
Mercedes-Petronas theme and Ranger's in-session preview cache while avoiding
the rest of the generic preview pipeline.

## What Bat is doing

Bat has a genuine fixed startup cost. In 2020, Bat's maintainer measured about
45 ms and found most of the time was spent deserializing syntax and theme
assets. Bat subsequently added lazy asset loading and other startup
optimizations. In a 2023 analysis, the maintainer measured a typical warm run
at 8.5 ms. That run still spent time initializing syntax mappings, querying Git
state, and loading theme and syntax assets.

Sources:

- [Bat issue #951, Improve bat startup speed](https://github.com/sharkdp/bat/issues/951)
- [Bat issue #2545, Improving the performance of a typical bat run](https://github.com/sharkdp/bat/issues/2545)
- [Bat PR #2442, macOS startup optimization](https://github.com/sharkdp/bat/pull/2442)
- [Bat PR #2868, offload glob matcher construction](https://github.com/sharkdp/bat/pull/2868)

Bat's own README recommends it for file previews and uses `--line-range` to
avoid processing unnecessary content:

```sh
bat --color=always --style=numbers --line-range=:500 file
```

Source: [Bat README preview recipe](https://github.com/sharkdp/bat/blob/78951393e29bfd2f2a45f4326b9d2bb5e737dd2a/README.md#L98-L109)

This means the upstream-supported low-latency knobs are:

- `--paging=never`, to guarantee that no pager is started.
- `--style=plain`, to skip decorations Ranger does not need.
- `--language=Markdown`, to skip filename-based syntax selection.
- `--line-range=:N`, to bound the content Bat processes for a preview.
- A fixed theme, which is already provided by `BAT_THEME`.

## What the Bat cache does

`bat cache --build` compiles custom syntax definitions and themes into binary
asset files. It is required for the custom Mercedes-Petronas theme. It is not a
cache of rendered file output.

Each new Bat process still loads the relevant compiled assets. Bat can bypass
custom assets with `--no-custom-assets`, but that also makes the custom theme
unavailable and only produced a small improvement locally.

Sources:

- [Bat README, adding custom themes](https://github.com/sharkdp/bat/blob/78951393e29bfd2f2a45f4326b9d2bb5e737dd2a/README.md#L590-L610)
- [Bat custom asset selection source](https://github.com/sharkdp/bat/blob/78951393e29bfd2f2a45f4326b9d2bb5e737dd2a/src/bin/bat/assets.rs#L18-L44)
- [Bat lazy asset source](https://github.com/sharkdp/bat/blob/78951393e29bfd2f2a45f4326b9d2bb5e737dd2a/src/assets.rs#L28-L78)

Rebuilding the Bat cache fixes missing or incompatible custom themes. Rebuilding
it repeatedly does not make note previews progressively faster.

## What Ranger is doing

For each uncached path, Ranger launches `scope.sh` through a new
`CommandLoader`. The script then starts Bat. A cold Markdown preview therefore
pays for Ranger's preview process, Bash startup, MIME detection, size and
terminal checks, and Bat startup.

Ranger stores completed text previews in the in-memory
`self.previews[path]` dictionary. Exit code 5 from `scope.sh` tells Ranger that
the output is independent of preview width and height, so revisiting the same
note in the same Ranger session should not rerun Bat. The cache is not
persistent across Ranger sessions.

Sources:

- [Ranger preview generation and cache](https://github.com/ranger/ranger/blob/00650d33ed2f91439c546b8717776905502eb01f/ranger/core/actions.py#L1078-L1204)
- [Ranger scope exit-code contract](https://github.com/ranger/ranger/blob/00650d33ed2f91439c546b8717776905502eb01f/ranger/data/scope.sh#L18-L28)

Rapid navigation has a second problem. Ranger inserts a new preview task at the
front of its loader queue and pauses the previous task. It does not generally
kill all stale preview work when the selection changes. Ranger users have
reported preview jobs accumulating and blocking the queue. A 2026 upstream pull
request also documents cases where Ranger can recreate preview tasks after
losing their loading-state bookkeeping.

Sources:

- [Ranger loader queue source](https://github.com/ranger/ranger/blob/00650d33ed2f91439c546b8717776905502eb01f/ranger/core/loader.py#L353-L371)
- [Ranger loader pause behavior](https://github.com/ranger/ranger/blob/00650d33ed2f91439c546b8717776905502eb01f/ranger/core/loader.py#L449-L456)
- [Ranger issue #2634, preview blocks the task queue](https://github.com/ranger/ranger/issues/2634)
- [Ranger issue #202, request for preview delay](https://github.com/ranger/ranger/issues/202)
- [Ranger PR #3217, prevent multiple preview tasks per file](https://github.com/ranger/ranger/pull/3217)

There is also a macOS-specific signal bug that can freeze preview tasks during
fast scrolling. It was fixed upstream in January 2025, but inspection confirms
that the installed Ranger 1.9.4 does not contain the fix.

Its installed `loader.py` sends hard-coded signal 20 to pause a subprocess and
signal 18 to resume it. On this Mac, Python reports:

```text
SIGTSTP = 18
SIGCONT = 19
SIGCHLD = 20
```

The old Ranger code therefore sends `SIGCHLD` when it intends to pause, then
sends `SIGTSTP` when it intends to resume. This can leave preview processes
stopped and cause the queue to accumulate during fast navigation. Current
upstream Ranger uses the named `signal.SIGTSTP` and `signal.SIGCONT` constants
instead.

Sources:

- [Ranger PR #2911, fix OS X subprocess signals](https://github.com/ranger/ranger/pull/2911)
- [Current Ranger loader with portable signal constants](https://github.com/ranger/ranger/blob/00650d33ed2f91439c546b8717776905502eb01f/ranger/core/loader.py#L281-L306)

## Local measurements

Environment:

- macOS on Apple Silicon
- Ranger 1.9.4
- Bat 0.26.1
- Custom Mercedes-Petronas Bat theme
- Warm filesystem cache
- 50 runs against Markdown notes in `/Users/vp/vault`

The benchmark included process creation and discarded rendered output. The
numbers are representative, not laboratory-grade:

| Command path | Median |
| --- | ---: |
| Bat with the current arguments | 18.3 ms |
| Bat with fixed language and bounded lines | 16.4 ms |
| Current full `scope.sh` path | 54.1 ms |
| Simulated Bash Markdown fast path | 29.5 ms |

Individual helper costs measured locally included about 8.4 ms for `file`, 2.1
ms for `stat`, and 1.9 ms for `tput`. Bat was less than half of the current
54 ms full pipeline. The generic `scope.sh` path is therefore the larger
optimization opportunity.

The custom theme is not the main problem. Using a built-in theme or bypassing
custom assets changed the local Bat median by less than 1 ms. Bounding the line
range and fixing the Markdown language helped more, while keeping the desired
theme.

## Recommended implementation

### 1. Fix Ranger's macOS subprocess signals

Upgrade to a Ranger build containing PR #2911 or apply its small,
version-pinned loader patch. This addresses an actual correctness bug in the
installed build, not a Bat tuning preference. It is the first change to test
for the held-key scrolling and accumulating-lag symptom.

### 2. Add a Markdown fast path

Remove the vault-local `use_preview_script false` override. Then add a
Markdown branch near the start of `scope.sh`, before the `file` MIME probe:

```sh
case "${FILE_EXTENSION_LOWER}" in
    md|markdown)
        env COLORTERM=8bit bat \
            --paging=never \
            --color=always \
            --style=plain \
            --language=Markdown \
            --line-range=:500 \
            -- "${FILE_PATH}" && exit 5
        exit 2
        ;;
esac
```

Expected result:

- Bat highlighting and the Mercedes-Petronas theme return in the vault.
- A cold Markdown preview should fall from roughly 54 ms toward 30 ms locally.
- Revisiting a completed preview in the same Ranger session should use Ranger's
  memory cache.
- Large Markdown notes have bounded preview work.
- Non-Markdown files continue through the generic preview pipeline.

This is the safest preview-pipeline improvement supported by the behavior
documented in both projects.

## If fast scrolling still stutters

At that point, Bat tuning is no longer the main lever. The remaining issue is
Ranger's preview scheduling. The robust options are:

1. Upgrade Ranger when an upstream stale-preview cancellation fix is released.
2. Apply a small, version-pinned Ranger patch or plugin that cancels obsolete
   preview loaders when selection changes.
3. Add a short preview debounce in Ranger so holding `j` does not start work
   for every note passed over.

Options 2 and 3 are custom engineering. Ranger does not currently expose a
documented configuration setting for general preview debounce or persistent
rendered-text caching. A Bat daemon would also be custom architecture, not a
supported Bat mode.

## Conclusion

The user's intuition is correct that Bat was not intended to feel like a
50 ms tax on every movement. Modern Bat itself is substantially faster than
that. In this setup, most avoidable latency comes from Ranger's generic
`scope.sh` pipeline, and held-key navigation can additionally suffer from
Ranger's stale preview queue behavior.

The practical sequence is to fix the installed Ranger signal bug, then add the
Markdown fast path. This should restore the theme with a meaningful latency
reduction and stop the known macOS pause/resume failure. If the remaining
roughly 30 ms cold cost still feels poor during rapid traversal, preview
cancellation or debounce in Ranger is the next technically relevant fix.
