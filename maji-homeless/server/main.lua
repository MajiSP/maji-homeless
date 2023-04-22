local QBCore = exports['qb-core']:GetCoreObject()

local entityItems = {}

RegisterNetEvent('maji:server:removeItem', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end

    if entityItems[data.entity] and entityItems[data.entity][data.item] then
        TriggerClientEvent('QBCore:Notify', src, "The ped can't accept this item!", "error")
        return
    end

    if Player.Functions.RemoveItem(data.item, 1) then  
        if not entityItems[data.entity] then
            entityItems[data.entity] = {}
        end
        entityItems[data.entity][data.item] = true
        ReceiveRandomItemToPlayer(data.item, data.entity)
    end
end)

function ReceiveRandomItemToPlayer(item, entity)
    local src = source
    local randomChance = math.random()
    local randomItem
    if randomChance < Config.itemChance then
      randomItem = Config.receiveItems[math.random(1, #Config.receiveItems)]
      local Player = QBCore.Functions.GetPlayer(src)
      Player.Functions.AddItem(randomItem, 1)
    end
    TriggerClientEvent('maji:client:receiveItem', src, item, randomItem, entity)
end