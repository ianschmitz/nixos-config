{ config, pkgs, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "23.11";
  home.packages = with pkgs; [
    curl
    fd
    lazygit
    less
    nodejs_20
    ripgrep
    wget
    zellij
  ];
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
  };

  programs.bat.enable = true;
  programs.bat.config.theme = "TwoDark";

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  programs.eza.enable = true;

  programs.git.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.shellAliases = {
    ls = "ls --color=auto -F";
    nixswitch = "darwin-rebuild switch --flake ~/Code/nix/.#";
    nixup = "pushd ~/Code/nix; nix flake update; nixswitch; popd";
  };

  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      return {
        enable_tab_bar = false,
        font = wezterm.font("MesloLGS Nerd Font Mono"),
        font_size = 16.0,
        color_scheme = 'Catppuccin Mocha'
      }
    '';
  };

  home.file = {
    ".inputrc".source = ./dotfiles/.inputrc;
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/Users/ian/Code/nix/modules/home-manager/dotfiles/nvim";
  };
}
