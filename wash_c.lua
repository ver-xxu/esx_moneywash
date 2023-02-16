ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(asddsf) ESX = asddsf end)
        Wait(0)
    end
end)


local wash = false
 
CreateThread(function()

    local WashPos = {}
    while ( ESX == nil ) do
	   Wait(0)
    end
    ESX.TriggerServerCallback("money_wash:getpos",function(pos)
		WashPos = pos		
    end)
    while true do 
        local wait = 500
        local PlayerPed = PlayerPedId()
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(WashPos) do
            if #(PlayerCoords - v.pos) < 3 then
                local nytpos = v.pos
                wait = 0
                if not wash then
                    Draw3DText(v.pos, "E - Pese rahaa", 0.35)
                    if IsControlJustPressed(0, 38) then
                        TaskStartScenarioInPlace(PlayerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                        TriggerServerEvent("money_wash:start", k)
                    end
                else
                    Draw3DText(v.pos, "X - Lopeta pesu", 0.35)
                    if IsControlJustPressed(0, 73) then

                        ClearPedTasks(PlayerPed)
                        ESX.ShowNotification("Lopetit pesun")
                        TriggerServerEvent("money_wash:stopwash")
                    end
                end
                if wash then
                    print(nytpos)
                    if #(PlayerCoords - nytpos) > 3 then
                        ClearPedTasks(PlayerPed)
                        ESX.ShowNotification("Olet liian kaukana")
                        TriggerServerEvent("money_wash:stopwash")
                    end
                end
            end
		end
        Wait(wait)
    end
end)

RegisterNetEvent("money_wash:enabled")
AddEventHandler("money_wash:enabled",function()
    wash = true
end)
RegisterNetEvent("money_wash:disabled")
AddEventHandler("money_wash:disabled",function()
    wash = false
    ClearPedTasks(PlayerPedId())
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
