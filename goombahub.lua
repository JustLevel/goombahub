if not game:IsLoaded() then
    game.Loaded:Wait()
end

wait(math.random())

local games = {
    [33820338] = 'https://api.luarmor.net/files/v3/loaders/79ccd93e0af9d6067ef3c778deffdc13.lua', -- AR FREE
    [9122948] = 'https://api.luarmor.net/files/v3/loaders/27aa6720384956de3f64bba503bca0a4.lua', -- AWTD FREE
    [10611639] = 'https://api.luarmor.net/files/v3/loaders/884122ebe7f689f7a9677fcf49a273e0.lua' -- AA Free
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
