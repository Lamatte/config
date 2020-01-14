set nocompatible
filetype off

set pyxversion=3
set encoding=utf-8

" Setup vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'airblade/vim-rooter'
Plugin 'rust-lang/rust.vim'
Plugin 'autozimu/LanguageClient-neovim' , {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plugin 'junegunn/fzf'
"Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plugin 'roxma/nvim-yarp'
"Plugin 'roxma/vim-hug-neovim-rpc'
" Color schemes
Plugin 'sickill/vim-monokai'
Plugin 'chriskempson/base16-vim'
call vundle#end()
filetype plugin indent on

syntax enable
let base16colorspace=256
colorscheme monokai
"colorscheme base16-atelier-cave
"colorscheme base16-atelier-seaside
"colorscheme base16-atelier-dune
"colorscheme base16-eighties
"colorscheme base16-default-dark

" LightLine configuration
set laststatus=2
set noshowmode

" Numbers on the left.
" Weird 'green' background when I dont set termguicolors
set number
if has("termguicolors")
    "set termguicolors
endif

set hidden

" Language client servers
let g:LanguageClient_loggingFile =  expand('/tmp/LanguageClient.log')
let g:LanguageClient_serverCommands = {
    \ 'rust': ['/usr/bin/rustup', 'run', 'stable', 'rls'],
    \ 'haskell': ['hie-wrapper'],
    \ }
let g:LanguageClient_diagnosticsDisplay = {
    \     1: {
    \         "name": "Error",
    \         "texthl": "ALEError",
    \         "signText": "✖",
    \         "signTexthl": "ErrorMsg",
    \     },
    \     2: {
    \         "name": "Warning",
    \         "texthl": "ALEWarning",
    \         "signText": "⚠",
    \         "signTexthl": "ALEWarningSign",
    \     },
    \     3: {
    \         "name": "Information",
    \         "texthl": "ALEInfo",
    \         "signText": "ℹ",
    \         "signTexthl": "ALEInfoSign",
    \     },
    \     4: {
    \         "name": "Hint",
    \         "texthl": "ALEInfo",
    \         "signText": "➤",
    \         "signTexthl": "ALEInfoSign",
    \     },
    \ }

" Fuzzy finder
set rtp+=~/.vim/bundle/fzf
nnoremap ff :FZF<CR>
