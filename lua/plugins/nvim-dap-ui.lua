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
  end,
  dependencies = {
    "mfussenegger/nvim-dap",
  },
}
