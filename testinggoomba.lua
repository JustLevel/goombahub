if not game:IsLoaded() then
    game.Loaded:Wait()
end

wait(math.random())

local games = {
    [5292947] = 'https://api.luarmor.net/files/v3/loaders/0806617fdbaf4671e167f19cb8820c77.lua', -- AWTDX
    [17219742] = 'https://api.luarmor.net/files/v3/loaders/0806617fdbaf4671e167f19cb8820c77.lua',
	[10749844] = 'https://api.luarmor.net/files/v3/loaders/0806617fdbaf4671e167f19cb8820c77.lua',
	[34873522] = 'https://api.luarmor.net/files/v3/loaders/0806617fdbaf4671e167f19cb8820c77.lua',
	[12229756] = 'https://api.luarmor.net/files/v3/loaders/0806617fdbaf4671e167f19cb8820c77.lua'
}

if games[game.CreatorId] then
	task.wait(math.random())
	if game.CreatorId == 33820338 then
		print('in')
		repeat 
			loadstring(game:HttpGet(games[game.CreatorId]))()
			wait(10)
		until getgenv().GoombaHub ~= nil;
	else
		loadstring(game:HttpGet(games[game.CreatorId]))()
	end
end
