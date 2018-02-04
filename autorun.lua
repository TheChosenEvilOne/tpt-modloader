--config might break with updates, scripts must have modID_managerVersion variable
local version = 2
local manager_folder = "tml"
local mod_folder = "mods"
local module_folder = "modules"
local config_folder = "configs"
local extension_folder = "extensions"
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
tml.extensions = {}

local function splitStr(inputString, separator)
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

local function getFiles(folder,extension)
  local directory = manager_folder.."/"..folder
  local dirlist = fs.list(directory)
  if not dirlist then return end
  local result = {}
  for i,v in ipairs(dirlist) do
    local file = directory.."/"..v
    if fs.isFile(file) then
      if file:find("%"..extension.."$") then
        if OS == "WIN32" or OS == "WIN64" then
          toinsert = toinsert:gsub("/", "\\")
        end
        table.insert(result, file)
      end
    end
  end
  return result
end

local function loadExtensionsFromTable(load_table,ttable)
  for _, v in pairs(load_table) do
     ttable[v:match("[^/]+$"):gsub("%.lua", "")] = require(v:gsub("%/", "."):gsub("%.lua", ""))
  end
end

local function loadDofile(loaded)
    if loaded ~= nil then
      if loaded.metadata ~= nil then
        loaded.metadata.uid=loaded.metadata.id.."-"..tml.extensions.uuid()
        print("Assigned UID: "..loaded.metadata.uid)
        if loaded.onLoad ~= nil then 
          loaded.onLoad()
        end
        print("Loaded: "..loaded.metadata.name)
        if(loaded.metadata.type == "module") then
          tml.modules[loaded.metadata.id..":"..loaded.metadata.version] = loaded
        else
          tml.mods[loaded.metadata.uid] = loaded
        end
      else
        print("Loaded unidentified file, please identify your file if you are a dev")
      end
    end
end

local function loadFromTable(load_table)
  local loadOrder = {}
  for _, value in pairs(load_table) do
    loaded = dofile(value)
    if loaded ~= nil then
      if loaded.metadata.requires == "" then
        loadDofile(loaded)
      else
        table.insert(loadOrder, loaded)
      end
    end
  end
  for k, value in pairs(loadOrder) do
    local bool = true
    for _,req in pairs(splitStr(value.metadata.requires,",")) do
      bool = bool and tml.modules[req] ~= nil
    end
    if bool then
      loadDofile(value)
      loadOrder[k] = nil
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
    files[name] = tml.extensions.toml.parse(content)
    print("Loaded config: "..name)
  end
  return files
end

--START random generation

math.randomseed(os.time()) --TODO: add more randomness to seed
math.random(); math.random(); math.random() --dump few randoms

--END random generation

loadExtensionsFromTable(getFiles(extension_folder,".lua"),tml.extensions)

local modules = getFiles(module_folder,".lua")
local mods = getFiles(mod_folder,".lua")
local configs = getFiles(config_folder,".toml")
tml.configs = loadConfigsFromTable(configs)
loadFromTable(modules)
loadFromTable(mods)
tpt.register_keypress(keyPressHandler) 
