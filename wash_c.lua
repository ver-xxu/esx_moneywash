ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(asddsf) ESX = asddsf end)
        Wait(0)
    end
    TriggerServerEvent("money_wash:getpos")
end)

local wash = false
local WashPos = vector3(0.0, 0.0, -1110.0)
 
Citizen.CreateThread(function()
    while true do 
        local wait = 500
        local PlayerPed = PlayerPedId()
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        if #(PlayerCoords - WashPos) < 3 then
            wait = 5
            if not wash then
                Draw3DText(WashPos, "E - Wash money", 0.35)
                if IsControlJustPressed(0, 38) then
                    TaskStartScenarioInPlace(PlayerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                    wash = true
                    TriggerServerEvent("money_wash:start")
                end
            else
                Draw3DText(WashPos, "X - Stop washing", 0.35)
                if IsControlJustPressed(0, 73) then
                    ClearPedTasks(PlayerPed)
                    wash = false
                    TriggerServerEvent("money_wash:stopwash")
                end
	    end
		else
		    if wash then
			ClearPedTasks(PlayerPed)
			wash = false
			TriggerServerEvent("money_wash:stopwash")
		    end
		end
        Wait(wait)
    end
end)

RegisterNetEvent("money_wash:position")
AddEventHandler("money_wash:position", function(newpos)
    WashPos = newpos
end)
    
function Draw3DText(coords, text, scale)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
    SetTextScale(scale, scale)
    SetTextOutline()
    SetTextDropShadow()
    SetTextDropshadow(2, 0, 0, 0, 255)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry('STRING')
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)
    AddTextComponentString(text)
    DrawText(x, y)
    local factor = (string.len(text)) / 400
    DrawRect(x, y+0.012, 0.015+ factor, 0.03, 0, 0, 0, 68)
end 
