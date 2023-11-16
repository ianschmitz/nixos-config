# Dotfiles

## Bootstrap on macOS

```bash
# Initial bootstrap of nix so we can run nix-darwin after
nix --experimental-features "nix-command flakes" build .#darwinConfigurations.ian-macbook-work.system

# Install nix-darwin
nix run nix-darwin -- switch --flake ~/.config/nix
```

## Making changes to nix/home-manager config

1. Edit config files
2. Run `nixswitch` (alias defined in [modules/home-manager/default.nix](modules/home-manager/default.nix))

## Updating nix packages

```bash
nixup
```
