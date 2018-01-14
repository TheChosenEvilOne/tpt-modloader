
--config might break with updates, scripts must have modID_managerVersion variable
local version = 1 
local manager_folder = "tmm"
local mods_folder = "mods"
local separator = '\\'
local mods = {}
local active_mods = {}
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
  local directory = manager_folder.."/"..mods_folder
  local dirlist = fs.list(directory)
  if not dirlist then return end
  local result = {}s
  for i,v in ipairs(dirlist) do
    local file = directory.."/"..v
    if fs.isFile(file) then
      if file:find("%.lua$") then
        local toinsert = file:sub(#folder) --which number?
        if OS == "WIN32" or OS == "WIN64" then
          toinsert = toinsert:gsub("/", "\\")
        end
        table.insert(result, toinsert)
      end
    end
  end
  return result
end

local function main()
  tpt.register_keypress(key_press_handler) 
end

main()
getMods()