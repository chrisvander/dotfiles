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

" commenting
Plug 'scrooloose/nerdcommenter'

" powerline
Plug 'nvim-lualine/lualine.nvim'

" tabs
Plug 'akinsho/bufferline.nvim'

" git
Plug 'mhinz/vim-signify' " git status in left bar
Plug 'kdheepak/lazygit.nvim' " lazygit integration
Plug 'f-person/git-blame.nvim' " git blame
Plug 'petertriho/cmp-git'

" completions
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-docker', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" telescope fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'

" file tree
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

" which key bindings
Plug 'folke/which-key.nvim'

call plug#end()

" autoinstall plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

set completeopt=menu,menuone,noselect
set guifont=JetBrainsMono\ Nerd\ Font\ Mono:h14

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
  extensions = { 'chadtree', 'fzf' }
}
require('bufferline').setup {
  options = {
    diagnostics = 'nvim_lsp',
    separator_style = 'slant' 
  }
}
require('hop').setup()
require('telescope').setup()
require('telescope').load_extension('file_browser')
require('which-key').setup()
EOF

" minimap config
let g:minimap_auto_start = 1
let g:minimap_block_filetypes = ['fzf', 'CHADTree', 'bufferline']

" theme
set termguicolors
let ayucolor="mirage"
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

" These commands will sort buffers by directory, language, or a custom criteria
nnoremap <silent>be :BufferLineSortByExtension<CR>
nnoremap <silent>bd :BufferLineSortByDirectory<CR>

" CHADTree
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
set timeoutlen=0
set wildmenu
hi NonText guifg=bg
syntax on

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2
