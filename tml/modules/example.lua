-- Example library module

local metadata = {}
metadata["name"] = "Example Library"
metadata["id"] = "examplib"
metadata["requires"] = "tml:1"
metadata["type"] = "library"

local examplib = {}

function getInfo()
  return metadata
end

function onLoad()
  print("NYI")
end

function onDisable()
  print("NYI")
end

examplib["cosFunc"] = function (number)
    return cos(number)
end

return examplib