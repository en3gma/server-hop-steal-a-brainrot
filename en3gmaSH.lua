local Player = game.Players.LocalPlayer    
local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Api = "https://games.roblox.com/v1/games/"

local _place,_id = game.PlaceId, game.JobId
-- Asc for lowest player count, Desc for highest player count
local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=10"
function ListServers(cursor)
   local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
   return Http:JSONDecode(Raw)
end

time_to_wait = 5 --seconds

-- choose a random server and join every 2 minutes
while wait(time_to_wait) do
   --freeze player before teleporting to prevent synapse crash?
   Player.Character.HumanoidRootPart.Anchored = true
   local Servers = ListServers()
   local Server = Servers.data[math.random(1,#Servers.data)]
   TPS:TeleportToPlaceInstance(_place, Server.id, Player)
end
