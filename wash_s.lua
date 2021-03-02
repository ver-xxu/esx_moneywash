ESX = nil

TriggerEvent("esx:getSharedObject", function(asfsas) ESX = asfsas end)
local Washers = {}
local WashPos = vector3(0.0, 0.0, 0.0)
-- Real position here ^^
RegisterServerEvent("money_wash:start")
AddEventHandler("money_wash:start", function(pos)
     local _source = source
     local xPlayer = ESX.GetPlayerFromId(_source)
     if xPlayer.getCoords



end)
