--!strict

--/ Services
local serverStorage = game:GetService("ServerStorage")
local debris = game:GetService("Debris")

--/ Physical variables
local hallways: Folder = serverStorage.Hallways
local rooms: Folder = serverStorage.Rooms
local env = game.Workspace.Environment

--/ Variables
local roomCount: number = 7 --/ Set this to the number of rooms you have in the folder ServerStorage/Rooms
local hallwayCount: number = 7 --/ Set this to the number of hallways you have in the folder ServerStorage/Hallways
local isVisualize: boolean = true --/ Change this if you want to visualize the system of checking for free space and the rooms/hallways getting placed
local visualizeDelay: number = 0.05 --/ Set this to the delay between visualizing the paths


local module = {
	currOuts = {},
	maxIterations = 4, --/ Set this to the number of iterations you want to have. More iterations = more rooms
}


--[[
		LOCAL FUNCTIONS
]]


--/ REQUIRES: rooms folder to contain at least 1 room &
--/			  their names to be of syntax "Room{integer}, starting from 1"
--/ EFFECTS: returns random room to be generated from rooms folder
local function getRandomRoom(): Model
	local index = math.random(1,roomCount)
	return rooms:FindFirstChild("Room" .. tostring(index)) :: Model
end

--/ REQUIRES: hallways folder to contain at least 1 room &
--/			  their names to be of syntax "Hallway{integer}, starting from 1"
--/ EFFECTS: returns random hallway to be generated from hallways folder
local function getRandomHallway(): Model
	local index = math.random(1,hallwayCount)
	return hallways:FindFirstChild("Hallway" .. tostring(index)) :: Model
end

--/ MODIFIES: env
--/ EFFECTS: shows a visual block of where the check is currently happening
local function visualize(size: Vector3, pos: CFrame)
	local part = Instance.new("Part")
	part.Size = size
	part.CFrame = pos
	part.Name = "CheckPart"
	part.CanCollide = false
	part.Anchored = true
	part.Transparency = 0.8
	part.Parent = env
	
	task.wait(visualizeDelay)
	debris:AddItem(part, 0)
end

--/ EFFECTS: returns whether room can be generated at the given out
local function canPlace(out: Part): boolean
	local lookVector: Vector3 = out.CFrame.LookVector
	local objects = {}
	local size = Vector3.new(50,10,50)
	local pos = out.CFrame * CFrame.new(0, 0, -30.5)
	local params = OverlapParams.new()
	params.FilterDescendantsInstances = {}
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.MaxParts = 100
	params.CollisionGroup = "Default"
	local objectsInSpace = game.Workspace:GetPartBoundsInBox(pos,size,params)
	
	if isVisualize then
		visualize(size, pos)
	end

	if #objectsInSpace > 1 then
		return false
	end
	return true
end


--[[
		MODULE FUNCTIONS
]]


--/ MODIFIES: env.Rooms
--/ EFFECTS: places randomized rooms where it can
function module:PlaceRooms()
	local currOuts = self.currOuts
	local nextOuts = {}
	for _, out in currOuts do
		
		--/ If room cannot be placed here, make the out blend in with the wall
		if not canPlace(out) then
			out.Color = Color3.fromRGB(105, 64, 40)
			out.Material = "Grass"
			out.Transparency = 0
			continue
		end
		
		--/ If room CAN be placed here, do so
		local room = getRandomRoom():Clone()
		room:PivotTo(out.CFrame * CFrame.new(0, 0, -30.5))
		room.Parent = env.Rooms
		debris:AddItem(out, 0)
		
		--/ Set the next outs to be generated on
		for _, v in room:GetChildren() do
			if v.Name == "Out" then
				table.insert(nextOuts, v)
			end
		end
	end
	self.currOuts = nextOuts
end

--/ MODIFIES: env.Hallways
--/ EFFECTS: places randomized hallways where it can
function module:PlaceHallways()
	local currOuts = self.currOuts
	local nextOuts = {}
	for _, out in currOuts do
		--/ If hallway cannot be placed here, make the out blend in with the wall
		if not canPlace(out) then
			out.Color = Color3.fromRGB(105, 64, 40)
			out.Material = "Grass"
			out.Transparency = 0
			continue
		end
		
		--/ If hallway CAN be placed here, do so
		local hallway = getRandomHallway():Clone()
		hallway:PivotTo(out.CFrame * CFrame.new(0, 0, -30.5))
		hallway.Parent = env.Hallways
		debris:AddItem(out, 0)
		
		--/ Set the next outs to be generated on
		for _, v in hallway:GetChildren() do
			if v.Name == "Out" then
				table.insert(nextOuts, v)
			end
		end
	end
	self.currOuts = nextOuts
end

return module
