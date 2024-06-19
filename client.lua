-- client.lua

local insideRadius = {}
local cooldowns = {}

-- Add blips on map for each radius area
Citizen.CreateThread(function()
    for i, area in ipairs(Config.RadiusAreas) do
        local blip = AddBlipForCoord(area.center.x, area.center.y, area.center.z)
        SetBlipSprite(blip, area.blip.sprite)
        SetBlipColour(blip, area.blip.color)
        SetBlipScale(blip, 1.0)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(area.blip.text)
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for i, area in ipairs(Config.RadiusAreas) do
            local distance = #(playerCoords - area.center)
            local isInRadius = distance <= area.radius
            
            if not insideRadius[i] then
                insideRadius[i] = {}
            end
            
            if isInRadius then
                insideRadius[i][PlayerId()] = true
            else
                insideRadius[i][PlayerId()] = nil
            end

            local playerCount = 0
            for _, _ in pairs(insideRadius[i]) do
                playerCount = playerCount + 1
            end

            -- Draw debug radius (transparent circle)
            DrawMarker(1, area.center.x, area.center.y, area.center.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, area.radius * 2, area.radius * 2, 2.0, 255, 255, 255, 100, false, false, 2, false, nil, nil, false)

            -- Display floating text with player count
            Draw3DText(area.center.x, area.center.y, area.center.z + 1.0, string.format("%d/%d", playerCount, area.requiredPlayers))

            if playerCount >= area.requiredPlayers then
                local cooldown = cooldowns[i] or 0

                if cooldown <= 0 then
                    -- Start cooldown from config
                    cooldown = area.teleportCooldown
                    cooldowns[i] = cooldown

                    -- Notify players about teleportation countdown
                    NotifyTeleportCountdown(area.teleportCooldown, i)

                    -- Perform teleportation after cooldown
                    Citizen.CreateThread(function()
                        while cooldown > 0 do
                            Citizen.Wait(1000)
                            cooldown = cooldown - 1
                            cooldowns[i] = cooldown
                        end

                        -- Teleport players after cooldown
                        for playerId, _ in pairs(insideRadius[i]) do
                            local playerPed = GetPlayerPed(GetPlayerFromServerId(playerId))
                            if DoesEntityExist(playerPed) then
                                SetEntityCoords(playerPed, area.teleportPoint.x, area.teleportPoint.y, area.teleportPoint.z, false, false, false, true)
                            end
                        end
                        insideRadius[i] = {} -- Reset the count
                        cooldowns[i] = 0 -- Reset cooldown
                    end)
                end
            else
                cooldowns[i] = 0 -- Reset cooldown if not enough players
            end
        end
    end
end)

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local camCoords = GetGameplayCamCoords()
    local dist = #(camCoords - vector3(x, y, z))

    local scale = 1 / dist * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    if onScreen then
        SetTextScale(0.35 * scale, 0.35 * scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function NotifyTeleportCountdown(cooldown, areaIndex)
    Citizen.CreateThread(function()
        local countdown = cooldown
        while countdown > 0 do
            Citizen.Wait(1000)
            countdown = countdown - 1
            if countdown > 0 then
                SetNotificationTextEntry("STRING")
                AddTextComponentString(string.format("Teleporting in: %d seconds", countdown))
                DrawNotification(false, false)
            end
        end
    end)
end
