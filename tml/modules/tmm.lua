-- The Powder Toy Mod Manager
-- 
-- This file will be a module for TML which will add UI and mod managing properties
--
-- This also works as an example extension module

local tmm = {}
tmm.metadata = {}
tmm.metadata["name"] = "The Powder Toy Mod Manager"
tmm.metadata["id"] = "tmm"
tmm.metadata["requires"] = "tml:1"
tmm.metadata["type"] = "module"

function tmm.onLoad()
  tmlAPI.util.log(tmm.metadata["id"],"onLoad, NYI")
end

function tmm.onDisable()
  print("NYI")
end

local function main()
  print("NYI")
end

return tmm