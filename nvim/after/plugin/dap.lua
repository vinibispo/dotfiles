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

local function set_mappings()
  local opts = { noremap = true }
  local mappings = {
    { "<leader>db", dap.toggle_breakpoint },
    { "<leader>dc", dap.continue },
    { "<leader>ds", dap.step_out },
    { "<leader>do", dap.step_over },
    { "<leader>di", dap.step_into },
    { "<leader>dr", dap.repl.open },
  }
  for _, value in pairs(mappings) do
    local key = value[1]
    local _function = value[2]
    vim.keymap.set({ "n", "v", "x" }, key, _function, opts)
  end
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

set_mappings()

setup_ui()
