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
    jetbrains.goland
    du-dust
    fd
    procs
    helix
    fzf
    nodejs_20
    go
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
            let g:airline_theme='papercolor'
            let g:airline#extensions#whitespace#enabled = 0
            let g:airline#extensions#tabline#enabled = 1
            let g:airline#extensions#tabline#show_close_button = 0
            let g:airline#extensions#tabline#tabs_label = ""
            let g:airline#extensions#tabline#buffers_label = ""
            let g:airline#extensions#tabline#fnamemod = ':t'
            let g:airline#extensions#tabline#show_tab_count = 0
            let g:airline#extensions#tabline#show_buffers = 0
            let g:airline#extensions#tabline#tab_min_count = 2
            let g:airline#extensions#tabline#show_splits = 0
            let g:airline#extensions#tabline#show_tab_nr = 0
            let g:airline#extensions#tabline#show_tab_type = 0
          '';
        }
        vim-commentary
        vim-fugitive
        vim-gitgutter
        {
          plugin = catppuccin-nvim;
          config = ''
            syntax enable
            colorscheme catppuccin
          '';
        }
        {
          plugin = nerdtree;
          config = ''
            nnoremap <leader>n :NERDTreeFocus<CR>
            nnoremap <C-n> :NERDTree<CR>
            nnoremap <C-t> :NERDTreeToggle<CR>
            nnoremap <C-f> :NERDTreeFind<CR>
          '';
        }
        vim-nerdtree-tabs
        vim-nerdtree-syntax-highlight
        nerdtree-git-plugin
      ];

      extraConfig = ''
        set number relativenumber
        set cursorline
        set scrolloff=5
        set encoding=UTF-8
      '';
    };

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
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
