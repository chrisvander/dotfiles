let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" sensible starting point
Plug 'tpope/vim-sensible'

" themes
Plug 'joshdick/onedark.vim'
Plug 'tomasr/molokai'
Plug 'sickill/vim-monokai'
Plug 'ayu-theme/ayu-vim'

" powerline
Plug 'nvim-lualine/lualine.nvim'

" tabs
Plug 'akinsho/bufferline.nvim'

" git
Plug 'mhinz/vim-signify'

" language servers
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-lint'
Plug 'mhartington/formatter.nvim'

" faster loading
Plug 'lewis6991/impatient.nvim'

Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' " Snippets plugin

" telescope fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" file tree
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" set theme
set termguicolors
let ayucolor="mirage"
colorscheme ayu

" Register nvim-tree basic config
lua << EOF
require('impatient')
require('nvim-tree').setup()
require('lualine').setup {
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  options = { theme = 'onedark' },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
require("bufferline").setup {
  options = {
    diagnostics = "nvim_lsp",
    separator_style = "slant" 
  }
}
require("mason").setup {}
require("mason-lspconfig").setup()
EOF

" Add Telescope command line functions.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Options
set background=dark
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set inccommand=split
set mouse=a
set number
set relativenumber
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu
syntax on

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2
