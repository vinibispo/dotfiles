local function set_border(hl_name)
  hl_name = hl_name or "FloatBorder"
  return {
    { "╔", hl_name },
    { "═", hl_name },
    { "╗", hl_name },
    { "║", hl_name },
    { "╝", hl_name },
    { "═", hl_name },
    { "╚", hl_name },
    { "║", hl_name },
  }
end

local M = {}
M.set_border = set_border
return M
