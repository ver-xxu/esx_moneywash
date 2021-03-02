ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
         Wait(5)
         TriggerEvent("esx:getSharedObject", function(asddsf) ESX = asddsf end)
    end
    TriggerServerEvent("wash_money:getpos")
end)

local WashPos = vector3(6282.924492, 37374.3855, 7264.263)
 
CreateThread(function()
    while true do 
        local wait = 500
        local PlayerPed = PlayerPedId()
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        if #(PlayerCoords - WashPos) < 3 then
            wait = 5
            -- TODO 3D text func
            Draw3DText(WashPos, "E - Pese rahaa", 0.4)
            if IsControlJustPressed(0, 38) then
                TriggerServerEvent("money_wash:start", WashPos)
            end
        end
        Wait(wait)
    end
end)

RegisterNetEvent("money_wash:position")
AddEventHandler("money_wash:position", function(newpos)
    WashPos = newpos
end)
