local Player = game.Players.LocalPlayer    
local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Api = "https://games.roblox.com/v1/games/"

local _place,_id = game.PlaceId, game.JobId
-- По возрастанию для маленького количества игроков, по уменьшению для большего количества
local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=10"
function ListServers(cursor)
   local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
   return Http:JSONDecode(Raw)
end

time_to_wait = 2 --seconds

-- выбирает рандом сервер
while wait(time_to_wait) do
   --фризит когда активируешь скрипт вроде, ну или я не ебу хули
   Player.Character.HumanoidRootPart.Anchored = true
   local Servers = ListServers()
   local Server = Servers.data[math.random(2,#Servers.data)]
   TPS:TeleportToPlaceInstance(_place, Server.id, Player)
end

-- by tg en3gma если чет не работает то пишите