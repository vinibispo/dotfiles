local function is_work()
  return string.find(vim.loop.cwd(), "acg") or string.find(vim.loop.cwd(), "vmox")
end

return { is_work = is_work }
