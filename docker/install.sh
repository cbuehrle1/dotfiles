#!/usr/bin/env zsh
#
# Docker for Mac
#

BREW_COMMAND=$(which brew)

# Check for Homebrew
if test ! $(which brew)
then
    echo "Please install Homebrew first."
    echo
    echo "See: homebrew/install.sh"
fi

${BREW_COMMAND} install docker --cask

exit 0
