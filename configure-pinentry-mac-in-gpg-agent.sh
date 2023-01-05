#!/bin/zsh

# Fail if any subcommands fail. See https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
set set -euo pipefail

# check if pinentry-mac is installed and exists in PATH
PINENTRY_APP_NAME='pinentry-mac'

which $PINENTRY_APP_NAME > /dev/null
PINENTRY_APP_INSTALLED_EXIT_CODE=$? # get exit code of the latest command
if [ $PINENTRY_APP_INSTALLED_EXIT_CODE != 0 ]; then
    echo "Cannot find $PINENTRY_APP_NAME in PATH"
    echo "Please install a suitable program, eg. pinentry-mac"
    exit 1
fi

echo "Creating gnupg configuration with pinentry configured"
mkdir -p ~/.gnupg &&
  echo "pinentry-program $(which $PINENTRY_APP_NAME)" >> ~/.gnupg/gpg-agent.conf &&
  gpgconf --kill gpg-agent

echo "Everything done ✓"