local function config()
  local notify = require("notify")

  vim.notify = notify
end

return {
  { "rcarriga/nvim-notify", event = "VeryLazy", config = config }, -- Notifications of Neovim
}
