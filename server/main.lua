local newESX = true -- 舊版esx

if newESX then
    ESX = exports["es_extended"]:getSharedObject()
end

RegisterCommand('opencarmenu', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then
        TriggerClientEvent('car_spawn_menu:openMenu', source)
    else
        xPlayer.showNotification('You do not have permission to use this command.')
    end
end, false)
