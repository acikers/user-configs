colorscheme desert
syntax on
set foldmethod=syntax
set hlsearch

set laststatus=2
set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%d/%m/%Y-%H:%M\")}%=\ col:%c%V\ ascii:%b\ pos:%o\ lin:%l\,%L\ %P

set list listchars=tab:>-,trail:·,precedes:<,extends:>,eol:¶
