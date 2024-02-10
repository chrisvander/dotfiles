-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local prev_hover = vim.lsp.handlers["textDocument/hover"]
-- stylua: ignore
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
  config = config or {}
  config.focus_id = ctx.method
  if not (result and result.contents) then
    return
  end
  if type(result.contents) == "table" and vim.tbl_isempty(result.contents) then
    return
  end
  return prev_hover(_, result, ctx, config)
end
