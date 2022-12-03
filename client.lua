
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Wait(3000)
    QBCore.Functions.TriggerCallback("gls-playtime:getdata", function(data)
        SendNUIMessage({
            type = "onSpawn",
            saniye = data
        })
        
    end)
end)

