return {
  "mfussenegger/nvim-dap",
  optional = true,
  opts = function()
    local dap = require("dap")
    local path = vim.fn.expand("$MASON/packages/php-debug-adapter")
    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = { path .. "/extension/out/phpDebug.js" },
    }
    -- local mason_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
    -- dap.adapters.python = {
    --   type = "executable",
    --   command = mason_python,
    --   args = { "-m", "debugpy.adapter" },
    -- }
    dap.configurations.php = {
      {
        name = "Debug ObservadorWordPress",
        type = "php",
        request = "launch",
        port = 9003,
        -- this is needed for a remote app running in a container
        pathMappings = {
          ["/usr/src/wordpress/wp-content"] = "${workspaceFolder}",
          ["/usr/src/wordpress"] = "${workspaceFolder}/.wordpress-src",
          ["/tmp/bladecache"] = "${workspaceFolder}/bladecache",
          ["/usr/src/wordpress/wp-config.php"] = "${workspaceFolder}/.docker/config/wp-config.php",
        },
        skipFiles = {
          "**/wp-includes/**",
          "**/vendor/**",
        },
      },
      {
        name = "Debug Admin",
        type = "php",
        request = "launch",
        port = 9003,
        -- this is needed for a remote app running in a container
        pathMappings = {
          ["/var/www/html"] = "${workspaceFolder}",
        },
      },
    }
    dap.configurations.blade = {
      {
        name = "Debug ObservadorWordPress",
        type = "php",
        request = "launch",
        port = 9003,
        -- this is needed for a remote app running in a container
        pathMappings = {
          ["/usr/src/wordpress/wp-content"] = "${workspaceFolder}",
          ["/usr/src/wordpress"] = "${workspaceFolder}/.wordpress-src",
          ["/tmp/bladecache"] = "${workspaceFolder}/bladecache",
          ["/usr/src/wordpress/wp-config.php"] = "${workspaceFolder}/.docker/config/wp-config.php",
        },
        skipFiles = {
          "**/wp-includes/**",
          "**/vendor/**",
        },
      },
    }
    -- dap.configurations.python = {
      -- {
      --   name = "Fast API",
      --   type = "python",
      --   request = "launch",
      --   module = "uvicorn",
      --   args = { "main:app", "--reload" },
      --   cwd = "${workspaceFolder}",
      --   console = "integratedTerminal",
      --   justMyCode = true,
      --   -- pathMappings = {
      --   -- ["/usr/src/wordpress/wp-content"] = "${workspaceFolder}",
      --   -- ["/usr/src/wordpress"] = "${workspaceFolder}/.wordpress-src",
      --   -- ["/tmp/bladecache"] = "${workspaceFolder}/bladecache",
      --   -- ["/usr/src/wordpress/wp-config.php"] = "${workspaceFolder}/.docker/config/wp-config.php",
      --   -- },
      -- },
      -- {
      --   name = "Fast API",
      --   type = "python",
      --   request = "attach",
      --   connect = { host = "127.0.0.1", port = 5678 },
      --   pathMappings = {
      --     ["/app"] = "${workspaceFolder}/backend",
      --   },
      -- },
    -- }
  end,
}

-- XDEBUG CONFIG:
-- zend_extension = xdebug
-- xdebug.client_port = 9003
-- xdebug.client_host = host.docker.internal
-- xdebug.log = /tmp/xdebug.log
-- xdebug.cli_color = 1
-- xdebug.mode = develop,debug
-- xdebug.start_upon_error = yes
--
--
-- TO STOP IN A BLADE FILE:
-- @php
--     xdebug_break();
-- @endphp
