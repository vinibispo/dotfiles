local dap = require("dap")
local function set_adapters()
  dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = { vim.fn.stdpath("data") .. "/mason/bin/chrome-debug-adapter" },
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
end

set_adapters()

set_configurations()
