RegisterNetEvent('fivem_teleport:teleportPlayers')
AddEventHandler('fivem_teleport:teleportPlayers', function(zoneName)
    local src = source
    local zone = nil

    for _, z in pairs(Config.Zones) do
        if z.name == zoneName then
            zone = z
            break
        end
    end

    if zone then
        for _, playerId in ipairs(GetActivePlayers()) do
            local targetPed = GetPlayerPed(playerId)
            local targetCoords = GetEntityCoords(targetPed)
            if #(targetCoords - zone.coords) <= zone.radius then
                SetEntityCoords(targetPed, zone.teleportCoords.x, zone.teleportCoords.y, zone.teleportCoords.z, false, false, false, true)
            end
        end
    end
end)
