--Deco colour invert script
--Created by user:TheChosenEvilOne
--Copyright: no
--License: IDK

local function invert()
  for i in sim.parts() do
    red, gre, blu, alp = gfx.getColors(sim.partProperty(i,"dcolour"))
    if alp == 0 then
      elemID = sim.partProperty(i,sim.FIELD_TYPE)
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
    result = tonumber(alp..red..gre..blu,16)
    sim.partProperty(i,"dcolour", result)
  end
  interface.closeWindow(testWindow)
end

function window(key, nkey, modifier, event)
  if (key ~= "i") then
    return true
  end
  testWindow = Window:new(-1, -1, 91, 26)
  local testButton = Button:new(5, 5, 60, 16, "Invert")
  testButton:action(invert)
  
  
  local closeButton = Button:new(70, 5, 16, 16, "X")
 
  closeButton:action(function() interface.closeWindow(testWindow) end)
  
  testWindow:onTryExit(function() interface.closeWindow(testWindow) end)
  testWindow:addComponent(closeButton)
  testWindow:addComponent(testButton)  
  interface.showWindow(testWindow)
end

tpt.register_keypress(window) 