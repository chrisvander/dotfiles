local log = require("overseer.log")
local jobs = require("overseer.strategy._jobs")
local util = require("overseer.util")

local terminal = require('toggleterm.terminal')

local ToggleTermStrategy = {}

local function with_cr(...)
  local result = {}
  for _, str in ipairs({ ... }) do
    table.insert(result, str .. " ")
  end
  return table.concat(result, "")
end

---@return overseer.Strategy
function ToggleTermStrategy.new()
  return setmetatable({
    bufnr = nil,
    chan_id = nil,
  }, { __index = ToggleTermStrategy })
end

function ToggleTermStrategy:reset()
  util.soft_delete_buf(self.bufnr)
  self.bufnr = nil
  if self.chan_id then
    vim.fn.jobstop(self.chan_id)
    self.chan_id = nil
  end
end

function ToggleTermStrategy:get_bufnr()
  return self.bufnr
end

---@param task overseer.Task
function ToggleTermStrategy:start(task)
  local chan_id
  local mode = vim.api.nvim_get_mode().mode
  local stdout_iter = util.get_stdout_line_iter()

  local function on_stdout(data)
    log:debug("Provided output %s", data)
    task:dispatch("on_output", data)
    local lines = stdout_iter(data)
    if not vim.tbl_isempty(lines) then
      task:dispatch("on_output_lines", lines)
    end
  end

  
  local cmd = type(task.cmd) == "table" and with_cr(unpack(task.cmd)) or with_cr(task.cmd)

  log:debug("%s", tostring(cmd))
  local term = terminal.Terminal:new({
    cmd = cmd,
    cwd = task.cwd,
    env = task.env,
    on_stdout = function(j, d)
      if self.chan_id ~= j then
        return
      end
      on_stdout(d)
    end,
    on_exit = function(_, j, c)
      jobs.unregister(j)
      if self.chan_id ~= j then
        return
      end
      log:debug("Task %s exited with code %s", task.name, c)
      -- Feed one last line end to flush the output
      on_stdout({ "" })
      self.chan_id = nil
      -- If we're exiting vim, don't call the on_exit handler
      -- We manually kill processes during VimLeavePre cleanup, and we don't want to trigger user
      -- code because of that
      if vim.v.exiting == vim.NIL then
        task:on_exit(c)
      end
    end,
    on_close = function(_)
      log:debug("Closing terminal")
    end,
    auto_scroll = true,
    close_on_exit = false,
    hidden = false,
  })

  term:toggle()

  chan_id = term.job_id
  self.bufnr = term.bufnr
  log:debug("Assigned job ID %s", chan_id)

  util.hack_around_termopen_autocmd(mode)

  if chan_id == 0 then
    error(string.format("Invalid arguments for task '%s'", task.name))
  elseif chan_id == -1 then
    error(string.format("Command '%s' not executable", vim.inspect(task.cmd)))
  else
    jobs.unregister(chan_id)
    self.chan_id = chan_id
  end
end

function ToggleTermStrategy:stop()
  if self.chan_id then
    vim.fn.jobstop(self.chan_id)
    self.chan_id = nil
  end
end

function ToggleTermStrategy:dispose()
  self:stop()
  util.soft_delete_buf(self.bufnr)
end

return ToggleTermStrategy
