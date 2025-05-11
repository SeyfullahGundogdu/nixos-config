# nixos-config
My personal NixOS Config

run these to install 
`sudo nix run --extra-experimental-features "nix-command flakes"  github:nix-community/disko -- --mode disko ./disko.nix`
`sudo nixos-install --flake .#kurohitsugi`

I aliased yolo to `sudo nixos-rebuild boot --flake .#kurohitsugi`

change the hostname to your preference and update alias within user config.


## Some Notes:

Spotify:
>https://wiki.archlinux.org/title/Spotify#/usr/lib/libcurl-gnutls.so.4_error

Pywal:

>Enabling pywal will add a little activation script for making terminal themes persist between boots. Remove .cache/wal/sequences file after you run wal if you don't want that.