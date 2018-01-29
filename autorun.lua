local TOML = require("tml.modules.toml")
local UUID = require("tml.extensions.uuid")

--config might break with updates, scripts must have modID_managerVersion variable
local version = 1 
local manager_folder = "tml"
local mod_folder = "mods"
local module_folder = "modules"
local config_folder = "configs"
local separator = '\\'
local active_mods = {}
local active_modules = {}
local modifiers = {}

modifiers[4096] = "none"
modifiers[4160] = "ctrl"
modifiers[4097] = "shift"
modifiers[4352] = "alt"

--Global variables

tml = {}
tml.keybinds = {}
tml.configs = {}
tml.mods = {}
tml.modules = {}

local function keyPressHandler(key, nkey, modifier, event)
  for _,v in pairs(tml.keybinds) do
    for bind,func in pairs(v) do
      tableOut = tmlAPI.util.splitStr(bind,"_")
      if tableOut[1] == key and modifiers[modifier] == tableOut[2] and tonumber(tableOut[3]) == event then
        func()
      end
    end
  end
end

local function getFiles(folder)
  local directory = manager_folder.."/"..folder
  local dirlist = fs.list(directory)
  if not dirlist then return end
  local result = {}
  for i,v in ipairs(dirlist) do
    local file = directory.."/"..v
    if fs.isFile(file) then
      if file:find("%.lua$") or file:find("%.toml$") then
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
  for _, value in pairs(load_table) do
    loaded = dofile(value)
    if loaded then
      if loaded.metadata ~= nil then
        loaded.metadata.uid=loaded.metadata.id.."-"..UUID()
        if loaded.onLoad ~= nil then 
          loaded.onLoad()
        end
        print("Loaded: "..loaded.metadata.name.." UID: "..loaded.metadata.uid)
        if(loaded.metadata.type ~= "module") then
          local modul = {}
          modul[loaded.metadata.uid] = loaded
          table.insert(tml.modules, modul)
        else
          local m = {}
          m[loaded.metadata.uid] = loaded
          table.insert(tml.mods, m)
        end
      else
        print("Loaded unidentified file, please identify your file if you are a dev")
      end
    end
  end
end

local function loadConfigsFromTable(load_table)
  local files = {}
  for _, value in pairs(load_table) do
    local f = assert(io.open(value, "rb"))
    local content = f:read("*all")
    f:close()
    local name = value:match("([^/]+)$"):match("(%w+).(%w+)")
    files[name] = TOML.parse(content)
    print("Loaded config: "..name)
  end
  return files
end

--START random generation

math.randomseed(os.time()) --TODO: add more random numbers to seed
math.random(); math.random(); math.random() --dump few randoms

--END random generation

local modules = getFiles(module_folder)
local mods = getFiles(mod_folder)
local configs = getFiles(config_folder)
tml.configs = loadConfigsFromTable(configs)
loadFromTable(modules)
loadFromTable(mods)
tpt.register_keypress(keyPressHandler) 