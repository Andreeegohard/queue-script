
Config = {}

Config.RadiusAreas = {
    {
        center = vector3(-510.6835, 1181.853, 324.9304), -- Example coordinates
        radius = 3.0, -- Radius in meters
        requiredPlayers = 1,
        teleportPoint = vector3(-488.4389, 1189.77, 324.7209),
        teleportCooldown = 10, -- Cooldown in seconds before teleportation
        blip = {
            sprite = 1, -- Blip sprite
            color = 4, -- Blip color
            text = "Teleport Area 1" -- Blip name
        }
    },
    {
        center = vector3(0, 0, 0), -- Example coordinates
        radius = 3.0, -- Radius in meters
        requiredPlayers = 1,
        teleportPoint = vector3(0, 0 ,0),
        teleportCooldown = 10, -- Cooldown in seconds before teleportation
        blip = {
            sprite = 1, -- Blip sprite
            color = 4, -- Blip color
            text = "Teleport Area 2" -- Blip name
        }
    },
}
