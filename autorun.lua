
--config might break with updates, scripts must have modID_managerVersion variable
local version = 1 
local manager_folder = "tml"
local mod_folder = "mods"
local module_folder = "mods"
local separator = '\\'
local mods = {}
local modules = {}
local active_mods = {}
local active_modules = {}
local modifiers = {}

modifiers[4096] = ""
modifiers[4160] = "ctrl"
modifiers[4097] = "shift"
modifiers[4352] = "alt"

--Global variables

KEYBINDS = {}

local function key_press_handler(key, nkey, modifier, event)
  print("NYI")
end

local function getFiles(folder)
  local directory = manager_folder.."/"..folder
  local dirlist = fs.list(directory)
  if not dirlist then return end
  local result = {}
  for i,v in ipairs(dirlist) do
    local file = directory.."/"..v
    if fs.isFile(file) then
      if file:find("%.lua$") then
        if OS == "WIN32" or OS == "WIN64" then
          toinsert = toinsert:gsub("/", "\\")
        end
        table.insert(result, file)
      end
    end
  end
  return result
end

local function loadFromTable(load_table)
  --anything else?
  
  for key, value in pairs(load_table) do
    dofile(value)
  end
end

modules = getFiles(module_folder)
mods = getFiles(mod_folder)
loadFromTable(mods)
tpt.register_keypress(key_press_handler) 
