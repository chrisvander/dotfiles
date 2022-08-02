let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" sensible starting point
Plug 'tpope/vim-sensible'

" faster loading
Plug 'lewis6991/impatient.nvim'

" navigation
Plug 'phaazon/hop.nvim'
Plug 'wfxr/minimap.vim'

" multi select
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

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
Plug 'mhinz/vim-signify' " git status in left bar
Plug 'kdheepak/lazygit.nvim' " lazygit integration
Plug 'f-person/git-blame.nvim' " git blame

" language servers / managers
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-lint'
Plug 'mhartington/formatter.nvim'

" autocomplete
Plug 'ms-jpq/coq_nvim'

" completions
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" telescope fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'

" file tree
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

call plug#end()

" autoinstall
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" lua plugin setups
lua << EOF
require('impatient')
require('lualine').setup {
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  options = { theme = 'onedark' }
}
require("bufferline").setup {
  options = {
    diagnostics = "nvim_lsp",
    separator_style = "slant" 
  }
}
require("mason").setup {}
require("mason-lspconfig").setup()
require('hop').setup()
require("telescope").setup {}
require("telescope").load_extension "file_browser"
EOF

" theme
set termguicolors
let ayucolor="dark"
colorscheme ayu

" keybindings

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fb <cmd>Telescope file_browser<cr>

" Jump browsing
nnoremap <silent>s <cmd>HopPattern<cr>

" Tabbuffer
" These commands will navigate through buffers in order regardless of which mode you are using
nnoremap <silent>[b :BufferLineCycleNext<CR>
nnoremap <silent>]b :BufferLineCyclePrev<CR>

" These commands will move the current buffer backwards or forwards in the bufferline
nnoremap <silent><mymap> :BufferLineMoveNext<CR>
nnoremap <silent><mymap> :BufferLineMovePrev<CR>

" These commands will sort buffers by directory, language, or a custom criteria
nnoremap <silent>be :BufferLineSortByExtension<CR>
nnoremap <silent>bd :BufferLineSortByDirectory<CR>

" NvimTree
nnoremap <leader>e <cmd>CHADopen<cr>

" other options

" Options
set background=dark
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
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
