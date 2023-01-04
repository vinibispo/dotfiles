local function PackerReinstall(name)
  if package.loaded["packer"] == nil then
    print("Packer not installed or not loaded")
  end

  local utils = require("packer.plugin_utils")
  local suffix = "/" .. name

  local opt, start = utils.list_installed_plugins()
  for _, group in pairs({ opt, start }) do
    if group ~= nil then
      for dir, _ in pairs(group) do
        if dir:sub(-string.len(suffix)) == suffix then
          vim.ui.input({ prompt = "Remove " .. dir .. "? [y/n] " }, function(confirmation)
            if string.lower(confirmation) ~= "y" then
              return
            end
            os.execute("cd " .. dir .. " && git fetch --progress origin && git reset --hard origin")
            vim.cmd.PackerSync()
          end)
          return
        end
      end
    end
  end
end

vim.api.nvim_create_user_command("PackerReinstall", function(opts)
  PackerReinstall(opts.args)
end, { nargs = 1 })
vim.api.nvim_create_user_command("Bdall", "%bd|e#bd#", {})

vim.api.nvim_create_user_command("R", function(opts)
  _G.R(opts.args)
end, { nargs = 1 })
