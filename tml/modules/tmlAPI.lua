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

tmlAPI.util = {}

function tmlAPI.util.registerKeyME(key,modifier,event,func)
  if (not KEYBINDS[key.."_"..modifier.."_"..tostring(event)]) then
    local bind = {}
    bind[key.."_"..modifier.."_"..tostring(event)] = func
    table.insert(KEYBINDS,bind)
  end
end

function tmlAPI.util.registerKeyM(key,modifier,func)
  tmlAPI.util.registerKeyME(key,modifier,1,func)
end

function tmlAPI.util.registerKey(key,func)
  tmlAPI.util.registerKeyM(key,"none",func)
end

function tmlAPI.util.splitStr(inputString, separator)
        if separator == nil then
                separator = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputString, "([^"..separator.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

--TODO: Write config API
tmlAPI.config = {}

function tmlAPI.config.getConfig(id)
  return CONFIGS[id]
end

function tmlAPI.config.getConfigValue(id,key)
  return CONFIGS[id][key]
end

function tmlAPI.config.getConfigs()
  return CONFIGS
end

function tmlAPI.config.setConfig(id,config)
  CONFIGS[id] = config
end

function tmlAPI.config.setConfigValue(id,key,value)
  CONFIGS[id][key] = value
end

return tmlAPI