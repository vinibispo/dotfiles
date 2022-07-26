vim.api.nvim_create_user_command("Bdall", "%bd|e#bd#", {})

vim.api.nvim_create_user_command("R", function(opts)
  _G.R(opts.args)
end, { nargs = 1 })
