local duh, duh1
repeat
    duh, duh1 = pcall(game.HttpGet, game, "https://raw.githubusercontent.com/JustLevel/goombahub/main/goombahub.lua")
    task.wait(1)
until duh and duh1 and not duh1:lower():find("too many requests")
loadstring(duh1)()
