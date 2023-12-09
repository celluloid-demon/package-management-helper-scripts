# Migration Checklist

## From Windows to another OS

### Backup:

[x] - windows product key / digital license linked to your microsoft account

### Export:

[x] - Adobe Photoshop (keyboard shortcuts)
[x] - Macrium Reflect Free (backup definition files)
[x] - Minecraft (local world files if any)
[x] - Vortex ***OR*** OpenMW (local mod files / plugins)
[x] - Resilio Sync share folder names

### Sync:

[x] - resilio sync shares


### Push:

[x] - all git projects

### Copy:

[x] - WSL hidden dot-files (if any)
[x] - D:/ data drive ***FOR ALL LOCAL USERS YOU SET UP*** (overnight robocopy script, format destination as ntfs, give exclusive access to robocopy, ***run from elevated prompt***)

### [Fedora] Post:

[x] - prepare/format any additional (internal) drives (set up automount for partitions if needed)
[x] - set up web browser / password manager
[x] - set up git (https://docs.github.com/en/get-started/quickstart/set-up-git, https://github.com/celluloid-demon/git-helper-scripts)
[x] - customize OS settings, set "hide all windows" keyboard shortcut to super-d, disable activities overview hot corner
[x] - review gnome keyboard shortcut navigation (https://help.gnome.org/users/gnome-help/stable/keyboard-nav.html.en, https://help.gnome.org/users/gnome-help/stable/shell-keyboard-shortcuts.html.en)
[x] - install gnome tweaks, customize, change activities overview shortcut to right-super (effectively disabling it)
[x] - install gnome-extensions app, customize (built-in shell extensions)
[x] - install 'applications menu' gnome shell extension, customize (note: alt-f1 is used for opening this menu!)
[x] - install 'Dash to dock', 'No overview at start-up' gnome shell extensions, disable "Show overview on startup" (dash to dock: Appearance > Show overview on startup)
[x] - install 'desktop icons', customize
[x] - install graphics card / other drivers as per fedora gaming guide
[x] - copy user data over (rsync / grsync)
[] - restore resilio sync share folders
[] - restore software
[] - organize user data!
[] - symlink large home subfolders to larger hard disk

## From another OS to Windows

### Activate:

[] - windows product key / digital license linked to your microsoft account

### Copy:

[] - WSL hidden dot-files (if any)
[] - D:/ data drive (overnight robocopy script)

### Import:

[] - Adobe Photoshop (hotkeys: File > Export > Export Preferences...)
[] - Macrium Reflect Free (backup definition files)

### Setup:

[] - Adobe Bridge (image collection keywords)
[] - Minecraft (local world files if any)
[] - Vortex ***OR*** OpenMW (local mod files / plugins)

### Customize:

[] - Intel Graphics Command Center (custom settings)
[] - Lenovo Vantage (custom settings)
