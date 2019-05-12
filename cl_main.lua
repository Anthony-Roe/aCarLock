Controls = {}
Controls.ToggleLock = 171 -- CapsLock // Special Ability (Set this as a server convar "aCarLock_ToggleLock" and it must be an int)

local PlayerPed = nil
local InVehicle = false

TriggerServerEvent("aCarLock:RetrieveConvars")

RegisterNetEvent("aCarLock:RecieveConvars")
AddEventHandler("aCarLock:RecieveConvars", function(data)
    Controls.ToggleLock = data.ToggleLock == nil and Controls.ToggleLock or data.ToggleLock
end)

RegisterNetEvent("aCarLock:ToggleLock")
AddEventHandler("aCarLock:ToggleLock", function(vehicle, lockState)
    SetVehicleDoorsLockedForAllPlayers(vehicle, lockState)
end)

Citizen.CreateThread(function()
    while true do
        PlayerPed = PlayerPedId()
        InVehicle = IsPedInAnyVehicle(PlayerPed, false)
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        if (IsControlJustPressed(0, Controls.ToggleLock)) then
            TryLocking()
        end
        Citizen.Wait(0)
    end
end)

function TryLocking()
    local vehInFront = GetVehicleInFront()
    if (InVehicle) then
        local seat, seatCount = GetSeatPedIsIn(PlayerPed)
        if (seat == -1 or seat == 0) then
            local vehicle = GetVehiclePedIsIn(PlayerPed)
            TriggerServerEvent("aCarLock:CheckKey", vehicle, GetVehicleNumberPlateText(vehicle), not GetVehicleDoorsLockedForPlayer(vehicle, PlayerId()))
        end
    elseif (vehInFront ~= false) then
        TriggerServerEvent("aCarLock:CheckKey", vehInFront, GetVehicleNumberPlateText(vehInFront), not GetVehicleDoorsLockedForPlayer(vehInFront, PlayerId()))
    end
end