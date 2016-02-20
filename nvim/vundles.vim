set nocompatible              " be iMproved, required
if has('nvim')
    let s:editor_root=expand('~/.nvim')
else
    let s:editor_root=expand('~/.vim')
endif
"set rtp+= s:editor_root.'/bundle/Vundle.vim'
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
"call plug#rc(s:editor_root . '/bundle')
call plug#begin()
" Track the engine.
Plug 'SirVer/ultisnips'
Plug 'michalliu/sourcebeautify.vim'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'benekastah/Neomake'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
    UpdateRemotePlugins
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
"Plug 'Raimondi/delimitMate'
"Plug 'sickill/vim-monokai'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
"Plug 'gmarik/Vundle.vim'
Plug 'lervag/vimtex'
"Plug 'benmills/vimux'
Plug 'tpope/vim-fugitive'
Plug 'rstacruz/sparkup', {'rtp': 'vim/','for': 'html'}
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
"Plug 'scrooloose/syntastic'
Plug 'kien/ctrlp.vim'
"Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'Lokaltog/vim-easymotion'
Plug 'godlygeek/tabular'
"Plug 'tomasr/molokai'
Plug 'flazz/vim-colorschemes'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Anthony25/gnome-terminal-colors-solarized'
"Plug 'kien/rainbow_parentheses.vim'
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
"Plug 'othree/html5.vim'
"Plug 'reedes/vim-thematic'
"Plug 'rking/ag.vim'
"Plug 'mileszs/ack.vim'
Plug 'Valloric/YouCompleteMe', {'do': 'python2 install.py --clang-completer --system-libclang --system-boost'}
call plug#end()            " required
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" see :h vundle for more details or wiki for FAQ
" There goes configuration of plugins
" Even I don't know what's going on there but it's important
" Use <leader>n to toggle NERDTree
nmap <Leader>n <plug>NERDTreeTabsToggle<CR>
"Use Case sensitive sort in NERDTree
let g:NERDTreeCaseSensitiveSort=1
"Makes Hidden file appear in start if hidden files are set to get displayed
let g:NERDTreeSortHiddenFirst=1
" Use WildIgnore to remove some files which are not used ussually and you
" don't want to see them like .git
let g:NERDTreeRespectWildIgnore=1
" Close NERDTree whenever I open a file from it
let g:NERDTreeQuitOnOpen=1
" Don't like to have a statusline in NERDTree tab
let g:NERDTreeStatusline=0
" Set windows size to 20 it's sufficient by defualt NERDTree takes a lot of
" area :-(
let g:NERDTreeWinSize=20
" Remove shitty ~ from NERDTree Tabs infact I want them to be removed vim as
" well
let g:NERDTreeDirArrows=1

"nnoremap <C-n> :NERDTreeToggle<CR>
autocmd QuickFixCmdPost *grep* cwindow

" Syntastic Plugin configuration
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 0
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0

" Ctrl-P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_by_filename = 1

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.git     " MacOSX/Linux
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }


"set encoding=utf-8
" Airline
set laststatus=2
let g:airline_encoding = "utf-8"
"let g:airline_theme = "luna"
let g:airline_powerline_fonts = 1
if isdirectory(expand(s:editor_root."/bundle/vim-airline/"))
            if !exists('g:airline_powerline_fonts')
                " Use the default set of separators with a few customizations
                echom "why?"
                let g:airline_left_sep='>'  " Slightly fancier than '>'
                let g:airline_right_sep='<' " Slightly fancier than '<'
            endif
        endif
" EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap <Leader>s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <Leader><Leader>s <Plug>(easymotion-s2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
"=========================YCM=====================================
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
let g:ycm_global_ycm_extra_conf = s:editor_root."/.ycm_extra_conf.py"
let g:ycm_register_as_syntastic_checker = 0

"=============================Ultisnips===========================
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

"=============================RainBow Parenthesis==================

    "\ ['brown',       'RoyalBlue3'],
    "\ ['darkgray',    'DarkOrchid3'],
    "\ ['gray',        'RoyalBlue3'],
"let g:rbpt_colorpairs = [
    "\ ['Darkblue',    'SeaGreen3'],
    "\ ['darkgreen',   'firebrick3'],
    "\ ['darkcyan',    'RoyalBlue3'],
    "\ ['darkred',     'SeaGreen3'],
    "\ ['darkmagenta', 'DarkOrchid3'],
    "\ ['brown',       'firebrick3'],
    "\ ['black',       'SeaGreen3'],
    "\ ['darkmagenta', 'DarkOrchid3'],
    "\ ['Darkblue',    'firebrick3'],
    "\ ['darkgreen',   'RoyalBlue3'],
    "\ ['darkcyan',    'SeaGreen3'],
    "\ ['darkred',     'DarkOrchid3'],
    "\ ['red',         'firebrick3'],
    "\ ]
"let g:rbpt_max = 16
"let g:rbpt_loadcmd_toggle = 0

"au VimEnter * RainbowParenthesesToggle
""au Syntax * RainbowParenthesesLoadRound
""au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
"RainbowParenthesesLoadBraces
"" Commands
"":RainbowParenthesesToggle       " Toggle it on/off
"":RainbowParenthesesLoadRound    " (), the default when toggling
"":RainbowParenthesesLoadSquare   " []
"":RainbowParenthesesLoadBraces   " {}
"":RainbowParenthesesLoadChevrons " <>