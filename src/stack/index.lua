local utils = require("stack.utils")

local m = {}

local config = {}

function m.init(max)
  print("Respawn script")

  config["max"] = max

end

return m
