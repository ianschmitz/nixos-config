Bootstrap on macOS:

```bash
# Initial bootstrap of nix so we can run nix-darwin after
$ nix --experimental-features "nix-command flakes" build .#darwinConfigurations.ian-macbook-work.system

# Install nix-darwin
$ nix run nix-darwin -- switch --flake ~/.config/nix
```
