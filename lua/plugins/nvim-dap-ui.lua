return {
  "rcarriga/nvim-dap-ui",
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup({
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.5,
            },
            {
              id = "watches",
              size = 0.3,
            },
            {
              id = "stacks",
              size = 0.2,
            },
            -- "console",
            -- "breakpoints",
          },
          size = 0.33,
          position = "right",
        },
        {
          elements = {
            "repl",
          },
          size = 0.20,
          position = "bottom",
        },
      },
    })

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.disconnect.dapui_config = function()
      dapui.close()
    end

    -- Enable soft wrapping in DAP UI windows using proper events
    local function enable_wrap_in_dapui_windows()
      -- Get all DAP UI windows and enable wrapping
      for _, win in pairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buf_name = vim.api.nvim_buf_get_name(buf)
        local buf_ft = vim.api.nvim_buf_get_option(buf, "filetype")

        -- Check if this is a DAP UI buffer
        if buf_name:match("DAP") or buf_ft:match("dapui") or buf_ft == "dap-repl" then
          vim.api.nvim_win_set_option(win, "wrap", true)
          vim.api.nvim_win_set_option(win, "linebreak", true)
        end
      end
    end

    -- Hook into DAP UI open event to enable wrapping
    local original_open = dapui.open
    dapui.open = function(...)
      original_open(...)
      -- Small delay to ensure windows are created
      vim.defer_fn(enable_wrap_in_dapui_windows, 100)
    end
  end,
  dependencies = {
    "mfussenegger/nvim-dap",
  },
}
