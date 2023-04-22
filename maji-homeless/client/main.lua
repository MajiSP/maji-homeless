local QBCore = exports['qb-core']:GetCoreObject()
CreateThread(function()
    for _, item in pairs(Config.giveItems) do 
        exports['qb-target']:AddTargetModel(Config.pedModels, {
            options = {
                {
                    icon = "fas fa-hands",
                    label = "Give " .. QBCore.Shared.Items[item]["label"],
                    item = item,
                    type = "server",
                    event = "maji:server:removeItem",
                },
            },
            distance = 2.5,
        })
    end
end)

RegisterNetEvent('maji:client:receiveItem', function(giveItem, receiveItem, entity)
    if IsEntityAPed(entity) then
        local playerPed = PlayerPedId()
        RequestAnimDict("mp_common")
        while not HasAnimDictLoaded("mp_common") do
            Wait(50)
        end
        TaskPlayAnim(playerPed, "mp_common", "givetake1_a", 8.0, -8.0, -1, 0, 0, false, false, false)
        TaskPlayAnim(entity, "mp_common", "givetake1_a", 8.0, -8.0, -1, 0, 0, false, false, false)
        Citizen.Wait(5000)
        ClearPedTasks(playerPed)
        ClearPedTasks(entity)
    end
    if receiveItem then
        QBCore.Functions.Notify("You gave "..QBCore.Shared.Items[giveItem]["label"].." and received "..QBCore.Shared.Items[receiveItem]["label"])
    else
        QBCore.Functions.Notify("You gave "..QBCore.Shared.Items[giveItem]["label"].." and received no item.")
    end
end)