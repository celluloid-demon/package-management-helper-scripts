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

## From another OS to the Fedora KDE 'Spin'

### Setup:

[] - custom system settings (as you go)
[] - web browser (firefox/chromium), password manager (bitwarden)

### Install:

[x] - "btrfs group"
	
	- timeshift (system rollback), btrfs-assistant (user data file versioning on second disk)
	- grub cleanup as per obsidian notes

[x] - "cli group"

	- dnf: git gh byobu micro tree (to use byobu, switch to using the byobu application launcher and (on the Fedora KDE 'Spin') ***leave default terminal emulator set to Konsole***)
	- repo: git-helper-scripts
	- repo: shared-config-nix ("install" to `$HOME/.local/git`)
	- repo: package-management-helper-scripts
	- vscode: https://code.visualstudio.com/docs/setup/linux
	- symlink to $HOME/Documents/SSH dir (copy from previous user data backup), test connection to device(s), alias

[x] - "multimedia group"

	- https://rpmfusion.org/Configuration
	- https://rpmfusion.org/CommonBugs
	- https://rpmfusion.org/Howto/NVIDIA (see "x86_64 (64bit) users" for 3D acceleration in 32bit packages such as Wine)
	- https://trac.ffmpeg.org/wiki/HWAccelIntro#NVENC (optional - for nvidia hardware-accelerated video encoding)
	- (note: dnf package "intel-media-driver" covered in Multimedia guide)
	- https://rpmfusion.org/Howto/Optimus (optional - with Fedora 25 and later, Optimus devices are supported automatically by default)
	- https://rpmfusion.org/Howto/Multimedia
	- mpv

[x] - <RESTART>

[x] - "game group"

	- dnf (rpmfusion): steam
	- steam: tablestop simulator, magic the gathering table workshop download (as a test install)
	- openmw: https://openmw.org/downloads/ (must initialize official morrowind configuration files [read: install and run morrowind] before launching openmw wizard)
	- openmw: test launch

[x] - "chat group"

Note:
Global application launch files ending ".desktop" go in:
/usr/share/applications
Personal application files go in:
/home/$USER/.local/share/applications/

	- discord (official portable install for less restrictive install, game status, etc)
	- signal desktop (flatpak)
	- whatsapp desktop (flatpak)

[x] - "web app group" (chromium)

	Chrome/Chromium web app locations:

		Windows 10/8/7: C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default\Web Applications\
		macOS: ~/Library/Application Support/Google/Chrome/Default/Web Applications
		Linux: ~/.config/google-chrome/Default/Web Applications
		Linux (Chromium): ~/.config/chromium/Default/Web Applications
		Chrome OS: /home/chronos/Web Applications

	Recommended filesystem layout for persistent web app storage (makes migration and backups easier):

		$HOME/Documents/Application Support/Chromium/

			desktop-file-backups
			Web Applications (symlinked to "$HOME/.config/chromium/Default/Web Applications")

	- ChatGPT
	- Gmail
	- Google
	- Google Calendar
	- Notion
	- Reclaim
	- Todoist
	- WaniKani

[x] - "docker group" ("install" to $HOME/.local/git)

	- docker engine (NOT "docker desktop" for linux)
		- https://docs.docker.com/engine/install/
		- https://docs.docker.com/engine/install/linux-postinstall/
		- https://docs.docker.com/config/containers/logging/configure/ (/etc/docker/daemon.json - configure "local driver" which rotates logs by default, must recreate containers to use)
		- https://docs.docker.com/config/containers/logging/local/
	- repo: gtg-gui
	- repo: minecraft (pending dockerfile re-creation)
	- repo: resilio-sync (launch on login w/ kde autostart script)
	- repo: resilio-sync-big-boi (on port 8889, same as above)

[...] - "resilio sync group (main)" (***mind that you pay attention to where you're adding folders within the container web ui! look for `/resilio-sync`***)

		- [docker:/resilio-sync] _for_big_boi_use_port_8889
...		- [docker:/resilio-sync] music (re-sync to iphone when finished re-indexing)
		- [docker:/resilio-sync] soccer-ball
		- [docker:/resilio-sync] wfpk

[...] - "resilio sync group (big-boi)"

		- [docker:/resilio-sync] iso (symlink:big-boi/resilio-sync/iso)
		- [docker:/resilio-sync] media (symlink:big-boi/resilio-sync/media)
		- [docker:/resilio-sync] vault (symlink:big-boi/resilio-sync/vault)

[x] - "graphics group"

	- blender: https://docs.blender.org/manual/en/latest/getting_started/installing/linux.html

[x] - "virtualization group"

	- https://docs.fedoraproject.org/en-US/quick-docs/virtualization-getting-started/

[x] - "(everything else) group"

	- obsidian
	- obsidian: local images plugin

[x] - "file group"

	- do: /home/$USER indexing (system settings) - leave overnight, this will take a while...

### Setup:

[] - fedora log rotation

	- https://docs.fedoraproject.org/en-US/fedora/latest/system-administrators-guide/monitoring-and-automation/Viewing_and_Managing_Log_Files/#s2-log_rotation
