--Deco colour invert script
--Created by user:TheChosenEvilOne
--Copyright: no
--License: IDK

local invert = {}
invert.metadata = {}
invert.metadata["name"] = "Deco Colo(u)r invert script"
invert.metadata["id"] = "invert"
invert.metadata["requires"] = "tmlAPI:1"

function invert.onLoad ()
  tmlAPI.util.registerKeyM(tmlAPI.config.getConfigValue(invert.metadata.id,"keybind"),"alt",invert_test)
end

function invert.onDisable ()
  print("NYI")
end

local function invertFunc(window)
  for i in sim.parts() do
    local red, gre, blu, alp = gfx.getColors(sim.partProperty(i,"dcolour"))
    if alp == 0 then
      local elemID = sim.partProperty(i,sim.FIELD_TYPE)
      red,gre,blu,alp=gfx.getColors(elem.property(elemID,"Color"))
      alp = 0xFF
    end
    blu = 255 - blu
    gre = 255 - gre
    red = 255 - red
    blu = string.format("%x", blu)
    gre = string.format("%x", gre)
    red = string.format("%x", red)
    alp = string.format("%x", alp)
    if string.len(blu) ~= 2 then
      blu = "0"..blu
    end
    if string.len(red) ~= 2 then
      red = "0"..red
    end
    if string.len(gre) ~= 2 then
      gre = "0"..gre
    end
    if string.len(alp) ~= 2 then
      alp = "0"..alp
    end
    local result = tonumber(alp..red..gre..blu,16)
    sim.partProperty(i,"dcolour", result)
  end
  interface.closeWindow(window)
end

function invert_test()
  local window = Window:new(-1, -1, 91, 26)
  local invertButton = Button:new(5, 5, 60, 16, "Invert")
  invertButton:action(function () invertFunc(window) end)
  
  
  local closeButton = Button:new(70, 5, 16, 16, "X")
 
  closeButton:action(function() interface.closeWindow(window) end)
  
  window:onTryExit(function() interface.closeWindow(window) end)
  window:addComponent(closeButton)
  window:addComponent(invertButton)  
  interface.showWindow(window)
end

return invert