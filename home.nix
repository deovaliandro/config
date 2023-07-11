{ config, pkgs, ... }:

{
  home.username = "deo";
  home.homeDirectory = "/home/deo";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    hugo
    htop
    unzip
    zip
    yt-dlp
    wget
    curl
    neofetch
    trash-cli
    php
    jetbrains.phpstorm
    du-dust
    fd
    procs
    helix
    fzf
    nodejs_20
  ];

  programs.home-manager.enable = true;

  programs = {
    git = {
      package = pkgs.gitAndTools.gitFull;
      enable = true;
      userName = "deovaliandro";
      userEmail = "valiandrod@gmail.com";
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      withPython3 = true;

      plugins = with pkgs.vimPlugins; [
        nvim-surround
        nvim-treesitter
        coc-nvim

        vim-airline
        {
          plugin = vim-airline-themes;
          config = ''
            let g:airline_theme='wombat'
          '';
        }
        {
          plugin = lazy-lsp-nvim;
          type = "lua";
          config = ''
            require("lazy-lsp").setup {}
          '';
        }
        vim-airline-clock
        vim-commentary
        vim-fugitive
        vim-gitgutter
        vim-indent-guides
        {
          plugin = dracula-nvim;
          config = ''
            syntax enable
            colorscheme dracula
          '';
        }
      ];

      extraConfig = ''
        set number relativenumber
        set cursorline
        set scrolloff=5
      '';
    };

    bat = {
      enable = true;

      config = {
        pager = "less -FR";
      };

      themes = {
        dracula = builtins.readFile (pkgs.fetchFromGitHub
          {
            owner = "dracula";
            repo = "sublime"; # Bat uses sublime syntax for its themes
            rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
            sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
          } + "/Dracula.tmTheme");
      };
    };

    exa = {
      enable = true;
      enableAliases = true;
    };

    fish = {
      enable = true;
      shellAbbrs = {
        cp = "cp -iv";
        mv = "mv -iv";
        rm = "trash-put";
        cat = "bat";
        gaa = "git add .";
        ga = "git add -i";
        gcom = "git commit -Ss -am";
        gpush = "git push";
        gpull = "git pull";
        gco = "git checkout";
        gst = "git status";
      };
      interactiveShellInit = ''
        set -gx GEM_HOME $HOME/gems
        set PATH $PATH $HOME/gems/bin
      '';
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        aws.style = "bold #ffb86c";
        cmd_duration.style = "bold #f1fa8c";
        directory.style = "bold #50fa7b";
        hostname.style = "bold #ff5555";
        git_branch.style = "bold #ff79c6";
        git_status.style = "bold #ff5555";
        username = {
          format = "[$user]($style) on ";
          style_user = "bold #bd93f9";
        };
        
        character = {
          success_symbol = "[λ](bold #f8f8f2)";
          error_symbol = "[λ](bold #ff5555)";
        };
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

  };
}
