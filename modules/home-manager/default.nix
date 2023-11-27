{ config, pkgs, repoPath, ... }: {
    # Don't change this when you change package input. Leave it alone.
    home.stateVersion = "23.11";
    home.packages = with pkgs; [
        btop
        cargo
        curl
        fd
        lazygit
        less
        nodejs_20
        ripgrep
        rustc
        wget
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

    programs.pyenv = {
        enable = true;
        enableZshIntegration = true;
        rootDirectory = "${config.home.homeDirectory}/.pyenv";
    };

    programs.starship = {
        enable = true;
        enableZshIntegration = true;
    };

    programs.tmux = {
        enable = true;
        # Start windows at 1 instead of 0.
        baseIndex = 1;
        # Required by neovim. Shows up in :checkhealth
        escapeTime = 0;
        # This along with 'terminal' enables true color support.
        extraConfig = ''
            set -as terminal-overrides ",*-256color*:RGB"
            set -g @catppuccin_flavour 'mocha'
        '';
        historyLimit = 50000;
        keyMode = "vi";
        mouse = true;
        prefix = "C-a";
        plugins = with pkgs; [
            tmuxPlugins.catppuccin
        ];
        terminal = "screen-256color";
        tmuxp.enable = true;
    };

    programs.wezterm = {
        enable = true;
        enableZshIntegration = true;
        extraConfig = ''
            return {
                hide_tab_bar_if_only_one_tab = true,
                font_size = 15.0,
                front_end = "WebGpu",
                color_scheme = 'Catppuccin Mocha'
            }
        '';
    };

    programs.zellij = {
        enable = false;
        # Starts zellij when terminal is launched if enabled.
        enableZshIntegration = false;
        settings = {
            theme = "catppuccin-mocha";
        };
    };

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;
        shellAliases = {
            ls = "ls --color=auto -F";
            ll = "ls -alF";
            nixswitch = "darwin-rebuild switch --flake ~/Code/nix/.#";
            nixup = "pushd ~/Code/nix; nix flake update; nixswitch; popd";
        };
    };

    home.file = {
        ".inputrc".source = ./dotfiles/.inputrc;
        # Need to use mkOutOfStoreSymlink to keep the recursive file ownership
        # set to the current user which allows neovim to update the files within.
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink (repoPath + "/modules/home-manager/dotfiles/nvim");
    };
}
