local function is_acg()
  return string.find(vim.loop.cwd(), "acg")
end

return { is_acg = is_acg }
