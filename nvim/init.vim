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
Plug 'danymat/neogen'

" powerline
Plug 'nvim-lualine/lualine.nvim'

" git
Plug 'mhinz/vim-signify' " git status in left bar
Plug 'f-person/git-blame.nvim' " git blame
Plug 'petertriho/cmp-git'
Plug 'pwntester/octo.nvim'

" completions
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

autocmd VimEnter * Vista

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
colorscheme kanagawa
"hi EndOfBuffer guifg=#1f2330 

let g:vista_default_executive = "coc"
let g:vista_stay_on_open=0

" coc config
let g:coc_global_extensions = [
  \ 'coc-tasks',
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-rust-analyzer',
  \ 'coc-vimlsp',
  \ 'coc-pyright',
  \ 'coc-css',
  \ 'coc-docker',
  \ 'coc-java',
  \ 'coc-json',
  \ 'coc-julia',
  \ 'coc-lua'
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

" format on save
autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Telescope
nnoremap <leader>ff        <cmd>Telescope find_files<cr>
nnoremap <leader>fg        <cmd>Telescope live_grep<cr>
nnoremap <leader>fb        <cmd>Telescope file_browser<cr>

nnoremap <leader>la        <cmd>Telescope coc code_actions theme=cursor<cr>
nnoremap <leader>lm        <cmd>Telescope coc <cr>
nnoremap <leader>li        <cmd>Telescope coc diagnostics theme=dropdown<cr>
nnoremap <leader>lc        <cmd>Telescope coc commands theme=ivy<cr>
nnoremap <leader>lu        <cmd>Telescope coc references_used theme=ivy<cr>

nmap <leader>lt            <Plug>(coc-type-definition)
nmap <leader>ld            <Plug>(coc-definition)
map <leader>lr             <Plug>(coc-rename)
map <leader>lf             <Plug>(coc-format-selected)
map <leader>li             <Plug>(coc-implementation)

" coc
nnoremap <silent> gh :call <SID>show_documentation()<CR>

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

" Vista 
nmap <leader>i             <Cmd>Vista!!<cr>
vmap <leader>i             <Cmd>Vista!!<cr>
let g:vista#renderer#enable_icon = 0

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
set wildmenu
syntax on

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2
