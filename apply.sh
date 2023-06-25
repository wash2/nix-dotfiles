#!/bin/sh
pushd $HOME/.dotfiles
sudo nixos-rebuild switch --flake .#
popd
