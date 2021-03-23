 ESX = nil

TriggerEvent("esx:getSharedObject", function(asfsas) ESX = asfsas end)

local Washers = {}
local called = {}

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
        print(string.format("%s is trying to wash %s units away from the real spot", xPlayer.name, distance))
    end
end)

StartWash = function(xPlayer)  
    local money = xPlayer.getAccount("black_money").money
    if Washers[xPlayer.source] then
        SetTimeout(2500, function()
            if money >= 500 then
                xPlayer.addMoney(500)
                xPlayer.removeAccountMoney("black_money", 500)
		StartWash(xPlayer)
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
end)


