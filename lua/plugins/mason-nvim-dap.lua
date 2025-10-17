return {
  "mfussenegger/nvim-dap",
  optional = true,
  opts = function()
    local dap = require("dap")
    local path = require("mason-registry").get_package("php-debug-adapter"):get_install_path()
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
  end,
}
