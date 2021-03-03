ESX = nil

TriggerEvent("esx:getSharedObject", function(asfsas) ESX = asfsas end)

local Washers = {}

local WashPos = vector3(-285.11,281.65,89.89)
-- Real position here ^^

RegisterServerEvent("money_wash:start")
AddEventHandler("money_wash:start", function()
     local _source = source
     local xPlayer = ESX.GetPlayerFromId(_source)
     local coords = xPlayer.getCoords(true)
     local distance = #(coords - WashPos)
     if distance < 8 then
        if not Washers[_source] then
            Washers[_source] = true
            StartWash(_source)
        end
    else
        print(string.format("%s is trying to wash %s units away from the real spot", xPlayer.name, distance))
    end
end)

StartWash = function(source)  
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getAccount("black_money").money
    if Washers[source] then
        SetTimeout(2500, function()
            if money >= 500 then
                xPlayer.addMoney(500)
                xPlayer.removeAccountMoney("black_money", 500)
                StartWash(source)
            else
                xPlayer.showNotification("Sinulla ei ole tarpeeksi likaista rahaa!")
            end
    	end)
    end
end

RegisterServerEvent("money_wash:getpos")
AddEventHandler("money_wash:getpos", function()
    local _source = source
    TriggerClientEvent("money_wash:position", _source, WashPos)   
end)

RegisterServerEvent("money_wash:stopwash")
AddEventHandler("money_wash:stopwash", function()
    local _source = source
    Washers[_source] = nil
end)


