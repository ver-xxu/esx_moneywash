ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
         Wait(5)
         TriggerEvent("esx:getSharedObject", function(asddsf) ESX = asddsf end)
    end
    TriggerServerEvent("wash_money:getpos")
end)
local wash = false
local WashPos = vector3(6282.924492, 37374.3855, 7264.263)
 
CreateThread(function()
    while true do 
        local wait = 500
        local PlayerPed = PlayerPedId()
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        if #(PlayerCoords - WashPos) < 3 then
            wait = 5
            -- TODO 3D text func
            if not pesu then
            Draw3DText(WashPos, "E - Pese rahaa", 0.4)
            if IsControlJustPressed(0, 38) then
                TaskStartScenarioInPlace(PlayerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                pesu = true
                TriggerServerEvent("money_wash:start")
            end
            else
            Draw3DText(WashPos, "X - Lopeta pesu", 0.4)
            if IsControlJustPressed(0, 73) then
                ClearPedTasks(PlayerPed)
                pesu = false
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
