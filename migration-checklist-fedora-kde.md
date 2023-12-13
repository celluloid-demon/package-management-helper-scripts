# Migration Checklist

*******************************************************************************

***TODO - COPIED FROM WINDOWS CHECKLIST AS A TEMPLATE, CUSTOMIZE FOR FEDORA APPLICATIONS / GIT PROJECTS***

*******************************************************************************

## From the Fedora KDE 'Spin' to another OS

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

### Copy:

[] - all ***hidden*** git project custom settings / config files (typically in respective git projects under `$HOME/.local/git`)
[x] - D:/ data drive ***FOR ALL LOCAL USERS YOU SET UP*** (overnight robocopy script, format destination as ntfs, give exclusive access to robocopy, ***run from elevated prompt***)

### Push:

[x] - all git projects
[] - all ***hidden*** git projects (typically under `$HOME/.local/git/`)

### [Fedora] Post:

[x] - prepare/format any additional (internal) drives (set up automount for partitions if needed)
[x] - set up web browser / password manager
[x] - set up git (https://docs.github.com/en/get-started/quickstart/set-up-git, https://github.com/celluloid-demon/git-helper-scripts)
[x] - customize OS settings / keyboard shortcuts, set "hide all windows" keyboard shortcut to super-d
[x] - install graphics card / other drivers as per fedora gaming guide
[x] - copy user data over (rsync / grsync)
[x] - set up shared-config-nix hidden git repo as per readme
[x] - set up resilio sync autostart (use kde autostart script - ***DO NOT FROM SYSTEMD***)
[x] - restore resilio sync share folders (run as user on login, as kde startup script - ***NOT FROM SYSTEMD***)
[x] - restore software
[x] - organize user data!
[x] - set up backups / (btrfs) snapshots on fedora

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
