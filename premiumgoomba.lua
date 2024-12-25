if not game:IsLoaded() then
    game.Loaded:Wait()
end

wait(math.random())

local games = {
    [33820338] = 'https://api.luarmor.net/files/v3/loaders/b16e78543f4efbe5f9eca25340d77fbe.lua', -- AR
    [7381705] = 'https://api.luarmor.net/files/v3/loaders/59349c34a86ce8d8b52691bc8df9a94c.lua', -- FISCH
    [9122948] = 'https://api.luarmor.net/files/v3/loaders/0dfc6280be300724ee6253abc203ab74.lua' -- AWTD
    [10611639] = 'https://api.luarmor.net/files/v3/loaders/746d25796edc1fb2a94ff13422ab229a.lua' -- AA
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
