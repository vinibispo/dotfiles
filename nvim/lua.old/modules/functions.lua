-- :fennel:1650454302
local M = {}
local function setup(package, config)
  local function _1_()
    local p = require(package)
    return p.setup(config)
  end
  return _1_()
end
M.setup = setup
return M