local function GetDiscordID(source)
    local returnValue = nil
    for idIndex = 1, GetNumPlayerIdentifiers(source) do
        if GetPlayerIdentifier(source, idIndex) ~= nil and GetPlayerIdentifier(source, idIndex):sub(1, #("discord:")) == "discord:" then
            returnValue = GetPlayerIdentifier(source, idIndex):gsub("discord:", "")
        end
    end
    return returnValue
end

local function GetUserRoles(disID)
	local allroles = {}
	local prom = promise.new() -- PROMISE FOR ALL GUILDS
    for i = 1, #Config.GuildIDs do -- FOR EACH GUILD
		local p = promise.new() -- PROMISE FOR EACH INDIVIDUAL GUILD
		
		PerformHttpRequest(string.format("https://discord.com/api/v10/guilds/%s/members/%s", Config.GuildIDs[i], disID), function(err, data, headers) -- GET GUILD MEMBER OBJECT FROM DISCORD API
			if err ~= 200 then
				p:reject("Error: " .. tostring(err))
			end
			p:resolve(json.decode(data).roles) -- RESOLVES PROMISE FOR CURRENT GUILD
		end, 'GET', '', { Authorization = "Bot " .. Config.BotToken, ['Content-Type'] = 'application/json' })
		
		local roles = Citizen.Await(p) -- RETURNS DATA FROM REQUEST
		for i = 1, #roles do -- SORTING ROLES FROM THE GUILD INTO A SINGLE TABLE
			table.insert(allroles, roles[i])
		end
    end
	prom:resolve(allroles) -- RESOLVE ALL ROLES AFTER FINISHING EACH GUILD
	return Citizen.Await(prom) -- RETURN ALL ROLES
end

local function UserHasRole(disID, role)
    local hasRole = false
    local data = GetUserRoles(disID) -- GET ALL USER ROLES
	for i = 1, #data do -- GOES THROUGH EACH ROLE AND CHECKS IF IT IS EQUAL TO THE ROLE SPECIFIED
		if data[i] == tostring(role) then
			hasRole = true
		end
	end
    return hasRole
end

exports("GetUserRoles", function(source)
	return GetUserRoles(GetDiscordID(source))
end)

exports("UserHasRole", function(source, role) 
    return UserHasRole(GetDiscordID(source), role)
end)

exports("GetDiscordID", function(source)
    return GetDiscordID(source)
end)
