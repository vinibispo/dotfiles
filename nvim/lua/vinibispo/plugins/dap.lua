local function config()
  local dap = require("dap")
  local dapui = require("dapui")
  local function set_adapters()
    dap.adapters.chrome = {
      type = "executable",
      command = "node",
      args = { vim.fn.stdpath("data") .. "/mason/bin/chrome-debug-adapter" },
    }

    dap.adapters.ruby = {
      type = "executable",
      command = "bundle",
      args = { "exec", "readapt", "stdio" },
    }
  end

  local function set_configurations()
    local keys = { "typescriptreact", "javascriptreact", "typescript", "javascript" }
    for _, val in ipairs(keys) do
      dap.configurations[val] = {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
      }
    end

    dap.configurations.ruby = {
      {
        type = "ruby",
        request = "launch",
        name = "Rails",
        program = "bundle",
        programArgs = { "exec", "rails", "s" },
        useBundler = true,
      },
      {
        type = "ruby",
        request = "launch",
        name = "RSpec (Active File)",
        program = "rspec",
        programArgs = {
          "${file}",
        },
        useBundler = false,
      },
    }
  end

  local function setup_ui()
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end

  set_adapters()

  set_configurations()

  setup_ui()
end

return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = config,
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "[D]ap Toggle [B]reakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "[D]ap [C]ontinue",
      },
      {
        "<leader>ds",
        function()
          require("dap").step_out()
        end,
        desc = "[D]ap [S]tep Out",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "[D]ap Step [O]ver",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "[D]ap Step [I]nto",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
        desc = "[D]ap [R]epl Open",
      },
    },
  }, --Debugger
}
