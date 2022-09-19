# FiveM Discord Roles
**Retrieve a user's discord roles from a specific guild**

## How to use:

You have 3 exports:

* `GetUserRoles(source)` Retrieves all the user's roles into a Lua Table.
* `GetDiscordID(source)` Retrieves the user's discord id.
* `UserHasRole(source, role)` Returns a boolean

**Export example:**

`exports["resource"]:UserHasRole(source, role)`

This functions returns a boolean.

**NOTE:** `role` is the discord role id.
To get it you must enable developer mode in discord advanced settings, then right click the role and copy id.

## Configuration:
```lua
Config = {}

Config.BotToken = "" -- DISCORD BOT TOKEN
Config.GuildID = "" -- DISCORD SERVER ID (GUILD ID) FOR CHECKING
```


License: `GNU GENERAL PUBLIC LICENSE V3.0`
