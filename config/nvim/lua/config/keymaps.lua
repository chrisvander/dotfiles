-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local del = vim.keymap.del
del("n", "<leader>ww")
del("n", "<leader>wd")
del("n", "<leader>w-")
del("n", "<leader>w|")
del("n", "<leader>-")
del("n", "<leader>|")
del("n", "<leader>fn")
del("n", "<leader>ft")
del("n", "<leader>fT")

local map = vim.keymap.set
map("n", "<C-W>p", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<C-W>c", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<C-W>s", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<C-W>v", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<C-W>s", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<C-W>v", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>n", "<cmd>enew<cr>", { desc = "New File" })
map("n", "ga", "<leader>ca", { desc = "Code actions", remap = true })
