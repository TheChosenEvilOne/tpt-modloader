-- The Powder Toy Mod Loader API
-- 
-- TML API
--
-- This file implements all TML API functions

tmlAPI = {}
tmlAPI.metadata = {}
tmlAPI.metadata["name"] = "The Powder Toy Mod Loader API"
tmlAPI.metadata["id"] = "tmlAPI"
tmlAPI.metadata["requires"] = ""
tmlAPI.metadata["version"] = 1
tmlAPI.metadata["type"] = "library"

function tmlAPI.onLoad()
  print("NYI")
end

function tmlAPI.onDisable()
  print("NYI")
end

function tmlAPI.registerKey(key,modifier,event,func)
  if (not KEYBINDS[key.."_"..modifier.."_"..tostring(event)]) then
    local bind = {}
    bind[key.."_"..modifier.."_"..tostring(event)] = func
    print(tostring(func))
    table.insert(KEYBINDS,bind)
  end
end

return tmlAPI