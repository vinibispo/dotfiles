local status, ruby_nvim = pcall(require, "ruby_nvim")
if not status then
  return
end
ruby_nvim.setup({
  test_cmd = "ruby",
  test_args = {},
})
