# Randomized-Dungeon-Generation-Roblox
## Randomized dungeon generation in roblox with customization parameters

This pack features everything you need to get started to randomly generate dungeons in Roblox Studio. You can customize many features which are explained below. In the future, I might add ways to customize even more things such as size of rooms, size of hallways, items in the rooms/hallways, etc.

---

### How to make it work

![image](https://github.com/user-attachments/assets/e5468c8f-c95e-4998-913c-7b6e047acb29)

The downloaded file will look like the above image in Roblox Studio. Move the contents of each folder to the appropriate place as shown by the name of the folders.

---

### Customization variables

*Customization variables can be found within the DungeonSpawnHandler module script.*

Room Count:
```lua
--/ Set this to the number of rooms you have in the folder ServerStorage/Rooms
--/ By default it is 7, as there are 7 premade rooms in the pack. Change it if you add more rooms.
local roomCount: number = 7 
```

Hallway Count:
```lua
--/ Set this to the number of rooms you have in the folder ServerStorage/Rooms
--/ By default it is 7, as there are 7 premade hallways in the pack. Change it if you add more hallways.
local hallwayCount: number = 7 
```

Visualization of generation:
```lua
--/ Change this if you want to visualize the system of checking for free space and the rooms/hallways getting placed
local isVisualize: boolean = true

--/ Set this to the delay between visualizing the paths
local visualizeDelay: number = 0.05
```

Number of generative iterations:
```lua
local module = {
  --/ Set this to the number of iterations you want to have. More iterations = more rooms
  maxIterations = 4, 
}
```
