-- Configuration Settings --
local ServerID = 1 -- This coresponds to the server ID set in the SonoranCMS configuration
local CommunityID = "REPLACE_THIS" -- The community ID for your SonoranCMS community
local APIKey = "REPLACE_THIS" -- The community API key copied from your SonoranCMS community's admin page

-- !!! SCRIPT START !!! PROCEED WITH CAUTION --
local Players = game:GetService("Players")
local http = game:GetService("HttpService")

Players.PlayerAdded:Connect(function(player)
    local data = {
        ["id"] = CommunityID,
        ["key"] = APIKey,
        ["type"] = "VERIFY_WHITELIST",
        ["data"] = {{
            ["apiId"] = player.Name,
            ["serverId"] = ServerID
        }}
    }
    local encodedData = http:JSONEncode(data)
    if pcall(function()
        local request = http:PostAsync("https://api.sonorancms.com/servers/verify_whitelist", encodedData,
            Enum.HttpContentType.ApplicationJson)
    end) then
        -- Do nothing, they can join
    else
        player:Kick("Player with name " .. player.Name .. " is not whitelisted or could not contact SonoranCMS")
    end
end)
