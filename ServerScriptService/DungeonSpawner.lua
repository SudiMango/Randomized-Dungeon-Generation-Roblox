--!strict

--/ Variables
local module = require(script.DungeonSpawnHandler)
local starterRoom = game.Workspace.Environment.Rooms.StarterRoom

table.insert(module.currOuts, starterRoom.Out) --/ Start by inserting the out of the starter room to be generated on

--/ Do random generation
local currIterations: number = 0
while (currIterations < module.maxIterations) do
	print("Current iteration: " .. tostring(currIterations))
	wait(1)
	wait(0.05)
	module:PlaceHallways()
	wait(0.05)
	module:PlaceRooms()
	currIterations += 1
end
print("Finished iterations at: " .. tostring(module.maxIterations))

--/ In the end, set all outs to be blended with the walls
for _, out in pairs(module.currOuts) do
	out.Color = Color3.fromRGB(105, 64, 40)
	out.Material = "Grass"
	out.Transparency = 0
end
