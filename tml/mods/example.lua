-- Example library module

local examplib = {}
examplib.metadata = {}
examplib.metadata["name"] = "Example Mod"
examplib.metadata["id"] = "exampmod"
examplib.metadata["requires"] = "tml:1"

function examplib.getInfo()
  return metadata
end

function examplib.onLoad()
  
  -- Test Window
  local testWindow = Window:new(-1, -1, 300, 200)
  
  local currentY = 10
  
  --Example label
  local testLabel = Label:new(10, currentY, (select(1, testWindow:size())/2)-20, 16, "This is a test label")
  
  --Example button
  local buttonPresses = 1
  currentY = currentY + 20
  local testButton = Button:new(10, currentY, (select(1, testWindow:size())/2)-20, 16, "This is a test button")
  testButton:enabled(false)
  testButton:action(
    function(sender)
      sender:text("Pressed " .. buttonPresses .. " times")
      buttonPresses = buttonPresses + 1
    end
  )
  
  --Example Textbox
  currentY = currentY + 20
  local textboxInfo = Label:new(10+((select(1, testWindow:size())/2)-20), currentY, (select(1, testWindow:size())/2)-20, 16, "0 characters")
  local testTextbox = Textbox:new(10, currentY, (select(1, testWindow:size())/2)-20, 16, "", "[place text here]")
  testTextbox:onTextChanged(
    function(sender)
      textboxInfo:text(sender:text():len().." characters");
    end
  )
  
  --Example Checkbox
  currentY = currentY + 20
  local testCheckbox = Checkbox:new(10, currentY, (select(1, testWindow:size())/2)-20, 16, "Unchecked");
  testCheckbox:action(
    function(sender, checked)
      if(checked) then
        sender:text("Checked")
      else
        sender:text("Unchecked")
      end
      testButton:enabled(checked);
    end
  )
  
  --Example progress bar
  currentY = currentY + 20
  local testProgressBar = ProgressBar:new(10, currentY, (select(1, testWindow:size())/2)-20, 16, 0, "Slider: 0");
  
  --Example slider
  currentY = currentY + 20
  local testSlider = Slider:new(10, currentY, (select(1, testWindow:size())/2)-20, 16, 10);
  testSlider:onValueChanged(
    function(sender, value)
      testProgressBar:progress(value * 10)
      testProgressBar:status("Slider: " .. value)
    end
  )
  
  -- Close button
  local closeButton = Button:new(10, select(2, testWindow:size())-26, 100, 16, "Close")
  
  closeButton:action(function() interface.closeWindow(testWindow) end)
  
  testWindow:onTryExit(function() interface.closeWindow(testWindow) end) -- Allow the default exit events
  testWindow:onMouseMove(
    function(x, y, dx, dy)
      testLabel:text("Mouse: "..x..", "..y)
    end
  )
  
  testWindow:addComponent(testLabel)
  testWindow:addComponent(testButton)
  testWindow:addComponent(testTextbox)
  testWindow:addComponent(testCheckbox)
  testWindow:addComponent(testProgressBar)
  testWindow:addComponent(testSlider)
  testWindow:addComponent(textboxInfo)
  testWindow:addComponent(closeButton)

  local button = Button:new(613, 97, 15, 15, "")
  button:action(
    function(sender)
      interface.showWindow(testWindow)
    end
  )
  -- hell
  local icon = {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0},
    {0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
  }
  local function step()
    for x = 1, 13 do
      for y = 1, 13 do
        if icon[y][x] ~= 0 then
          tpt.drawpixel(613 + x, 97 + y)
        end
      end
    end
  end
  interface.addComponent(button)
  tpt.register_step(step)
end

function examplib.onDisable()
  print("NYI")
end

function examplib.cosFunc (number)
    return cos(number)
end

return examplib