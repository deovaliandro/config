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
            jetbrains.webstorm
            jetbrains.idea-ultimate
            jetbrains.goland
            jetbrains.datagrip
            jetbrains.clion
            du-dust
            fd
            procs
            helix
            fzf
            nodejs_20
            go
            kitty
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
                nvim-web-devicons
                vim-airline
                vim-autoformat
                coc-nvim
                vim-devicons
                vim-nerdtree-tabs
                vim-nerdtree-syntax-highlight
                nerdtree-git-plugin
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
                    plugin = neovim-ayu;
                    config = ''
                        syntax enable
                        colorscheme ayu-mirage
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
                {
                    plugin = barbar-nvim;
                    config = ''
                        nnoremap <silent>    <A-,> <Cmd>BufferPrevious<CR>
                        nnoremap <silent>    <A-.> <Cmd>BufferNext<CR>

                        nnoremap <silent>    <A-<> <Cmd>BufferMovePrevious<CR>
                        nnoremap <silent>    <A->> <Cmd>BufferMoveNext<CR>

                        nnoremap <silent>    <A-1> <Cmd>BufferGoto 1<CR>
                        nnoremap <silent>    <A-2> <Cmd>BufferGoto 2<CR>
                        nnoremap <silent>    <A-3> <Cmd>BufferGoto 3<CR>
                        nnoremap <silent>    <A-4> <Cmd>BufferGoto 4<CR>
                        nnoremap <silent>    <A-5> <Cmd>BufferGoto 5<CR>
                        nnoremap <silent>    <A-6> <Cmd>BufferGoto 6<CR>
                        nnoremap <silent>    <A-7> <Cmd>BufferGoto 7<CR>
                        nnoremap <silent>    <A-8> <Cmd>BufferGoto 8<CR>
                        nnoremap <silent>    <A-9> <Cmd>BufferGoto 9<CR>
                        nnoremap <silent>    <A-0> <Cmd>BufferLast<CR>

                        nnoremap <silent>    <A-p> <Cmd>BufferPin<CR>

                        nnoremap <silent>    <A-c> <Cmd>BufferClose<CR>
                        nnoremap <silent>    <A-s-c> <Cmd>BufferRestore<CR>

                        nnoremap <silent> <C-p>    <Cmd>BufferPick<CR>
                        nnoremap <silent> <C-p>    <Cmd>BufferPickDelete<CR>

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
                directory.fish_style_pwd_dir_length = 1;
                directory.truncation_length = 2;
                battery = {
                    charging_symbol = " ";
                    discharging_symbol = " ";
                    empty_symbol = " ";
                    full_symbol = " ";
                    unknown_symbol = " ";
                    display = [
                    {
                        threshold = 100;
                    }
                    ];
                };

                git_commit = {
                    commit_hash_length = 7;
                    format = "[($hash$tag)]($style) ";
                    style = "green bold";
                    only_detached = true;
                    disabled = false;
                    tag_symbol = " 🏷  ";
                    tag_disabled = true;
                };

                aws = { disabled = true; };
                gcloud = { disabled = true; };

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

                status = {
                    map_symbol = true;
                    not_executable_symbol = "🚫";
                    not_found_symbol = "🔍";
                    pipestatus = false;
                    pipestatus_format = "[$pipestatus] => [$symbol$common_meaning$signal_name$maybe_int]($style)";
                    pipestatus_separator = "|";
                    recognize_signal_code = true;
                    signal_symbol = "⚡";
                    style = "bold red bg:blue";
                    success_symbol = "🟢 SUCCESS";
                    symbol = "🔴 ";
                    disabled = true;
                };

                sudo = {
                    format = "[as $symbol]($style)";
                    symbol = "🧙 ";
                    style = "bold blue";
                    allow_windows = false;
                    disabled = true;
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
