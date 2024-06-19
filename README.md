# Teleportation Script for FiveM

This script allows you to set up teleportation zones in FiveM, where players can be teleported to a specific location when a certain number of players are within a defined radius.

## Installation

### Requirements

- [FiveM](https://fivem.net/) installed and running on your server.
- Basic knowledge of Lua programming (for further customization).

### Steps

1. **Download**

   - Download the script as a ZIP file from [GitHub]
   
2. **Installation**

   - Unzip the downloaded file.
   - Rename the folder to `teleportation` (optional).
   - Copy the `teleportation` folder into your FiveM resources directory (`...\FXServer\resources\`).
   
3. **Configuration**

   - Open `config.lua` in the `teleportation` folder.
   - Configure the `RadiusAreas` table to define your teleportation zones:
     ```lua
     Config.RadiusAreas = {
         {
             center = vector3(-510.6835, 1181.853, 324.9304), -- Center of the radius area
             radius = 5.0, -- Radius in meters
             requiredPlayers = 2, -- Number of players required to trigger teleportation
             teleportPoint = vector3(200.0, 300.0, 400.0), -- Teleportation coordinates
             teleportCooldown = 30, -- Cooldown in seconds before teleportation can occur again
             blip = {
                 sprite = 1, -- Blip sprite ID (check [Blip sprites](https://docs.fivem.net/docs/game-references/blips/))
                 color = 4, -- Blip color (check [Blip colors](https://docs.fivem.net/docs/game-references/blips/))
                 text = "Teleport Area 1" -- Blip name
             }
         },
         -- Add more radius areas as needed
     }
     ```
     - Adjust the parameters (`center`, `radius`, `requiredPlayers`, `teleportPoint`, `teleportCooldown`, and `blip`) for each teleportation zone according to your preferences.
   
4. **Starting the Script**

   - Start or restart your FiveM server.
   - Open the server console or use a server management tool.
   - Start the script by typing `ensure teleportation` (or the name you renamed the folder to) and press Enter.
   
5. **Usage**

   - In-game, players will see blips on their map representing the teleportation zones.
   - When the required number of players enter a zone, they will be teleported to the specified `teleportPoint`.

## Credits

- Developed by [Andree]([https://github.com/yourusername](https://github.com/Andreeegohard/))

## Support

For any issues or questions, please [open an issue](https://github.com/yourusername/teleportation-script/issues/new) here on GitHub.

---

### Notes

- Customize the `config.lua` file to fit your server's specific needs, such as different teleportation coordinates, radius sizes, required player counts, and cooldown times.
- Ensure that your FiveM server has the appropriate permissions and resources configured to allow for script execution and teleportation functionality.
