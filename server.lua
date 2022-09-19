local GetDiscordID = function(source)
    local returnValue = nil
    for idIndex = 1, GetNumPlayerIdentifiers(source) do
        if GetPlayerIdentifier(source, idIndex) ~= nil and GetPlayerIdentifier(source, idIndex):sub(1, #("discord:")) == "discord:" then
            returnValue = GetPlayerIdentifier(source, idIndex):gsub("discord:", "")
        end
    end
    return returnValue
end

local function GetUserRoles(source)
    local p = promise.new()
    PerformHttpRequest(string.format("https://discord.com/api/v10/guilds/%s/members/%s", Config.GuildID, GetDiscordID(source)), function(err, data, headers)
        if err ~= 200 then
            p:reject("Error: " .. tostring(err))
        end
        p:resolve(json.decode(data).roles)

    end, 'GET', '', { Authorization = "Bot " .. Config.BotToken, ['Content-Type'] = 'application/json' }) 
    return Citizen.Await(p)
end

local function UserHasRole(source, role)
    local hasRole = false
    local roles = GetUserRoles(source)
    for i = 1, #roles, 1 do
        if roles[i] == role then
            hasRole = true
        end
    end
    return hasRole
end

exports("GetUserRoles", function(source)
    return GetUserRoles(source)
end)

exports("GetDiscordID", function(source)
    return GetDiscordID(source)
end)

exports("UserHasRole", function(source, role) 
    return UserHasRole(source, role)
end)