ESX = nil

TriggerEvent("esx:getSharedObject", function(asfsas) ESX = asfsas end)
local Washers = {}
local WashPos = vector3(0.0, 0.0, 0.0)
-- Real position here ^^
RegisterServerEvent("money_wash:start")
AddEventHandler("money_wash:start", function()
     local _source = source
     local xPlayer = ESX.GetPlayerFromId(_source)
     local coords = xPlayer.getCoords(true)
     local distance = #(coords - WashPos)
     if distance < 3 then
        if not Washers[_source] then
            Washers[_source] = true
            StartWash(xPlayer)
        end
     else
        print(string.format("%s is washing %s units away from the real spot", xPlayer.name, distance))
     end
end)

StartWash = function(xPlayer)  

end
