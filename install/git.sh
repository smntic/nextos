#!/usr/bin/env bash
# Generate SSH key
yes "" | ssh-keygen -N '' -t ed25519 -C "simonashton.dev@gmail.com"

# Show key
echo "Copy the following public key and add it to your GitHub account:"
cat ~/.ssh/id_ed25519.pub

# Show where to find the key
echo "Alternatively, run \`cat ~/.ssh/id_ed25519.pub\`"

# Change the resitory origin URL to ssh
git remote set-url origin git@github.com:smnast/nextos.git
echo "...Changed the repository to use ssh, so you can push changes!"

