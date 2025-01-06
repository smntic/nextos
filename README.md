# nextOS
This is a work-in-progress NixOS configuration.

## Installation
1. Clone the repository
```bash
git clone https://github.com/smnast/nextos
```
2. Change directory
```bash
cd nextos
```
3. Run the install script
```bash
./utils/install.sh <HOSTNAME>
```
4. Profit

## Setup
1. For each git user, run
```bash
./utils/git_user.sh
```
2. Copy the public key to your git platforms

3. In the nextOS repository (i.e. probably `/etc/nixos`), run
```bash
./utils/git_repo.sh
```
to set the repository to the correct (SSH) remote URL.

3. Profit

## Technical Description

The configuration is designed with two core principles in mind:
1. Make it easy to create new hosts and users
2. Keep each user's configuration simple

To accomplish this, every application, program, service, etc. is installed via a
module, and all modules are trivially accessible by all hosts and users.

For instance, enabling firefox is as simple as
```nix
{
  modules.firefox.enable = true;
}
```
Maybe a host wants obs for the system? Instead of searching for if it should be
`programs.obs.enable = true` or `environment.systemPackages = [ pkgs.obs ]`,
nextOS keeps it simple:
```nix
{
  modules.obs.enable = true;
}
```

For per-user configuration, programs are accessible through `homeModules`:
```nix
{
  homeModules.gammastep.enable = true;
}
```

Thus, there are two sets of modules:
1. **"Home Modules"** available through `homeModules`, which are installed through
home-manager and should be placed in a user's `home.nix` file
2. **"Modules"** available through `modules`, which are installed system-wide
through NixOS configuration and should be in a host's `configuration.nix` file.

Note that most home modules are currently designed to work for my setup, and
do not support as much customization as NixOS modules. For example, enabling
zsh through `homeModules.zsh.enable = true` will enable my p10k theme, keybinds, etc.
This may be improved in the future.

There are 4 key files for each configuration:
1. **`configuration.nix`** manages the system-wide configuration per host,
including all modules and other global config (that sit temporarily in this file until
moved properly into modules).
2. **`disko.nix`** declaratively defines the partitioning and formatting steps
during installation. It's rarely necessary to do more than a small tweak of
the [sample configuration](https://github.com/nix-community/disko).
3. **`user.nix`** this file should contain any NixOS configuration that is
specific to the user, such as initial password and groups.
4. **`home.nix`** defines all home-manager configuration for the user.

That's it. For example, to define an entirely new host
1. Add a new directory to `hosts`
2. Add a `configuration.nix` file and configuration the system through `modules`
3. Add a `disko.nix` file to define the partitioning and formatting steps
4. Add a `users` directory with user configuration

To create a new user
1. Add a new directory to `users`
2. Add a `user.nix` file and define the user in NixOS configuration
3. Add a `home.nix` file and configuration the user through `homeModules`

I wasn't kidding about the core principles. How do I do this? With `flake.nix`.
Other than sourcing flakes in the `inputs` attribute set, the system flake
iterates through all the folders in `hosts` and makes a NixOS configuration for
each one. Within each host, the flake iterates through all users in the `users`
directory and creates a new user for each. All the ugly importing is done here
to keep the actual configuration as simple as possible.

Finally, the `install.sh` script automates the remaining manual processes
with a simple shell script. It runs the `disko.nix` configuration, creates necessary
folders, copies over the nextOS files and automagically creates a `hardware-configuration.nix`,
which, of course, is automagically imported in `flake.nix`.

