Migration Checklist
===================

From another OS to the Fedora KDE 'Spin'
-------------------------------------------------------------------------------

### Setup / install:

#### Web + file group

- web browser (firefox/chromium <--- symlink .config/.mozilla from `/home-ssd/$USER/Documents/`...), password manager (bitwarden)
- (from **sysadmin**, as **$USER** via `su - <username>`) symlink "performance files" from `/home-ssd/$USER` (if `@home` is on a slower spinning disk)
- (log back in) set up **file indexing**, custom other system settings
- symlink config files for chrome/chromium/mozilla from ssd

#### Cli group

- dnf: git gh byobu micro tree (to use byobu, switch to using the byobu application launcher and (on the Fedora KDE 'Spin') ***leave default terminal emulator set to Konsole***)
- repo: git-helper-scripts
- repo: shared-config-nix ("install" to `$HOME/Applications/`)
- repo: package-management-helper-scripts
- vscode: https://code.visualstudio.com/docs/setup/linux
- symlink to $HOME/Documents/SSH dir (copy from previous user data backup), test connection to device(s), alias
- `sudo dnf groupinstall "Development Tools" "Development Libraries"`

#### Btrfs group

- minor grub cleanup as per obsidian notes

	When booting your system, you may have noticed the following error message.
	error: ../../grub-core/commands/loadenv.c:216:sparse file not allowed.
	This is because you did not create a separate ext4 /boot partition and instead included it in the btrfs system root. GRUB preboot writes to /boot/grub2/grubenv if the boot was successful. This error occurs because of the GRUB btrfs.mod driver, unlike ext4, is read-only. To resolve this, open the Gnome terminal and execute the following command.
	`$ sudo grub2-editenv - unset menu_auto_hide`
- timeshift
	- WARNING: Timeshift needs a **"flat" subvolume layout** with **no nested subvolumes** (read: with timeshift you cannot, for example, create a `/games` nested subvolume, timeshift will lose track of this subvolume and not honor it - a better practice is to create additional **top-level** subvolumes from live media and mount them directly through fstab).
	- for easy rollback of `@` - the subvol that your OS is stored on
- (optional) btrfs-assistant ***OR*** btrfs-snp
	- **WARNING:** The `btrfs-snp` project is NOT the same as the `btrfs-snap` project, which it is inspired by!
	- btrfs-assistant / btrfs-snp is for user data file-versioning, if you're using your machine/laptop's **second** internal drive to store `@HOME` subvol; timeshift is the tool of choice for simple system rollback, but doesn't know what to do with two drives

**Install btrfs-snp to system:**

```bash
# Assuming btrfs-snp is in Downloads folder.
chmod +x "$HOME/Downloads/btrfs-snp"
sudo cp "$HOME/Downloads/btrfs-snp" /usr/local/sbin/
```

To run automatically, add desired btrfs-snp jobs to cron, typically `/etc/cron.hourly/`:

```bash
# Create a new file in /etc/cron.hourly/, name it something memorable (like
# btrfs-snp), and open it in the 'nano' editor.
sudo nano /etc/cron.hourly/btrfs-snp
```

Copy/paste (shift + ctrl + v in terminal):

```bash
#!/bin/bash
/usr/local/sbin/btrfs-snp /home hourly  24 3600
/usr/local/sbin/btrfs-snp /home daily    7 86400
/usr/local/sbin/btrfs-snp /home weekly   4 604800
/usr/local/sbin/btrfs-snp /home monthly 12 2592000
```

Save and exit. **You do not need to restart cron!** Cron will search `/etc/cron.hourly/` every hour and run whatever it finds.

**Install btrfs-sync to system:**

```bash
# Assuming btrfs-sync is in Downloads folder.
chmod +x "$HOME/Downloads/btrfs-sync"
sudo cp "$HOME/Downloads/btrfs-sync" /usr/local/sbin/
```

To run automatically, add desired btrfs-sync jobs to cron, typically `/etc/cron.hourly/`:

```bash
# Create a new file in /etc/cron.hourly/, name it something memorable (like
# btrfs-sync), and open it in the 'nano' editor.
sudo nano /etc/cron.hourly/btrfs-sync
```

Copy/paste (shift + ctrl + v in terminal):

```bash
#!/bin/bash
# Sync @home snapshots directory (made by btrfs-snp) to a backup server
# (adjust settings for your specific setup).
local_snapshots_dir="/home/.snapshots/"
remote_snapshots_dir="/mnt/btrfs-pool/@snapshots/devices/mommas-laptop/root/home/snapshots/"
user="sysadmin"
host="raspberry-pi"
/usr/local/sbin/btrfs-sync --quiet --delete "$snapshots_dir" "${user}@${host}:${remote_snapshots_dir}"
```

Save and exit. **Again - you do not need to restart cron.**

**(If you have no set up your backup server yet)**

On backup server (in this case a raspberry pi, which is debian-based):

```bash
# Add a special user on your backup server that your local system can then
# use for any job that may require super user privileges - in this example,
# "sysadmin":
sudo adduser sysadmin

# Add "sysadmin" to the sudo group (this is the same as the wheel group on
# Fedora-like systems):
sudo usermod -aG sudo sysadmin

# Edit the relevant sudo drop-in configuration file to allow "sysadmin" to
# run commands with super-user privileges, WITHOUT a password:
sudo visudo -f /etc/sudoers.d/010_pi-nopasswd

# Copy/paste:
sysadmin ALL=(ALL) NOPASSWD: ALL

# Save and exit.

# To set up passwordless ssh login for "sysadmin" (useful for, say, automating a backup task to run in the background without the user having to type a ppassword every time), first log in as sysadmin with the 'su' (substitute user) command:
su - sysadmin

# Create default directory that ssh uses:
mkdir ${HOME}/.ssh

# Copy existing ssh configuration files from your personal account (because "sysadmin" is attempting to copy files that do not belong to it, you will need to run this command with 'sudo'):
personal_account="<REPLACE WITH USERNAME FOR YOUR PERSONAL ACCOUNT ON BACKUP SERVER HERE>"
sudo cp ${personal_account}/.ssh/* ${HOME}/.ssh/
sudo chown -R sysadmin:sysadmin $HOME/.ssh/*

# Logout. You have added "sysadmin" as a user on your backup server and it's ready to receive commands.
```

On your personal machine / laptop:

```bash
# To allow cron jobs to talk to your backup server, your pc's root user itself will need its own ssh key. You can copy the one your machine's personal account is already using, this will be easier if you log in as root:
su -

personal_account="<PERSONAL USERNAME>"
cd $HOME
mkdir .ssh
cp /home/${personal_account}/.ssh/* ${HOME}/.ssh/

# Make sure root user's $HOME/.ssh/config defines the correct user to log in as:
Host raspberry-pi

    HostName <ip address of raspberry pi here>
    User sysadmin
    Port 22
    IdentityFile ~/.ssh/id_rsa.raspberry-pi

# (I got tired of writing this, I think this is mostly complete)
```

#### Multimedia group

- https://rpmfusion.org/Configuration
- https://rpmfusion.org/CommonBugs
- https://rpmfusion.org/Howto/NVIDIA (see "x86_64 (64bit) users" for 3D acceleration in 32bit packages such as Wine)
- https://trac.ffmpeg.org/wiki/HWAccelIntro#NVENC (optional - for nvidia hardware-accelerated video encoding)
- (note: dnf package "intel-media-driver" covered in Multimedia guide)
- https://rpmfusion.org/Howto/Optimus (optional - with Fedora 25 and later, Optimus devices are supported automatically by default)
- https://rpmfusion.org/Howto/Multimedia
- mpv
- audacity
- audacity: test microphone levels by recording voice, lower if needed
- **(RESTART)**

#### Game group

- dnf (rpmfusion): steam
- steam: tablestop simulator, magic the gathering table workshop download (as a test install)
- steam: helldivers 2
	- in-game settings: windowed mode (gamescope fullscreen shortcut: meta + F)
	- ProtonUp-Qt: `flatpak install flathub net.davidotek.pupgui2`
		- reference: https://flathub.org/apps/net.davidotek.pupgui2
		- Proton-GE
			- reference: https://github.com/GloriousEggroll/proton-ge-custom
	- proton version: GE-Proton9-4 (and up)
	- `sudo dnf install gamemode`
		- reference: https://github.com/FeralInteractive/gamemode
	- `sudo dnf install gamescope`
		- reference: https://github.com/ValveSoftware/gamescope
		- keyboard shortcuts:
			- Super + F : Toggle fullscreen
			- Super + N : Toggle nearest neighbour filtering
			- Super + U : Toggle FSR upscaling
			- Super + Y : Toggle NIS upscaling
			- Super + I : Increase FSR sharpness by 1
			- Super + O : Decrease FSR sharpness by 1
			- Super + S : Take screenshot (currently goes to /tmp/gamescope_$DATE.png)
			- Super + G : Toggle keyboard grab
	- launch options: `gamemoderun gamescope -- %command% --use-d3d11`
- openmw: https://openmw.org/downloads/ (must initialize official morrowind configuration files [read: install and run morrowind] before launching openmw wizard)
- openmw: test launch

#### Chat group

Note: Application launch files (from tarball installs, like the "full" version of discord), which end in `.desktop`, for **all users** go in: `/usr/share/applications`. Application launch files for **a single user** go in that user's: `$HOME/.local/share/applications/`

- discord
	- Note: Use flatpak for convenience / quick setup, otherwise use official tarball for **FULL** installation (screen sharing, game status, etc...)
- signal desktop (flatpak)
- whatsapp desktop (flatpak)

#### Docker group

Note: "Install" docker image repos to `$HOME/Applications`.

- docker engine (NOT "docker desktop" for linux)
	- https://docs.docker.com/engine/install/
	- https://docs.docker.com/engine/install/linux-postinstall/
	- https://docs.docker.com/config/containers/logging/configure/ (/etc/docker/daemon.json - configure "local driver" which rotates logs by default, must recreate containers to use)
	- https://docs.docker.com/config/containers/logging/local/
- repo: gtg-gui (+ desktop entry file)
- repo: minecraft (pending dockerfile re-creation)
- repo: resilio-sync (launch on login w/ kde autostart script)
- repo: resilio-sync-big-boi (on port 8889, same as above)

#### Web app group (chromium)

- ChatGPT
- Gmail
- Google
- Google Calendar
- Notion
- Reclaim
- Todoist
- WaniKani

#### Resilio sync group (main)

***(WARNING: Mind that you pay attention to where you're adding folders within the container web ui! Look for `/resilio-sync` - DO NOT copy/paste paths from host os blindly!)***

- [docker:/resilio-sync] _for_big_boi_use_port_8889
- [docker:/resilio-sync] music (re-sync to iphone when finished re-indexing)
- [docker:/resilio-sync] soccer-ball
- [docker:/resilio-sync] wfpk

#### Resilio sync group (big-boi)

- [docker:/resilio-sync] iso (symlink:big-boi/resilio-sync/iso)
- [docker:/resilio-sync] media (symlink:big-boi/resilio-sync/media)
- [docker:/resilio-sync] vault (symlink:big-boi/resilio-sync/vault)

#### Graphics group

- blender: https://docs.blender.org/manual/en/latest/getting_started/installing/linux.html

#### Virtualization group

- https://docs.fedoraproject.org/en-US/quick-docs/virtualization-getting-started/

Note: Most mount options apply to the whole filesystem and only options in the first mounted subvolume will take effect. This is due to lack of implementation and may change in the future. This means that (for example) you can’t set per-subvolume nodatacow, nodatasum, or compress using mount options. This should eventually be fixed, but it has proved to be difficult to implement correctly within the Linux VFS framework.

Note: Mount options are processed in order, only the last occurrence of an option takes effect and may disable other options due to constraints (see e.g. nodatacow and compress). The output of mount command shows which options have been applied.

`$ chattr +C /dir/file`

__qcow2 supported options:__

nocow
If this option is set to on, it will turn off COW of the file. It’s only valid on btrfs, no effect on other file systems.

Btrfs has low performance when hosting a VM image file, even more when the guest on the VM also using btrfs as file system. Turning off COW is a way to mitigate this bad performance. Generally there are two ways to turn off COW on btrfs:

Disable it by mounting with nodatacow, then all newly created files will be NOCOW.

For an empty file, add the NOCOW file attribute. That’s what this option does.

Note: this option is only valid to new or empty files. If there is an existing file which is COW and has data blocks already, it couldn’t be changed to NOCOW by setting nocow=on. One can issue lsattr filename to check if the NOCOW flag is set or not (Capital ‘C’ is NOCOW flag).

---

By default the system administration is limited to the root user, if you want to enable a regular user you have to proceed as follows:

```bash
# Open the /etc/libvirt/libvirtd.conf file for editing.
sudo nano /etc/libvirt/libvirtd.conf

# Set the domain socket group ownership to libvirt:
# unix_sock_group = "libvirt"

# Adjust the UNIX socket permissions for the R/W socket:
# unix_sock_rw_perms = "0770"

# Start and enable the libvirtd service.
sudo systemctl start libvirtd
sudo systemctl enable libvirtd

# Add user to group (you must log out and log in to apply the changes):
sudo usermod -a -G libvirt $(whoami)
```

Note: To get winget to run, you'll likely need to run manual windows store updates for apps, including App Installer which winget requires to function correctly.

#### "Dual drive" group

Note: This assumes you have two drives in your machine / laptop, typically a main SSD for your OS + software and a spinning disk drive for storing your user data.

- symlink `/home/$USER/Applications` from `/home-ssd/$USER/Applications`
	- you can actually symlink from whever you want, what's important is making sure ALL software (including applications you install in `$HOME`) runs off of the SSD for better performance.
- symlink hidden directories in `$HOME` from ssd for better performance
	- this side-steps physical disk i/o bottleneck for loading of user app settings
- `$HOME` indexing (system settings)
	- leave running overnight, this will take a while on larger data sets...

#### Log group

- log rotation: https://docs.fedoraproject.org/en-US/fedora/latest/system-administrators-guide/monitoring-and-automation/Viewing_and_Managing_Log_Files/#s2-log_rotation

#### "Everything else" group

- ...

#### Raspberry pi group (supplemental)

- run: `curl -sSL https://get.docker.com | sh`
- add btrfs disk drive to `/etc/fstab` with: `subvol=@ds0,defaults,compress=zstd:3,noatime,nossd`
- create rsync cron job (one with PID-based lock function) that pushes `/home-ssd` contents to `$HOME/`
- set up btrfs-snp + btrfs-sync for `@home` snapshot replication to raspberry-pi

From the Fedora KDE 'Spin' to another OS (**TODO WIP...**)
-------------------------------------------------------------------------------

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
