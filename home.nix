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
        nvim-autopairs
        vim-airline
        vim-autoformat
        coc-nvim
        vim-devicons
        {
          plugin = vim-airline-themes;
          config = ''
            let g:airline_powerline_fonts = 1
            set t_Co=256
            let g:airline#extensions#tabline#enabled = 1
            let g:airline#extensions#tabline#fnamemod = ':t'
	        let g:airline#extensions#branch#enable = 1
	        let g:airline#extensions#whitespace#enabled = 0
	        let g:airline#extensions#tabline#buffer_idx_mode = 1
	        nmap <C-Left> :bp<CR>
	        nmap <C-Right> :bn<CR>
          '';
        }
        {
            plugin = vim-unimpaired;
            config = ''
	            nmap <C-k> [e
	            nmap <C-j> ]e
	        '';
	    }
        {
          plugin = gruvbox-nvim;
          config = ''
            syntax enable
            colorscheme gruvbox
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
	    set nohlsearch
    	set expandtab ts=4 sw=4 ai
      '';
    };

    bat = {
      enable = true;
      themes = {
        dracula = builtins.readFile (pkgs.fetchFromGitHub {
	  owner = "dracula";
	  repo = "sublime"; # Bat uses sublime syntax for its themes
	  rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
	  sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
	} + "/Dracula.tmTheme");
      };
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
        set -Ux TERM screen-256color-bce
        set PATH $PATH $HOME/.local/bin
      '';
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      enableTransience = true;
      settings = {
        aws = { disabled = true; };
        gcloud = { disabled = true; };
        
        cmd_duration.style = "#f1fa8c";
        directory.style = "#50fa7b";
        hostname.style = "#ff5555";
       
        git_status = {
            ahead = "⇡($count)";
            diverged = "⇕⇡($ahead_count)⇣($behind_count)";
            behind = "⇣($count)";
            modified = "!($count)";
            staged = "[++($count)](green)";
        };

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

    tmux = {
      enable = true;
      mouse = true;
      shell = "${pkgs.fish}/bin/fish";
      terminal = "tmux-256color";
      historyLimit = 10000;
      clock24 = true;
      aggressiveResize = true;

      plugins = with pkgs; [
        {
            plugin = tmuxPlugins.tmux-colors-solarized;
            extraConfig = "set -g @colors-solarized '256'";
        }
      ];

      extraConfig = ''
      '';
    };
  };
}
