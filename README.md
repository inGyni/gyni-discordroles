# FiveM Discord Roles
**Retrieve a user's discord roles from a specific guild**

## How to use:

You have 3 exports:

* `GetUserRoles(source)` Returns all the user's roles into a Lua Table.
* `UserHasRole(source, role)` Returns a boolean
* `GetDiscordID(source)` Returns the user's discord id.

**Export examples:**

* `exports["resourcename"]:GetUserRoles(source)`
* `exports["resourcename"]:UserHasRole(source, roleid)`
* `exports["resourcename"]:GetDiscordID(source)`

This functions returns a boolean.

**NOTE:** `roleid` is the discord role id.
To get it you must enable developer mode in discord advanced settings, then right click the role and copy id.

## Configuration:
```lua
Config = {}

Config.BotToken = "" -- DISCORD BOT TOKEN
Config.GuildIDs = {  -- DISCORD SERVER IDs (GUILD IDs) FOR CHECKING
	"01234567890123456789",
	"01234567890123456789"
}
```

## Changelog

04/12/2022:
Added support for multiple guild checking.


## License 
`GNU GENERAL PUBLIC LICENSE V3.0`
