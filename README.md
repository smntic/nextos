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

## Set Up
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
...Coming soon...

