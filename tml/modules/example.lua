-- Example library module

local examplib = {}
examplib.metadata = {}
examplib.metadata["name"] = "Example Library"
examplib.metadata["id"] = "examplib"
examplib.metadata["requires"] = "tmlAPI:1"
examplib.metadata["version"] = 1
examplib.metadata["type"] = "module"

function examplib.getInfo()
  return metadata
end

function examplib.onLoad()
  print("NYI")
end

function examplib.onDisable()
  print("NYI")
end

function examplib.cosFunc (number)
    return cos(number)
end

return examplib