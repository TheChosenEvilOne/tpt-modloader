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
  tmlAPI.util.log(tmlAPI.metadata["id"],"onLoad, NYI")
end

function tmlAPI.onDisable()
  print("NYI")
end

tmlAPI.util = {}

function tmlAPI.util.registerKeyME(key,modifier,event,func)
  if (not tml.keybinds[key.."_"..modifier.."_"..tostring(event)]) then
    local bind = {}
    bind[key.."_"..modifier.."_"..tostring(event)] = func
    table.insert(tml.keybinds,bind)
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

function tmlAPI.util.log(id,text)
  tpt.log(id..": "..text)
end

tmlAPI.config = {}

function tmlAPI.config.getConfig(id)
  return tml.configs[id]
end

function tmlAPI.config.getConfigValue(id,key)
  return tml.configs[id][key]
end

function tmlAPI.config.getConfigs()
  return tml.configs
end

function tmlAPI.config.setConfig(id,config)
  tml.configs[id] = config
end

function tmlAPI.config.setConfigValue(id,key,value)
  tml.configs[id][key] = value
end

tmlAPI.ui = {}
tmlAPI.ui.windowList = {}

function tmlAPI.ui.createWindow(id,x,y,width,height)
  local wi = {}
  local w = Window:new(x,y,width,height)
  wi[id] = w
  table.insert(tmlAPI.ui.windowList,wi)
  return w
end

function tmlAPI.ui.drawList(list, x, y, w, h, mousex, mousey)
  local oldx = x
  local oldy = y
  for _, e in ipairs(list) do
    local width, height = graphics.textSize(e)
    if y <= oldy + h then
      if mousex >= x - 2 and mousex <= x + width + 3 and mousey >= y - 2 and mousey <= y + width + 3 then
        graphics.drawRect(x - 2, y - 2, width + 3, height + 2)
      end
      graphics.drawText(x, y, e)
      y = y + height + 1
    else
      break
    end
  end
end


tmlAPI.element = {}
tmlAPI.element.elementList = {}

function tmlAPI.element.registerElement()
  print("TBI")
  --register element and add to elementList and use UID
end

return tmlAPI