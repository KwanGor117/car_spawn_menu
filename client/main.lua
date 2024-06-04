RegisterNUICallback('spawnCar', function(data, cb)
    local carModel = data.model
    local playerPed = PlayerPedId()
    local vehicleHash = GetHashKey(carModel)

    RequestModel(vehicleHash)

    while not HasModelLoaded(vehicleHash) do
        Wait(1)
    end

    local playerCoords = GetEntityCoords(playerPed)
    local vehicle = CreateVehicle(vehicleHash, playerCoords.x, playerCoords.y, playerCoords.z, GetEntityHeading(playerPed), true, false)

    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

    SetNuiFocus(false, false)
    SendNUIMessage({ type = 'close' })  -- Close the NUI from the Lua side

    cb('ok')
end)

RegisterNUICallback('closeMenu', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ type = 'close' })  -- Close the NUI from the Lua side
    cb('ok')
end)

RegisterCommand('showcarmenu', function()
    SetNuiFocus(true, true)
    SendNUIMessage({ type = 'open' })  -- Open the NUI from the Lua side
end, false)

RegisterNetEvent('car_spawn_menu:openMenu')
AddEventHandler('car_spawn_menu:openMenu', function()
    SetNuiFocus(true, true)
    SendNUIMessage({ type = 'open' })  -- Open the NUI from the Lua side
end)

-- Listen for the Home key press
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) -- Run this code every frame
        if IsControlJustReleased(1, 213) then -- 213 is the control ID for the Home key
            TriggerServerEvent('car_spawn_menu:keyPress')
        end
    end
end)
