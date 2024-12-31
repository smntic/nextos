#!/usr/bin/env bash

# Generate SSH key
EMAIL=$(git config user.email)
yes "" | ssh-keygen -N '' -t ed25519 -C "${EMAIL}"

# Show key
echo "Copy the following public key and add it to your GitHub account:"
cat ~/.ssh/id_ed25519.pub

# Show where to find the key
echo "Alternatively, run \`cat ~/.ssh/id_ed25519.pub\`"

