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
        name = "Debug Cashier",
        type = "php",
        request = "launch",
        port = 9003,
        -- this is needed for a remote app running in a container
        pathMappings = {
          ["/var/www/html"] = "/Users/jas/Desktop/reposObs/cashier",
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
