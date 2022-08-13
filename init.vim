let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" navigation
Plug 'ggandor/lightspeed.nvim'
Plug 'tpope/vim-surround'
Plug 'liuchengxu/vista.vim'
Plug 'ms-jpq/chadtree'
Plug 'nanozuki/tabby.nvim' 
Plug 'glepnir/dashboard-nvim'

" terminal
Plug 'akinsho/toggleterm.nvim'

" themes
Plug 'EdenEast/nightfox.nvim'
Plug 'ayu-theme/ayu-vim'
Plug 'olimorris/onedarkpro.nvim'
Plug 'arzg/vim-colors-xcode'

" commenting
Plug 'scrooloose/nerdcommenter'

" powerline
Plug 'nvim-lualine/lualine.nvim'

" git
Plug 'mhinz/vim-signify' " git status in left bar
Plug 'f-person/git-blame.nvim' " git blame
Plug 'petertriho/cmp-git'

" completions
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
colorscheme carbonfox

" lua plugin setups
lua << EOF
local vista_extension = { sections = { }, filetypes = {'vista'} }
require('lualine').setup {
  options = {
    section_separators = { left = "\u{E0BC}", right = "\u{E0BA}" },
    component_separators = "" 
  },
  sections = {
    lualine_a = {{'mode', separator = { left = '\u{E0BA}', right = '\u{E0BC}' }, left_padding = 4 }},
    lualine_b = { 'filename' },
    lualine_c = { 'branch', 'diff', 'diagnostics' },
    lualine_x = {},
    lualine_y = { 'encoding', 'filetype' },
    lualine_z = {{'location', separator = { right = '\u{E0BC}', left = "\u{E0BA}" }, right_padding = 4 }}
  },
  extensions = { 'fzf', 'chadtree', vista_extension }
}
require('telescope').setup({
  defaults = {
    file_ignore_patterns = { "node_modules" }
  },
  extensions = {
    coc = {
        prefer_locations = true 
    }}
})
require('telescope').load_extension('file_browser')
require('telescope').load_extension('coc')
require('which-key').setup()
require('tabby').setup()
require('toggleterm').setup()

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })

function _lazygit_toggle()
  lazygit:toggle()
end

function _lazydocker_toggle()
  lazydocker:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>lua _lazydocker_toggle()<CR>", {noremap = true, silent = true})

local home = os.getenv('HOME')
local db = require("dashboard")

db.custom_header = {
[[                   ⢀⢄⢄⠢⡠⡀⢀⠄⡀⡀⠄⠄⠄⠄⠐⠡⠄⠉⠻⣻⣟⣿⣿⣄        ]],
[[              ⠄⠄⠄⠄⢠⢣⠣⡎⡪⢂⠊⡜⣔⠰⡐⠠⠄⡾⠄⠈⠠⡁⡂⠄⠔⠸⣻⣿⣿⣯⢂      ]],
[[        ⡀⠄⠄⠄⠄⠄⠄⠄⠐⢰⡱⣝⢕⡇⡪⢂⢊⢪⢎⢗⠕⢕⢠⣻⠄⠄⠄⠂⠢⠌⡀⠄⠨⢚⢿⣿⣧⢄     ]],
[[       ⡐⡈⠌⠄⠄⠄⠄⠄⠄⠄⡧⣟⢼⣕⢝⢬⠨⡪⡚⡺⡸⡌⡆⠜⣾⠄⠄⠄⠁⡐⠠⣐⠨⠄⠁⠹⡹⡻⣷⡕⢄   ]],
[[      ⢄⠇⠂⠄⠄⠄⠄⠄⠄⠄⢸⣻⣕⢗⠵⣍⣖⣕⡼⡼⣕⢭⢮⡆⠱⣽⡇⠄⠄⠂⠁⠄⢁⠢⡁⠄⠄⠐⠈⠺⢽⣳⣄  ]],
[[     ⢔⢕⢌⠄⠄⠄⠄⠄⢀⠄⠄⣾⢯⢳⠹⠪⡺⡺⣚⢜⣽⣮⣳⡻⡇⡙⣜⡇⠄⠄⢸⠄⠄⠂⡀⢠⠂⠄⢶⠊⢉⡁⠨⡒  ]],
[[    ⡨⣪⣿⢰⠈⠄⠄⠄⡀⠄⠄⠄⣽⣵⢿⣸⢵⣫⣳⢅⠕⡗⣝⣼⣺⠇⡘⡲⠇⠄⠄⠨⠄⠐⢀⠐⠐⠡⢰⠁⠄⣴⣾⣷⣮⣇⠄]],
[[    ⡮⣷⣿⠪⠄⠄⠄⠠⠄⠂⠠⠄⡿⡞⡇⡟⣺⣺⢷⣿⣱⢕⢵⢺⢼⡁⠪⣘⡇⠄⠄⢨⠄⠐⠄⠄⢀⠄⢸⠄⠄⣿⣿⣿⣿⣿⡆]],
[[   ⢸⣺⣿⣿⣇⠄⠄⠄⠄⢀⣤⣖⢯⣻⡑⢕⢭⢷⣻⣽⡾⣮⡳⡵⣕⣗⡇⠡⡣⣃⠄⠄⠸⠄⠄⠄⠄⠄⠄⠈⠄⠄⢻⣿⣿⣵⡿⣹]],
[[   ⢸⣿⣿⣟⣯⢄⢤⢲⣺⣻⣻⡺⡕⡔⡊⡎⡮⣿⣿⣽⡿⣿⣻⣼⣼⣺⡇⡀⢎⢨⢐⢄⡀⠄⢁⠠⠄⠄⠐⠄⠣⠄⠸⣿⣿⣯⣷⣿]],
[[   ⢸⣿⣿⣿⢽⠲⡑⢕⢵⢱⢪⡳⣕⢇⢕⡕⣟⣽⣽⣿⣿⣿⣿⣿⣿⣿⢗⢜⢜⢬⡳⣝⢸⣢⢀⠄⠄⠐⢀⠄⡀⠆⠄⠸⣿⣿⣿⣿]],
[[   ⢸⣿⣿⣿⢽⣝⢎⡪⡰⡢⡱⡝⡮⡪⡣⣫⢎⣿⣿⣿⣿⣿⣿⠟⠋⠄⢄⠄⠈⠑⠑⠭⡪⡪⢏⠗⡦⡀⠐⠄⠄⠈⠄⠄⠙⣿⣿⣿]],
[[   ⠘⣿⣿⣿⣿⡲⣝⢮⢪⢊⢎⢪⢺⠪⣝⢮⣯⢯⣟⡯⠷⠋⢀⣠⣶⣾⡿⠿⢀⣴⣖⢅⠪⠘⡌⡎⢍⣻⠠⠅⠄⠄⠈⠢⠄⠄⠙⠿]],
[[    ⣿⣿⣿⣿⣽⢺⢍⢎⢎⢪⡪⡮⣪⣿⣞⡟⠛⠋⢁⣠⣶⣿⡿⠛⠋⢀⣤⢾⢿⣕⢇⠡⢁⢑⠪⡳⡏⠄⠄⠄⠄⠄⠄⢑⠤⢀⢠]],
[[    ⢸⣿⣿⣿⣟⣮⡳⣭⢪⡣⡯⡮⠗⠋⠁⠄⠄⠈⠿⠟⠋⣁⣀⣴⣾⣿⣗⡯⡳⡕⡕⡕⡡⢂⠊⢮⠃⠄⠄⠄⠄⠄⢀⠐⠨⢁⠨]],
[[    ⠈⢿⣿⣿⣿⠷⠯⠽⠐⠁⠁⢀⡀⣤⢖⣽⢿⣦⣶⣾⣿⣿⣿⣿⣿⣿⢎⠇⡪⣸⡪⡮⠊⠄⠌⠎⡄⠄⠄⠄⠄⠄⠄⡂⢁⠉⡀]],
[[     ⠈⠛⠚⠒⠵⣶⣶⣶⣶⢪⢃⢇⠏⡳⡕⣝⢽⡽⣻⣿⣿⣿⣿⡿⣺⠰⡱⢜⢮⡟⠁⠄⠄⠅⠅⢂⠐⠄⠐⢀⠄⠄⠄⠂⡁⠂]],
[[       ⠰⠄⠐⢒⣠⣿⣟⢖⠅⠆⢝⢸⡪⡗⡅⡯⣻⣺⢯⡷⡯⡏⡇⡅⡏⣯⡟⠄⠄⠄⠨⡊⢔⢁⠠⠄⠄⠄⠄⠄⢀⠄⠄⠄]],
[[        ⠹⣿⣿⣿⣿⢿⢕⢇⢣⢸⢐⢇⢯⢪⢪⠢⡣⠣⢱⢑⢑⠰⡸⡸⡇⠁⠄⠄⠠⡱⠨⢘⠄⠂⡀⠂⠄⠄⠄⠄⠈⠂⠄]],
[[         ⢻⣿⣿⣿⣟⣝⢔⢅⠸⡘⢌⠮⡨⡪⠨⡂⠅⡑⡠⢂⢇⢇⢿⠁⠄⢀⠠⠨⡘⢌⡐⡈⠄⠄⠠⠄⠄⠄⠄⠄⠄⠁]],
[[          ⠹⣿⣿⣿⣯⢢⢊⢌⢂⠢⠑⠔⢌⡂⢎⠔⢔⢌⠎⡎⡮⡃⢀⠐⡐⠨⡐⠌⠄⡑⠄⢂⠐⢀⠄⠄⠈    ]],
[[           ⠙⣿⣿⣿⣯⠂⡀⠔⢔⠡⡹⠰⡑⡅⡕⡱⠰⡑⡜⣜⡅⡢⡈⡢⡑⡢⠁⠰⠄⠨⢀⠐⠄⠄⠄     ]],
[[            ⠈⠻⢿⣿⣷⣢⢱⠡⡊⢌⠌⡪⢨⢘⠜⡌⢆⢕⢢⢇⢆⢪⢢⡑⡅⢁⡖⡄⠄⠄⠄⢀       ]],
[[               ⠛⢿⣿⣵⡝⣜⢐⠕⢌⠢⡑⢌⠌⠆⠅⠑⠑⠑⠝⢜⠌⠠⢯⡚⡜⢕⢄⠄⠁       ]],
[[                 ⠙⢿⣷⡣⣇⠃⠅⠁⠈⡠⡠⡔⠜⠜⣿⣗⡖⡦⣰⢹⢸⢸⢸⡘⠌         ]],
[[                  ⠈⠋⢍⣠⡤⡆⣎⢇⣇⢧⡳⡍⡆⢿⣯⢯⣞⡮⣗⣝⢎⠇           ]],
[[                    ⠁⣿⣿⣎⢦⠣⠳⠑⠓⠑⠃⠩⠉⠈⠈⠉⠄⠁⠉            ]],
[[                     ⠈⡿⡞⠁⠄⠄⢀⠐⢐⠠⠈⡌⠌⠂⡁⠌              ]],
[[                      ⠈⢂⢂⢀⠡⠄⣈⠠⢄⠡⠒⠈                 ]],
[[                        ⠢⠠⠊⠨⠐⠈                     ]]
}

db.custom_center = {
      { icon = '  ',
        desc = 'Find File                               ',
        action = 'Telescope find_files',
        shortcut = '<leader> f f'},
      { icon = '  ',
        desc = 'File Browser                            ',
        action =  'Telescope file_browser',
        shortcut = '<leader> f b'},
      { icon = '  ',
        desc = 'Search in Files                         ',
        action =  'Telescope live_grep',
        shortcut = '<leader> f g'},

}
EOF

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-rust-analyzer',
  \ 'coc-tailwindcss',
  \ 'coc-vimlsp',
  \ 'coc-pyright',
  \ 'coc-css',
  \ 'coc-docker',
  \ 'coc-java',
  \ 'coc-json',
  \ 'coc-julia'
  \ ]

" keybindings
" coc
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" gd - go to definition of word under cursor
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" rename the current word in the cursor
nmap <leader>lr  <Plug>(coc-rename)
nmap <leader>lf  <Plug>(coc-format-selected)<cr>
vmap <leader>lf  <Plug>(coc-format-selected)<cr>
vmap <leader>la  <cmd>Telescope coc code_actions theme=cursor<cr>
nmap <leader>la  <cmd>Telescope coc code_actions theme=cursor<cr>

" Telescope
nnoremap <leader>ff        <cmd>Telescope find_files<cr>
nnoremap <leader>fg        <cmd>Telescope live_grep<cr>
nnoremap <leader>fb        <cmd>Telescope file_browser<cr>
nnoremap <leader>lc        <cmd>Telescope coc theme=ivy<cr>
nnoremap <leader>ld        <cmd>Telescope coc diagnostics theme=ivy<cr>
nnoremap <leader>le        <cmd>Telescope coc commands theme=ivy<cr>

" CHADtree
nmap <silent><C-e>         <cmd>CHADopen --nofocus<cr> 
vmap <silent><C-e>         <cmd>CHADopen --nofocus<cr> 

" Terminal
nnoremap <silent><C-j>     <cmd>ToggleTerm<cr>
tnoremap <silent><C-j>     <cmd>ToggleTerm<cr>
tnoremap <silent><C-t>     <C-\><C-n>

" Tabs
nnoremap <leader>t         <cmd>tabnew<cr>
nnoremap <leader>w         <cmd>tabclose<cr>
nnoremap <silent><C-,>     <cmd>tabp<cr>
nnoremap <silent><C-.>     <cmd>tabn<cr>
nnoremap <silent><C-<>     <cmd>-tabmove<cr>
nnoremap <silent><C->>     <cmd>+tabmove<cr>

" Vista 
nmap <silent><C-i>         <Cmd>Vista!!<cr>
vmap <silent><C-i>         <Cmd>Vista!!<cr>
let g:vista#renderer#enable_icon = 1

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
