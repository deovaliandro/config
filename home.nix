{ config, pkgs, ... }:

{
    home.username = "deo";
    home.homeDirectory = "/home/deo";
    nixpkgs.config.allowUnfree = true;
    home.stateVersion = "23.05";

    home.packages = with pkgs; [
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
        fzf
        nodejs_20
        go
        ranger
    ];

    programs.home-manager.enable = true;

    programs = {
        emacs = {
            enable = true;
            extraConfig = ''
                (setq inhibit-splash-screen t)
                (blink-cursor-mode 0)
                (tool-bar-mode 0)
                (set-frame-font "IosevkaTerm Nerd Font Mono" nil t)
                (setq colom-number-mode t)
                (setq ring-bell-function 'ignore)
            '';
        };

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
	    	    vim-gitgutter
                vim-surround
                nvim-autopairs
                nvim-web-devicons
                vim-airline
                vim-autoformat
                coc-nvim
                vim-devicons
                nvim-treesitter.withAllGrammars
                vim-nerdtree-tabs
                vim-nerdtree-syntax-highlight
                nerdtree-git-plugin
                vim-startify
                vim-smoothie
                {
                    plugin = neo-tree-nvim;
                    config = ''
                        nnoremap <silent> <C-n> <cmd>Neotree source=filesystem reveal=true position=float<CR>
                    '';
                }
                plenary-nvim
                windows-nvim
                {
                    plugin = chadtree;
                    config = ''
                        nnoremap <leader>v <cmd>CHADopen<cr>
                    '';
                }
                {
                    plugin = vim-airline-themes;
                    config = ''
                        let g:airline_powerline_fonts = 1
                        set t_Co=256
                        let g:airline#extensions#branch#enable = 1
                        let g:airline#extensions#whitespace#enabled = 0
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
                    plugin = melange-nvim;
                    config = ''
                        syntax enable
                        set termguicolors
                        colorscheme melange
                        '';
                }
                {
                    plugin = barbar-nvim;
                    config = ''
                        nnoremap <silent> <A-,> <Cmd>BufferPrevious<CR>
                        nnoremap <silent> <A-<> <Cmd>BufferMovePrevious<CR>
                        nnoremap <silent> <A-.> <Cmd>BufferNext<CR>
                        nnoremap <silent> <A->> <Cmd>BufferMoveNext<CR>
                        nnoremap <silent> <A-1> <Cmd>BufferGoto 1<CR>
                        nnoremap <silent> <A-2> <Cmd>BufferGoto 2<CR>
                        nnoremap <silent> <A-3> <Cmd>BufferGoto 3<CR>
                        nnoremap <silent> <A-4> <Cmd>BufferGoto 4<CR>
                        nnoremap <silent> <A-5> <Cmd>BufferGoto 5<CR>
                        nnoremap <silent> <A-6> <Cmd>BufferGoto 6<CR>
                        nnoremap <silent> <A-7> <Cmd>BufferGoto 7<CR>
                        nnoremap <silent> <A-8> <Cmd>BufferGoto 8<CR>
                        nnoremap <silent> <A-9> <Cmd>BufferGoto 9<CR>
                        nnoremap <silent> <A-0> <Cmd>BufferLast<CR>
                        nnoremap <silent> <A-p> <Cmd>BufferPin<CR>
                        nnoremap <silent> <A-c> <Cmd>BufferClose<CR>
                        nnoremap <silent> <A-s-c> <Cmd>BufferRestore<CR>
                        nnoremap <silent> <C-p> <Cmd>BufferPick<CR>
                        nnoremap <silent> <C-p> <Cmd>BufferPickDelete<CR>
                        nnoremap <silent> <Space>bb <Cmd>BufferOrderByBufferNumber<CR>
                        nnoremap <silent> <Space>bd <Cmd>BufferOrderByDirectory<CR>
                        nnoremap <silent> <Space>bl <Cmd>BufferOrderByLanguage<CR>
                        nnoremap <silent> <Space>bw <Cmd>BufferOrderByWindowNumber<CR>
                    '';
                }
            ];

            extraConfig = ''
                set number relativenumber
                set nohlsearch
                set expandtab ts=4 sw=4 ai
                set cc=80
                let g:loaded_netrw       = 1
                let g:loaded_netrwPlugin = 1
                '';
        };

        bat = {
            enable = true;
            themes = {
                dracula = builtins.readFile (pkgs.fetchFromGitHub {
                        owner = "dracula";
                        repo = "sublime";
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
                ga = "git add";
                gcom = "git commit -Ss -am";
                gpush = "git push";
                gpull = "git pull";
                gco = "git checkout";
                gst = "git status";
            };
            interactiveShellInit = ''
                set -gx GEM_HOME $HOME/gems
                set PATH $PATH $HOME/gems/bin
                set PATH $PATH $HOME/.local/bin
                set -U fish_greeting
                '';
        };

        starship = {
            enable = true;
            enableFishIntegration = true;
            enableTransience = true;
            settings = {
                directory.fish_style_pwd_dir_length = 1;
                directory.truncation_length = 2;

                git_commit = {
                    commit_hash_length = 7;
                    format = "[($hash$tag)]($style) ";
                    style = "green bold";
                    disabled = false;
                };

                cmd_duration.style = "#f1fa8c";
                directory.style = "#50fa7b";
                hostname.style = "#ff5555";

                git_branch = {
                    style = "#ff79c6";
                    symbol = " ";
                };

                git_status = {
                    ahead = "⇡($count)";
                    diverged = "⇕⇡($ahead_count)⇣($behind_count)";
                    behind = "⇣($count)";
                    modified = "!($count)";
                    staged = "[++($count)](green)";
                };

                memory_usage = {
                    disabled = false;
                };

                username = {
                    format = "[$user]($style) on ";
                    style_user = "#bd93f9";
                };

                character = {
                    success_symbol = "[λ](#f8f8f2)";
                    error_symbol = "[λ](#ff5555)";
                };
            };
        };

        zoxide = {
            enable = true;
            enableFishIntegration = true;
        };

        tmux = {
            baseIndex = 1;
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
                set -g status-right '#(date +"%%d-%%m-%%Y %%H:%%M:%%S")'
                set -sg escape-time 0
            '';
        };
    };
}
