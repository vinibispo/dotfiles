vim.api.nvim_create_user_command("R", function(opts)
  _G.R(opts.args)
end, { nargs = 1 })
