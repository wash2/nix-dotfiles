#!/bin/sh
pushd $HOME/.dotfiles
sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
popd
