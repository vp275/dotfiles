# Mercedes Petronas colorscheme for ranger
# Directories and accents use the Petronas teal palette slot.

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import (
    black, blue, green, magenta, red, white, yellow, default,
    normal, bold, reverse, dim, BRIGHT,
    default_colors,
)

petronas_teal = yellow


class Default(ColorScheme):
    progress_bar_color = petronas_teal

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.selected:
                attr = bold
                fg = black
                bg = white  # White focus bar
            else:
                attr = normal
            if context.empty or context.error:
                bg = red
            if context.border:
                fg = default
            if context.media:
                if context.image:
                    fg = petronas_teal
                else:
                    fg = magenta
            if context.container:
                fg = red
            if context.directory:
                attr |= bold
                if not context.selected:
                    fg = petronas_teal
                    fg += BRIGHT
            elif context.executable and not \
                    any((context.media, context.container,
                         context.fifo, context.socket)):
                attr |= bold
                fg = green
                fg += BRIGHT
            if context.socket:
                attr |= bold
                fg = magenta
                fg += BRIGHT
            if context.fifo or context.device:
                fg = yellow
                if context.device:
                    attr |= bold
                    fg += BRIGHT
            if context.link:
                fg = petronas_teal if context.good else magenta
            if context.tag_marker and not context.selected:
                attr |= bold
                if fg in (red, magenta):
                    fg = white
                else:
                    fg = red
                fg += BRIGHT
            if not context.selected and (context.cut or context.copied):
                attr |= bold
                fg = black
                fg += BRIGHT
                if BRIGHT == 0:
                    attr |= dim
                    fg = white
            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    fg = white  # Marked: white (to stand out)
            if context.badinfo:
                if attr & reverse:
                    bg = magenta
                else:
                    fg = magenta

            if context.inactive_pane:
                fg = petronas_teal

        elif context.in_titlebar:
            if context.hostname:
                fg = red if context.bad else green
            elif context.directory:
                fg = petronas_teal
            elif context.tab:
                if context.good:
                    bg = green
            elif context.link:
                fg = petronas_teal
            attr |= bold

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = petronas_teal
                elif context.bad:
                    fg = magenta
            if context.marked:
                attr |= bold | reverse
                fg = petronas_teal
                fg += BRIGHT
            if context.frozen:
                attr |= bold | reverse
                fg = petronas_teal
                fg += BRIGHT
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = red
                    fg += BRIGHT
            if context.loaded:
                bg = self.progress_bar_color
            if context.vcsinfo:
                fg = petronas_teal
                attr &= ~bold
            if context.vcscommit:
                fg = yellow
                attr &= ~bold
            if context.vcsdate:
                fg = petronas_teal
                attr &= ~bold

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = petronas_teal

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color

        if context.vcsfile and not context.selected:
            attr &= ~bold
            if context.vcsconflict:
                fg = magenta
            elif context.vcsuntracked:
                fg = petronas_teal
            elif context.vcschanged:
                fg = red
            elif context.vcsunknown:
                fg = red
            elif context.vcsstaged:
                fg = green
            elif context.vcssync:
                fg = green
            elif context.vcsignored:
                fg = default

        elif context.vcsremote and not context.selected:
            attr &= ~bold
            if context.vcssync or context.vcsnone:
                fg = green
            elif context.vcsbehind:
                fg = red
            elif context.vcsahead:
                fg = petronas_teal
            elif context.vcsdiverged:
                fg = magenta
            elif context.vcsunknown:
                fg = red

        return fg, bg, attr
