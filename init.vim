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
Plug 'liuchengxu/vista.vim'
Plug 'ms-jpq/chadtree'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'glepnir/dashboard-nvim'

" terminal
Plug 'numToStr/FTerm.nvim'

" multi select
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" themes
Plug 'ayu-theme/ayu-vim'
Plug 'olimorris/onedarkpro.nvim'
Plug 'arzg/vim-colors-xcode'

" commenting
Plug 'scrooloose/nerdcommenter'

" powerline
Plug 'nvim-lualine/lualine.nvim'

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
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'kkharji/sqlite.lua'

" file tree
Plug 'kyazdani42/nvim-web-devicons'

" which key bindings
Plug 'folke/which-key.nvim'

call plug#end()

" autoinstall plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

set completeopt=menu,menuone,noselect
set guifont=FiraCode\ Nerd\ Font\ Mono:h13
set background=dark

" theme
set termguicolors
colorscheme xcodedarkhc

 
" lua plugin setups
lua << EOF
require('impatient')
require('lualine').setup {
  options = {
    section_separators = { left = "\u{E0B4}", right = "\u{E0B6}" },
    component_separators = "" 
  },
  sections = {
    lualine_a = {{'mode', separator = { left = '\u{E0B6}', right = '\u{E0B4}' }, left_padding = 4 }},
    lualine_b = { 'filename' },
    lualine_c = { 'branch', 'diff', 'diagnostics' },
    lualine_x = {},
    lualine_y = { 'encoding', 'filetype' },
    lualine_z = {{'location', separator = { right = '\u{E0B4}', left = "\u{E0B6}" }, right_padding = 4 }}
  },
  extensions = { 'fzf', 'chadtree' }
}
require('hop').setup()
require('telescope').setup()
require('telescope').load_extension('file_browser')
require('telescope').load_extension('frecency')
require('which-key').setup()
require('bufferline').setup {
  options = {
    mode = 'tabs',
    separator_style = 'slant',
    offsets = {{filetype = "CHADTree", text = "File Explorer", text_align = "center" }},
  }
}
require('FTerm').setup {
  border = 'single'
}

vim.api.nvim_create_user_command('FTermOpen', require('FTerm').open, { bang = true })
vim.api.nvim_create_user_command('FTermClose', require('FTerm').close, { bang = true })
vim.api.nvim_create_user_command('FTermExit', require('FTerm').exit, { bang = true })
vim.api.nvim_create_user_command('FTermToggle', require('FTerm').toggle, { bang = true })

local home = os.getenv('HOME')
local db = require("dashboard")

db.custom_header = {
[[⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⢄⢄⠢⡠⡀⢀⠄⡀⡀⠄⠄⠄⠄⠐⠡⠄⠉⠻⣻⣟⣿⣿⣄⠄⠄⠄⠄⠄⠄⠄⠄]],
[[⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢠⢣⠣⡎⡪⢂⠊⡜⣔⠰⡐⠠⠄⡾⠄⠈⠠⡁⡂⠄⠔⠸⣻⣿⣿⣯⢂⠄⠄⠄⠄⠄⠄]],
[[⠄⠄⠄⠄⠄⠄⠄⠄⡀⠄⠄⠄⠄⠄⠄⠄⠐⢰⡱⣝⢕⡇⡪⢂⢊⢪⢎⢗⠕⢕⢠⣻⠄⠄⠄⠂⠢⠌⡀⠄⠨⢚⢿⣿⣧⢄⠄⠄⠄⠄⠄]],
[[⠄⠄⠄⠄⠄⠄⠄⡐⡈⠌⠄⠄⠄⠄⠄⠄⠄⡧⣟⢼⣕⢝⢬⠨⡪⡚⡺⡸⡌⡆⠜⣾⠄⠄⠄⠁⡐⠠⣐⠨⠄⠁⠹⡹⡻⣷⡕⢄⠄⠄⠄]],
[[⠄⠄⠄⠄⠄⠄⢄⠇⠂⠄⠄⠄⠄⠄⠄⠄⢸⣻⣕⢗⠵⣍⣖⣕⡼⡼⣕⢭⢮⡆⠱⣽⡇⠄⠄⠂⠁⠄⢁⠢⡁⠄⠄⠐⠈⠺⢽⣳⣄⠄⠄]],
[[⠄⠄⠄⠄⠄⢔⢕⢌⠄⠄⠄⠄⠄⢀⠄⠄⣾⢯⢳⠹⠪⡺⡺⣚⢜⣽⣮⣳⡻⡇⡙⣜⡇⠄⠄⢸⠄⠄⠂⡀⢠⠂⠄⢶⠊⢉⡁⠨⡒⠄⠄]],
[[⠄⠄⠄⠄⡨⣪⣿⢰⠈⠄⠄⠄⡀⠄⠄⠄⣽⣵⢿⣸⢵⣫⣳⢅⠕⡗⣝⣼⣺⠇⡘⡲⠇⠄⠄⠨⠄⠐⢀⠐⠐⠡⢰⠁⠄⣴⣾⣷⣮⣇⠄]],
[[⠄⠄⠄⠄⡮⣷⣿⠪⠄⠄⠄⠠⠄⠂⠠⠄⡿⡞⡇⡟⣺⣺⢷⣿⣱⢕⢵⢺⢼⡁⠪⣘⡇⠄⠄⢨⠄⠐⠄⠄⢀⠄⢸⠄⠄⣿⣿⣿⣿⣿⡆]],
[[⠄⠄⠄⢸⣺⣿⣿⣇⠄⠄⠄⠄⢀⣤⣖⢯⣻⡑⢕⢭⢷⣻⣽⡾⣮⡳⡵⣕⣗⡇⠡⡣⣃⠄⠄⠸⠄⠄⠄⠄⠄⠄⠈⠄⠄⢻⣿⣿⣵⡿⣹]],
[[⠄⠄⠄⢸⣿⣿⣟⣯⢄⢤⢲⣺⣻⣻⡺⡕⡔⡊⡎⡮⣿⣿⣽⡿⣿⣻⣼⣼⣺⡇⡀⢎⢨⢐⢄⡀⠄⢁⠠⠄⠄⠐⠄⠣⠄⠸⣿⣿⣯⣷⣿]],
[[⠄⠄⠄⢸⣿⣿⣿⢽⠲⡑⢕⢵⢱⢪⡳⣕⢇⢕⡕⣟⣽⣽⣿⣿⣿⣿⣿⣿⣿⢗⢜⢜⢬⡳⣝⢸⣢⢀⠄⠄⠐⢀⠄⡀⠆⠄⠸⣿⣿⣿⣿]],
[[⠄⠄⠄⢸⣿⣿⣿⢽⣝⢎⡪⡰⡢⡱⡝⡮⡪⡣⣫⢎⣿⣿⣿⣿⣿⣿⠟⠋⠄⢄⠄⠈⠑⠑⠭⡪⡪⢏⠗⡦⡀⠐⠄⠄⠈⠄⠄⠙⣿⣿⣿]],
[[⠄⠄⠄⠘⣿⣿⣿⣿⡲⣝⢮⢪⢊⢎⢪⢺⠪⣝⢮⣯⢯⣟⡯⠷⠋⢀⣠⣶⣾⡿⠿⢀⣴⣖⢅⠪⠘⡌⡎⢍⣻⠠⠅⠄⠄⠈⠢⠄⠄⠙⠿]],
[[⠄⠄⠄⠄⣿⣿⣿⣿⣽⢺⢍⢎⢎⢪⡪⡮⣪⣿⣞⡟⠛⠋⢁⣠⣶⣿⡿⠛⠋⢀⣤⢾⢿⣕⢇⠡⢁⢑⠪⡳⡏⠄⠄⠄⠄⠄⠄⢑⠤⢀⢠]],
[[⠄⠄⠄⠄⢸⣿⣿⣿⣟⣮⡳⣭⢪⡣⡯⡮⠗⠋⠁⠄⠄⠈⠿⠟⠋⣁⣀⣴⣾⣿⣗⡯⡳⡕⡕⡕⡡⢂⠊⢮⠃⠄⠄⠄⠄⠄⢀⠐⠨⢁⠨]],
[[⠄⠄⠄⠄⠈⢿⣿⣿⣿⠷⠯⠽⠐⠁⠁⢀⡀⣤⢖⣽⢿⣦⣶⣾⣿⣿⣿⣿⣿⣿⢎⠇⡪⣸⡪⡮⠊⠄⠌⠎⡄⠄⠄⠄⠄⠄⠄⡂⢁⠉⡀]],
[[⠄⠄⠄⠄⠄⠈⠛⠚⠒⠵⣶⣶⣶⣶⢪⢃⢇⠏⡳⡕⣝⢽⡽⣻⣿⣿⣿⣿⡿⣺⠰⡱⢜⢮⡟⠁⠄⠄⠅⠅⢂⠐⠄⠐⢀⠄⠄⠄⠂⡁⠂]],
[[⠄⠄⠄⠄⠄⠄⠄⠰⠄⠐⢒⣠⣿⣟⢖⠅⠆⢝⢸⡪⡗⡅⡯⣻⣺⢯⡷⡯⡏⡇⡅⡏⣯⡟⠄⠄⠄⠨⡊⢔⢁⠠⠄⠄⠄⠄⠄⢀⠄⠄⠄]],
[[⠄⠄⠄⠄⠄⠄⠄⠄⠹⣿⣿⣿⣿⢿⢕⢇⢣⢸⢐⢇⢯⢪⢪⠢⡣⠣⢱⢑⢑⠰⡸⡸⡇⠁⠄⠄⠠⡱⠨⢘⠄⠂⡀⠂⠄⠄⠄⠄⠈⠂⠄]],
[[⠄⠄⠄⠄⠄⠄⠄⠄⠄⢻⣿⣿⣿⣟⣝⢔⢅⠸⡘⢌⠮⡨⡪⠨⡂⠅⡑⡠⢂⢇⢇⢿⠁⠄⢀⠠⠨⡘⢌⡐⡈⠄⠄⠠⠄⠄⠄⠄⠄⠄⠁]],
[[⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠹⣿⣿⣿⣯⢢⢊⢌⢂⠢⠑⠔⢌⡂⢎⠔⢔⢌⠎⡎⡮⡃⢀⠐⡐⠨⡐⠌⠄⡑⠄⢂⠐⢀⠄⠄⠈⠄⠄⠄⠄]],
[[⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠙⣿⣿⣿⣯⠂⡀⠔⢔⠡⡹⠰⡑⡅⡕⡱⠰⡑⡜⣜⡅⡢⡈⡢⡑⡢⠁⠰⠄⠨⢀⠐⠄⠄⠄⠄⠄⠄⠄⠄]],
[[⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠻⢿⣿⣷⣢⢱⠡⡊⢌⠌⡪⢨⢘⠜⡌⢆⢕⢢⢇⢆⢪⢢⡑⡅⢁⡖⡄⠄⠄⠄⢀⠄⠄⠄⠄⠄⠄⠄]],
[[⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠛⢿⣿⣵⡝⣜⢐⠕⢌⠢⡑⢌⠌⠆⠅⠑⠑⠑⠝⢜⠌⠠⢯⡚⡜⢕⢄⠄⠁⠄⠄⠄⠄⠄⠄⠄]],
[[⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠙⢿⣷⡣⣇⠃⠅⠁⠈⡠⡠⡔⠜⠜⣿⣗⡖⡦⣰⢹⢸⢸⢸⡘⠌⠄⠄⠄⠄⠄⠄⠄⠄⠄]],
[[⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠋⢍⣠⡤⡆⣎⢇⣇⢧⡳⡍⡆⢿⣯⢯⣞⡮⣗⣝⢎⠇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄]],
[[⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠁⣿⣿⣎⢦⠣⠳⠑⠓⠑⠃⠩⠉⠈⠈⠉⠄⠁⠉⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄]],
[[⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⡿⡞⠁⠄⠄⢀⠐⢐⠠⠈⡌⠌⠂⡁⠌⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄]],
[[⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⢂⢂⢀⠡⠄⣈⠠⢄⠡⠒⠈⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄]],
[[⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠢⠠⠊⠨⠐⠈⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄]]
}

db.custom_center = {
      { icon = '  ',
        desc = 'Recently Opened                         ',
        action =  'Telescope frecency',
        shortcut = '<leader> f h'},
      { icon = '  ',
        desc = 'Find File                               ',
        action = 'Telescope find_files',
        shortcut = '<leader> f f'},
      { icon = '  ',
        desc = 'File Browser                            ',
        action =  'Telescope file_browser',
        shortcut = '<leader> f b'},
}
EOF

" keybindings
" Telescope
nnoremap <leader>fh        <cmd>Telescope frecency<cr>
nnoremap <leader>ff        <cmd>Telescope find_files<cr>
nnoremap <leader>fg        <cmd>Telescope live_grep<cr>
nnoremap <leader>fb        <cmd>Telescope file_browser<cr>

" CHADtree
nnoremap <silent><C-e>     <cmd>CHADopen --nofocus<cr> 

" Jump browsing
nnoremap <silent>s         <cmd>HopPattern<cr>

" Terminal
nnoremap <silent>t         <cmd>FTermToggle<cr>
tnoremap <silent><C-t>     <C-\><C-n>

" LazyGit
nnoremap <leader>g         <cmd>LazyGit<cr>

" Tabs
nnoremap <leader>t         <cmd>tabnew<cr>
nnoremap <leader>w         <cmd>tabclose<cr>

" Magic buffer-picking mode
nnoremap <silent> <C-p>    <Cmd>BufferLinePick<CR>

" Move to previous/next
nnoremap <silent>    <C-,> <Cmd>BufferLineCyclePrev<CR>
nnoremap <silent>    <C-.> <Cmd>BufferLineCycleNext<CR>

" Re-order to previous/next
nnoremap <silent>    <C-<> <Cmd>BufferLineMovePrev<CR>
nnoremap <silent>    <C->> <Cmd>BufferLineMoveNext<CR>

" Goto buffer in position...
nnoremap <silent>    <C-1> <Cmd>lua require("bufferline").go_to_buffer(1, true)<CR>
nnoremap <silent>    <C-2> <Cmd>lua require("bufferline").go_to_buffer(2, true)<CR>
nnoremap <silent>    <C-3> <Cmd>lua require("bufferline").go_to_buffer(3, true)<CR>
nnoremap <silent>    <C-4> <Cmd>lua require("bufferline").go_to_buffer(4, true)<CR>
nnoremap <silent>    <C-5> <Cmd>lua require("bufferline").go_to_buffer(5, true)<CR>
nnoremap <silent>    <C-6> <Cmd>lua require("bufferline").go_to_buffer(6, true)<CR>
nnoremap <silent>    <C-7> <Cmd>lua require("bufferline").go_to_buffer(7, true)<CR>
nnoremap <silent>    <C-8> <Cmd>lua require("bufferline").go_to_buffer(8, true)<CR>
nnoremap <silent>    <C-9> <Cmd>lua require("bufferline").go_to_buffer(9, true)<CR>
nnoremap <silent>    <C-0> <Cmd>lua require("bufferline").go_to_buffer(-1, true)<CR>

" Close buffer
nnoremap <silent>    <C-c> <Cmd>BufferLineGroupClose<CR> 

" other options
" Options
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
syntax on

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2
