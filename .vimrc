if &compatible
    set nocompatible " Be iMproved
endif

" Required:
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('~/.cache/dein')

" Let dein manage dein
call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
endif

" Add or remove your plugins here like this:
call dein#add('easymotion/vim-easymotion')
call dein#add('tpope/vim-surround')
call dein#add('vim-scripts/vim-auto-save')
call dein#add('altercation/vim-colors-solarized')
call dein#add('lifepillar/vim-solarized8')
call dein#add('tomtom/tcomment_vim')
call dein#add('Yggdroot/indentLine')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('bronson/vim-trailing-whitespace')
call dein#add('dhruvasagar/vim-table-mode')
call dein#add('scrooloose/nerdtree')
call dein#add('osyo-manga/vim-anzu')
call dein#add('vim-syntastic/syntastic')
call dein#add('autozimu/LanguageClient-neovim', {
            \ 'rev': 'next',
            \ 'build': 'bash install.sh',
            \ })
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/echodoc.vim')
call dein#add('liuchengxu/vista.vim')
call dein#add('SirVer/ultisnips')
call dein#add('honza/vim-snippets')
call dein#add('airblade/vim-gitgutter')
call dein#add('vim-autoformat/vim-autoformat')
" call dein#add('cacharle/c_formatter_42.vim')
" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable
set number
" let g:solarized_termcolors=256
let g:solarized_termtrans=1
set background=dark
colorscheme solarized8

" If you want to install not installed plugins on startup.
"if dein#check_install()
" call dein#install('altercation/vim-colors-solarized')
call dein#add('junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' })
call dein#add('junegunn/fzf.vim')
"endif


set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set encoding=utf-8
set showmatch
set shortmess-=S
set cursorline
set ignorecase
set smartcase
set hlsearch
set whichwrap=b,s,h,l,<,>,[,],~
set clipboard+=unnamed,autoselect
setlocal spell spelllang=en_us


"-------------------------------------------------------------------------------
" Restore the last cursor position.
"-------------------------------------------------------------------------------
if has("autocmd")
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                \   exe "normal! g'\"" |
                \ endif
endif


"-------------------------------------------------------------------------------
" mapleader
"-------------------------------------------------------------------------------
let mapleader = ','


"-------------------------------------------------------------------------------
" fzf
"-------------------------------------------------------------------------------
set rtp+=/goinfre/$USER/.brew/opt/fzf
nnoremap <Leader>f :FZF<CR>
let $FZF_DEFAULT_OPTS = '--preview "bat --style=numbers --color=always --line-range :500 {}"'
nnoremap <silent> <Leader>r :<C-u>silent call <SID>find_rip_grep()<CR>

function! s:find_rip_grep() abort
    call fzf#vim#grep(
                \   'rg --ignore-file ~/.ignore --column --line-number --no-heading --hidden --smart-case .+',
                \   1,
                \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%', '?'),
                \   0,
                \ )
endfunction


"-------------------------------------------------------------------------------
" aut_save
"-------------------------------------------------------------------------------
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0


"-------------------------------------------------------------------------------
" vim-table-mode
"-------------------------------------------------------------------------------
function! s:isAtStartOfLine(mapping)
    let text_before_cursor = getline('.')[0 : col('.')-1]
    let mapping_pattern = '\V' . escape(a:mapping, '\')
    let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
    return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
            \ <SID>isAtStartOfLine('\|\|') ?
            \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
            \ <SID>isAtStartOfLine('__') ?
            \ '<c-o>:silent! TableModeDisable<cr>' : '__'

let g:table_mode_corner = '|'


"-------------------------------------------------------------------------------
" NERDTree
"-------------------------------------------------------------------------------
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <Leader>n :NERDTreeToggle<CR>


"-------------------------------------------------------------------------------
" Show zenkaku spaces
"-------------------------------------------------------------------------------
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif


"-------------------------------------------------------------------------------
" vim-anzu
"-------------------------------------------------------------------------------
" mapping
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" clear status
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
" statusline
set statusline=%{anzu#search_status()}
if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif


"-------------------------------------------------------------------------------
" syntastic
"-------------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler="clang++"
let g:syntastic_cpp_compiler_options=" -std=c++98"
" let g:syntastic_cpp_compiler_options=" -std=c++11"
" let g:syntastic_cpp_compiler_options=" -std=c++14"
" let g:syntastic_cpp_compiler_options=" -std=c++17"
let g:syntastic_cpp_cpplint_exec = 'cpplint'
let g:syntastic_cpp_checkers = ['cpplint', 'gcc']
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
" let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1


"-------------------------------------------------------------------------------
" LanguageClient-neovim: LSP client
" ccls: LSP server
"-------------------------------------------------------------------------------
let g:LanguageClient_serverCommands = {
            \ 'c': ['ccls'],
            \ 'cpp': ['ccls'],
            \ }

nmap <F5> <Plug>(lcn-menu)
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_rename()<CR>


"-------------------------------------------------------------------------------
" deoplete
"-------------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1


"-------------------------------------------------------------------------------
" echodoc
"-------------------------------------------------------------------------------
" Or, you could use neovim's floating text feature.
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'echo'
" let g:echodoc#type = 'popup'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu


"-------------------------------------------------------------------------------
" vista.vim
"-------------------------------------------------------------------------------
function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Ensure you have installed some decent font to show these pretty symbols, then you can en able icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish
.
let g:vista#renderer#icons = {
            \   "function": "\uf794",
            \   "variable": "\uf71b",
            \  }


"----------------------------------------------------------
" ultisnips
"----------------------------------------------------------
let g:UltiSnipsUsePythonVersion    = 3
let g:UltiSnipsEditSplit           = 'normal'
let g:UltiSnipsSnippetDirectories  = ['~/.cache/dein/repos/github.com/honza/vim-snippets/UltiSnips']
let g:UltiSnipsEnableSnipMate      = 0
let g:UltiSnipsExpandTrigger       = '<c-k>'
let g:UltiSnipsJumpForwardTrigger  = '<c-f>'
let g:UltiSnipsJumpBackwardTrigger = '<c-b>'
command! SNIP UltiSnipsEdit


"----------------------------------------------------------
" vim-airline
"----------------------------------------------------------
let g:airline_theme = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1


"----------------------------------------------------------
" Buffer
"----------------------------------------------------------
"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>
"" Close buffer
noremap <leader>c :bd<CR>


"----------------------------------------------------------
" vim-easymotion
"----------------------------------------------------------
" <Leader><Leader>s Find and move by {char}
" <Leader><Leader>w Move to {word} below
" <Leader><Leader>b Move to {word} above
" <Leader><Leader>e Move to the end of {word} below
" <Leader><Leader>ge Move to the end of {word} above
" <Leader><Leader>f{char} Move to input {char} below
" <Leader><Leader>F{char} Move to input {char} above

" <Leader>f{char} to move to {char}
map  <Leader>F <Plug>(easymotion-bd-f)
nmap <Leader>F <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
" nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>s <Plug>(easymotion-overwin-f2)
" nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)
" Move to line below
map <Leader>j <Plug>(easymotion-j)
" Move to line above
map <Leader>k <Plug>(easymotion-k)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Search and move by any number of {char}
nmap g/ <Plug>(easymotion-sn)


"----------------------------------------------------------
" c_formatter_42.vim
"----------------------------------------------------------
" let g:c_formatter_42_set_equalprg=1
" let g:c_formatter_42_format_on_save=1


"----------------------------------------------------------
" vim-autoformat
"----------------------------------------------------------
let g:python3_host_prog="/Users/solareenlo/.brew/bin/python3"
au BufWrite * :Autoformat


"----------------------------------------------------------
" Window
"----------------------------------------------------------
noremap <leader>h <C-w>h
noremap <leader>l <C-w>l
noremap <leader>j <C-w>j
noremap <leader>k <C-w>k
