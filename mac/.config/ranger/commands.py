# Custom ranger commands - fixes for known bugs

from ranger.config.commands import *
from ranger.core.loader import CommandLoader


class trash(Command):
    """Move files to trash (macOS/Linux compatible)

    Fixes AttributeError: 'str' object has no attribute 'path' bug
    in ranger 1.9.4 with Python 3.13
    """

    allow_signing = True
    escape_macros_for_signing = True

    def execute(self):
        import shutil

        if self.rest(1):
            files = shlex.split(self.rest(1))
            many_files = (len(files) > 1 or os.path.isdir(files[0]))
        else:
            cwd = self.fm.thisdir
            tfile = self.fm.thisfile
            if not cwd or not tfile:
                self.fm.notify("No file selected for trash!", bad=True)
                return

            files = self.fm.thistab.get_selection()
            many_files = (cwd.marked_items or (tfile.is_directory and not tfile.is_link))

        confirm = self.fm.settings.confirm_on_delete
        if confirm != 'never' and (confirm != 'multiple' or many_files):
            filenames = [f.path if hasattr(f, 'path') else f for f in files]
            self.fm.ui.console.ask(
                "Confirm trash of: %s (y/N)" % ', '.join(
                    ['"%s"' % (os.path.basename(f)) for f in filenames[:5]]
                    + (['...'] if len(filenames) > 5 else [])
                ),
                lambda answer: self._trash_files(files) if answer.lower() == 'y' else None,
                ('n', 'N', 'y', 'Y'),
            )
        else:
            self._trash_files(files)

    def _trash_files(self, files):
        from ranger.container.file import File

        # Convert to proper file objects if needed
        file_objects = []
        for f in files:
            if hasattr(f, 'path'):
                file_objects.append(f)
            else:
                file_objects.append(File(f))

        if file_objects:
            self.fm.execute_file(file_objects, label='trash')
            self.fm.thisdir.mark_all(False)
            self.fm.thisdir.load_content()

    def tab(self, tabnum):
        return self._tab_directory_content()
