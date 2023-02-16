ESX = nil

TriggerEvent("esx:getSharedObject", function(asfsas) ESX = asfsas end)

local Washers = {}
local called = {}

local WashPos = { 
    [1] = {pos =vector3(1416.17, -734.01, 67.5)},
    [2] = {pos = vector3(2946.75,4624.13,50.48)} 
}
-- Real position here ^^

RegisterServerEvent("money_wash:start")
AddEventHandler("money_wash:start", function(k)
     local _source = source
     local xPlayer = ESX.GetPlayerFromId(_source)
     local coords = GetEntityCoords(GetPlayerPed(_source))
        local distance = #(coords - WashPos[k].pos)
        if distance < 3 then
            if not Washers[_source] then
                Washers[_source] = true
                StartWash(xPlayer, _source)
                TriggerClientEvent('esx:showNotification', _source, 'Aloitit rahanpesun!')
                TriggerClientEvent("money_wash:enabled", _source)
            else
                TriggerClientEvent('esx:showNotification', _source, 'Peset jo rahaa!')
            end
        else
            print(string.format("%s is trying to wash %s units away from the real spot", xPlayer.name, distance))
        end
end)

StartWash = function(xPlayer, source)  
    local money = xPlayer.getAccount("black_money").money
    if Washers[source] then
        SetTimeout(2500, function()
            if money >= 500 then
                xPlayer.addMoney(500)
                xPlayer.removeAccountMoney("black_money", 500)
                TriggerClientEvent('esx:showNotification', source, 'Pesit $500')
		        StartWash(xPlayer, source)
            else
                TriggerClientEvent('esx:showNotification', source, 'Sinulla ei ole likaista rahaa!')
                Washers[source] = nil
                TriggerClientEvent("money_wash:disabled", source)
            end
    	end)
    end
end

ESX.RegisterServerCallback("money_wash:getpos",function(source, cb)
        local _source = source
        if not called[_source] then
		    cb(WashPos)
		    called[_source] = true
        else
	        cb(nil)
        end 
end)


RegisterServerEvent("money_wash:stopwash")
AddEventHandler("money_wash:stopwash", function()
    local _source = source
    Washers[_source] = nil
    TriggerClientEvent("money_wash:disabled", _source)
end)


