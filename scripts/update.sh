#!/bin/zsh

# "update.sh"
# by David Lynn Skinner
# for Davsk Ltd Co

# Update script assumes all essentials are installed.

# case OS
case "$OSTYPE" in
    darwin*)
        echo "Update Darwin MacOS"
        sudo softwareupdate -i -a -R
        brew install mas
        ;;
    linux*)
        echo "Update Linux."
        sudo pacman -Syu
        ;;
    dragonfly*|freebsd*|netbsd*|openbsd*)
        echo Update
        ;;
    *)
        echo $OSTYPE "is Not Supported!"
        exit
        ;;
esac

echo "Update HomeBrew"
brew update
brew upgrade

echo "Update submodules"
git submodule update --remote --merge

echo "Update GoLang"
pushd scripts/update-golang
git pull
sudo ./update-golang.sh

echo "Update Hugo"
CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest

echo "Update mods"
popd

echo "Update Go modules"
go get -u

echo "Update Hugo modules"
hugo mod get -u

echo "Update NPM"
npm update
