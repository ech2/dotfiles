" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell spelllang=en:
" Plugins {
call plug#begin()

Plug 'VundleVim/Vundle.vim'
Plug 'lervag/vimtex'
Plug 'terryma/vim-multiple-cursors'
Plug 'chriskempson/base16-vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vim-scripts/DrawIt'

call plug#end()
" }
" General {
filetype plugin indent on
set undodir=~/.config/nvim/undodir
set hidden
set history=100
set number
syntax enable
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set nowrap
" }
" UI {
colorscheme base16-grayscale-dark
if has('gui_running')
  set guifont=FiraMono\ 12
  set antialias
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
  set lines=30 columns=80
  set guicursor+=a:blinkon0
endif
" }
" Editing {
set tw=80
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
set spelllang=en_us
" }
" Key bindings {
nnoremap <space> <nop>
let mapleader = " "
" Window navigation
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" }
" File type specific {
" vimtex {
autocmd FileType tex let &l:flp='^\s*\\\(item\|end\|begin\)\s*'
autocmd FileType tex set nowrap spell
" }
" Binary {
" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END
" }
" }
