-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function()
    vim.lsp.buf.format({
      async = false,
      filter = function(client)
        return client.name ~= "tsserver"
      end,
    })
  end,
})

vim.keymap.set({ "n", "v", "i", "t" }, "<C-h>", [[<Cmd>wincmd h<CR>]])
vim.keymap.set({ "n", "v", "i", "t" }, "<C-j>", [[<Cmd>wincmd j<CR>]])
vim.keymap.set({ "n", "v", "i", "t" }, "<C-k>", [[<Cmd>wincmd k<CR>]])
vim.keymap.set({ "n", "v", "i", "t" }, "<C-l>", [[<Cmd>wincmd l<CR>]])

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.navic_silence = true

-- Set defaults
vim.opt.background = "dark"
vim.opt.termguicolors = true

vim.opt.autoread = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fillchars = { eob = " ", vert = " ", fold = " " }
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.showmatch = true
vim.opt.title = true
vim.opt.timeoutlen = 500
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.syntax = "on"
vim.opt.updatetime = 50
vim.opt.wildmenu = true

-- undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.scrolloff = 8
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

vim.g.astro_typescript = "enable"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("lazy").setup({ import = "plugins" })
