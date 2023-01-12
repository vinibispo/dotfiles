return {
  { "Massolari/forem.nvim", opts = { api_key = os.getenv("FOREM_API_KEY") }, cmd = "Forem my_articles" }, -- Write dev.to posts inside neovim
}
