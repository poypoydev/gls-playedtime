local tempTablo = {}
local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateCallback("gls-playtime:getdata", function(source, cb)
    local src = source
    local table = getIdentifiers(src)
    if not table["steam"] then cb(0) end
    local hex = table["steam"]
    local loadFile= LoadResourceFile(GetCurrentResourceName(), "./oynasanatop.json")
    local decoded = json.decode(loadFile)
    if decoded[hex] then
        cb(decoded[hex])
    else
        cb(0)
    end
end)


AddEventHandler('playerDropped', function ()
    local src = source
    local table = getIdentifiers(src)
    if not table["steam"] then return end
    local hex = table["steam"]
    local timer = tempTablo[hex]
    if not timer then return end
    local equation = os.time() - timer
    local loadFile= LoadResourceFile(GetCurrentResourceName(), "./oynasanatop.json")
    local decoded = json.decode(loadFile)
    if decoded[hex] then
      num = tonumber(decoded[hex])
    else
      num = 0
    end
    decoded[hex] = num + equation

    SaveResourceFile(GetCurrentResourceName(), "oynasanatop.json", json.encode(decoded), -1)
end)



AddEventHandler("playerConnecting", function()
    local src = source
    local table = getIdentifiers(src)
    if not table["steam"] then return end
    local hex = table["steam"]
    tempTablo[hex] = os.time()
  print(tempTablo[hex])
end)


function getIdentifiers(src)
    local table = {}
  for k,v in pairs(GetPlayerIdentifiers(src))do
      if string.sub(v, 1, string.len("steam:")) == "steam:" then
        print(v)
        local steam = v
        local newid = string.gsub(steam, "steam:", "")
        table["steam"] = newid
      elseif string.sub(v, 1, string.len("license:")) == "license:" then
        table["license"] = v
      elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
        table["ip"] = v
      elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
        local steam = v
        local newid = string.gsub(steam, "discord:", "")
        print(v)
        table["discord"] = newid

      end
  end
  return table
end