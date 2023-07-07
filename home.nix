{ config, pkgs, ... }:

{
    home.username = "deo";
    home.homeDirectory = "/home/deo";
    nixpkgs.config.allowUnfree = true;
    home.stateVersion = "23.05";

    home.packages = with pkgs; [
        # font
        emojione
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        fira
        fira-code
        fira-mono
        iosevka
        hack-font
        terminus_font
        anonymousPro
        freefont_ttf
        corefonts
        dejavu_fonts
        inconsolata
        ttf_bitstream_vera
        meslo-lgs-nf
        hackgen-nf-font
        inconsolata-nerdfont
        meslo-lg

        # dev
        htop
        unzip
        zip
        yt-dlp
        wget
        curl

        neofetch
        trash-cli
    ];

    home.file = {
    };

    home.sessionVariables = {
        # EDITOR = "emacs";
    };

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
                neovim-sensible
                nvim-surround
                nvim-treesitter
                nvim-cmp
                vim-airline
                vim-airline-themes
                vim-airline-clock
                vim-commentary
                vim-fugitive
                vim-gitgutter
                vim-indent-guides
                dracula-nvim
            ];

            extraConfig = ''
                syntax enable
                set number relativenumber
                set cursorline
                set scrolloff=5

                let g:airline_theme='wombat'
            '';
        };

    bat = {
        enable = true;

        config = {
            pager = "less -FR";
        };

        themes = {
            dracula = builtins.readFile (pkgs.fetchFromGitHub {
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

    };
}
