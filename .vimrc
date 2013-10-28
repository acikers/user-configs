colorscheme desert

" XXX: First, install pathogen. =)
" Using Pathogen to manage plugins. Easier than doing it manually.
" These functions read all plugins and update tags (help) files.
execute pathogen#infect()
" May be need to disable later.
execute pathogen#helptags()

syntax on
set foldmethod=syntax
set hlsearch

set laststatus=2
set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%d/%m/%Y-%H:%M\")}%=\ col:%c%V\ ascii:%b\ pos:%o\ lin:%l\,%L\ %P

set list listchars=tab:>-,trail:·,precedes:<,extends:>,eol:¶
