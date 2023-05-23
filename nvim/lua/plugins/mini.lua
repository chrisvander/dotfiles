return {
  {
    "echasnovski/mini.starter",
    dependencies = {
      "folke/persistence.nvim",
    },
    event = "VimEnter",
    opts = function()
      local logo = table.concat({

        " ██████╗██╗  ██╗██████╗ ██╗███████╗██╗   ██╗██╗███╗   ███╗",
        "██╔════╝██║  ██║██╔══██╗██║██╔════╝██║   ██║██║████╗ ████║",
        "██║     ███████║██████╔╝██║███████╗██║   ██║██║██╔████╔██║",
        "██║     ██╔══██║██╔══██╗██║╚════██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "╚██████╗██║  ██║██║  ██║██║███████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
        " ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
      }, "\n")
      local pad = string.rep(" ", 22)
      local new_section = function(name, action, section)
        return { name = name, action = action, section = pad .. section }
      end

      local starter = require("mini.starter")
      --stylua: ignore
      local config = {
        evaluate_single = true,
        header = logo,
        items = {
          new_section("Find file", "Telescope find_files", "Telescope"),
          new_section("Recent files", "Telescope oldfiles", "Telescope"),
          new_section("Grep find", "Telescope live_grep", "Telescope"),
          new_section("Todos", "TodoTelescope", "Telescope"),
          new_section("Workspace", "Telescope zoxide list", "Telescope"),
          new_section("init.lua", "e $MYVIMRC", "Config"),
          new_section("Lazy", "Lazy", "Config"),
          new_section("New file", "ene | startinsert", "General"),
          new_section("Previous session", [[lua require("persistence").load()]], "General"),
          new_section("Quit", "qa", "General"),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(pad .. "░ ", false),
          starter.gen_hook.aligning("center", "center"),
        },
      }
      return config
    end,
    config = function(_, config)
      -- close Lazy and re-open when starter is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniStarterOpened",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      local starter = require("mini.starter")
      starter.setup(config)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local pad_footer = string.rep(" ", 12)
          starter.config.footer = pad_footer .. "⚡ Loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(starter.refresh)
        end,
      })
    end,
  } }
