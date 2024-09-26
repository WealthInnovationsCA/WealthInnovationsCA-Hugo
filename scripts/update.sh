#!/usr/bin/zsh

# "update.sh"
# by David Lynn Skinner
# for Davsk Ltd Co

# Update scrip assumes all essentials are installed.

if whereis softwareupdate >/dev/null; then
  echo "Update MacOs."
  sudo softwareupdate -i -a -R
else
  echo "Update Linux."
  sudo apt update
  sudo apt upgrade
fi

echo "Update HomeBrew"
brew update
brew upgrade

echo "Update GoLang"
cd ~/Documents/GitHub/update-golang
sudo ./update-golang.sh

echo "Update Hugo"
CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest
cd ../WealthInnovationsCA/WealthInnovationsCA-Hugo
go get -u
hugo mod get -u
