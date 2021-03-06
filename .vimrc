colorscheme desert

" XXX: First, install pathogen. =)
" Using Pathogen to manage plugins. Easier than doing it manually.
" These functions read all plugins and update tags (help) files.
execute pathogen#infect()
" May be need to disable later.
execute pathogen#helptags()

" Coder's little helpers
filetype plugin on
filetype indent on

syntax on
set foldmethod=syntax
set hlsearch

set laststatus=2
set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"\[%d/%m/%Y-%H:%M\]\")}%=\ col:%c%V\ ascii:%b\ pos:%o\ lin:%l\/%L\ %P

set list listchars=tab:>-,trail:·,precedes:<,extends:>
highlight SpecialKey ctermfg=8

" Higlight big lenght of lines
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

" Change tabbar color
highlight TabLineFill ctermfg=DarkYellow
highlight TabLine ctermbg=DarkYellow ctermfg=Gray
highlight TabLineSel ctermbg=DarkYellow ctermfg=Black

" Change statusline color
highlight StatusLine ctermbg=Black ctermfg=DarkYellow

let g:clang_complete_auto = 1
let g:clang_use_library = 1
let g:clang_debug = 1
let g:clang_library_path = '/usr/lib'
let g:clang_hl_errors = 1
let g:clang_close_prewiev = 1

" Change style for some filetypes
autocmd FileType cpp setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType hs setlocal shiftwidth=4 tabstop=4 expandtab
" Only for work, so I need disable this at home sometime
autocmd FileType python setlocal shiftwidth=4 tabstop=4 expandtab
