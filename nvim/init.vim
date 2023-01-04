let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" navigation
Plug 'ggandor/lightspeed.nvim'
Plug 'tpope/vim-surround'
Plug 'glepnir/dashboard-nvim'

" terminal
Plug 'akinsho/toggleterm.nvim'

" themes
Plug 'EdenEast/nightfox.nvim'
Plug 'Shatur/neovim-ayu'
Plug 'olimorris/onedarkpro.nvim'
Plug 'arzg/vim-colors-xcode'
Plug 'rebelot/kanagawa.nvim'

" ui
Plug 'stevearc/dressing.nvim'

" commenting
Plug 'scrooloose/nerdcommenter'

" docs
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'mrjones2014/dash.nvim', { 'do': 'make install' }
Plug 'danymat/neogen'

" powerline
Plug 'nvim-lualine/lualine.nvim'

" git
Plug 'mhinz/vim-signify' " git status in left bar
Plug 'f-person/git-blame.nvim' " git blame
Plug 'petertriho/cmp-git'
Plug 'pwntester/octo.nvim'

" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

"  Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'VonHeikemen/lsp-zero.nvim'
Plug 'gbrlsnchs/telescope-lsp-handlers.nvim'

" testing
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/neotest-python'
Plug 'marilari88/neotest-vitest'
Plug 'haydenmeade/neotest-jest'
Plug 'nvim-neotest/neotest-go'
Plug 'rouge8/neotest-rust'

" telescope fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'fannheyward/telescope-coc.nvim'
Plug 'kkharji/sqlite.lua'

" file tree
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

" taskrunner
Plug 'stevearc/overseer.nvim'

" languages
Plug 'wuelnerdotexe/vim-astro'

" misc
Plug 'folke/which-key.nvim'
Plug 'jxnblk/vim-mdx-js'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'karb94/neoscroll.nvim'

call plug#end()

" autoinstall plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

let g:astro_typescript = 'enable'
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1
let mapleader = " "

" theme
set background=dark
set termguicolors
colorscheme ayu-dark
"hi EndOfBuffer guifg=#1f2330 

autocmd BufWritePre * lua vim.lsp.buf.format({ async = true })

" Telescope
nnoremap <leader>ft        <cmd>Telescope<cr>
nnoremap <leader>ff        <cmd>Telescope find_files<cr>
nnoremap <leader>fg        <cmd>Telescope live_grep<cr>
nnoremap <leader>fb        <cmd>Telescope file_browser<cr>

nnoremap <silent>ga        <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap <silent>gd        <cmd>Telescope lsp_definitions theme=ivy<cr>
nnoremap <silent>gi        <cmd>Telescope diagnostics theme=ivy<cr>
nnoremap <silent>gr        <cmd>lua vim.lsp.buf.rename()<cr> 
nnoremap <silent>gu        <cmd>Telescope lsp_references theme=ivy<cr>
nnoremap <silent>gt        <cmd>Telescope lsp_type_definitions theme=ivy<cr>
nnoremap <silent>gf        <cmd>lua vim.lsp.buf.format()<cr>

" tree
nmap <silent><leader>e     <cmd>NvimTreeToggle<cr> 
vmap <silent><leader>e     <cmd>NvimTreeToggle<cr> 

" Tabs
nnoremap <leader>t         <cmd>tabnew<cr>
nnoremap <leader>w         <cmd>tabclose<cr>
nnoremap <silent><C-,>     <cmd>tabp<cr>
nnoremap <silent><C-.>     <cmd>tabn<cr>
nnoremap <silent><C-<>     <cmd>-tabmove<cr>
nnoremap <silent><C->>     <cmd>+tabmove<cr>

" Dash
nnoremap <silent>gh        <cmd>DashWord<cr>

" Overseer
nnoremap <leader>r         <cmd>OverseerRun<cr>
nnoremap <leader>o         <cmd>OverseerToggle right<cr>

" Options
set autoread
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set inccommand=split
set mouse=a
set number
set relativenumber
set splitbelow splitright
set showmatch
set title
set timeoutlen=700
set laststatus=3
set signcolumn=yes
set wildmenu
syntax on

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2
