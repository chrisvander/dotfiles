call plug#begin()

Plug 'tpope/vim-sensible'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

lua << EOF
require("nvim-tree").setup()
EOF