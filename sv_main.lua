Keys = {}

Default = {}
Default.ToggleLock = GetConvarInt("aCarLock_ToggleLock", 171) -- Default is caps lock // special ability

RegisterServerEvent("aCarLock:RetrieveConvars")
AddEventHandler("aCarLock:RetrieveConvars", function()
    TriggerClientEvent("aCarLock:RecieveConvars", source, Default)
end)

RegisterServerEvent("aCarLock:CheckKey")
AddEventHandler("aCarLock:CheckKey", function(vehicle, plate, lockState)
    if (Keys[plate] == nil) then
        TriggerClientEvent("aCarLock:NoKey", source) -- Use this notification to alert the client they have no key
        return
    end

    for i=1, #Keys[plate], 1 do
        if (Keys[plate][i] == GetFiveMLicense(source)) then
            TriggerClientEvent("aCarLock:ToggleLock", source, vehicle, lockState) -- You can use this event to add notifications
            break
        end
    end
end)

RegisterServerEvent("aCarLock:AddKey")
AddEventHandler("aCarLock:AddKey", function(playerId, plate)
    if (Keys[plate] == nil) then
        Keys[plate] = {}
    end
    table.insert(Keys[plate], GetFiveMLicense(playerId))
    TriggerClientEvent("aCarLock:AddKey", playerId) -- This is in place for those who want notifications.
end)

RegisterServerEvent("aCarLock:RemoveKey")
AddEventHandler("aCarLock:RemoveKey", function(playerId, plate)
    if (Keys[plate] == nil) then
        Keys[plate] = {}
    end
    if (#Keys[plate] <= 0) then
        return
    end
    for i=1, #Keys[plate], 1 do
        if (Keys[plate][i] == GetFiveMLicense(playerId)) then
            table.remove(Keys[plate], i)
        end
    end
    TriggerClientEvent("aCarLock:RemoveKey", playerId) -- This is in place for those who want notifications.
end)