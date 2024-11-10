if not game:IsLoaded() then
    game.Loaded:Wait()
end

wait(math.random())

local games = {
    [33820338] = 'loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/b16e78543f4efbe5f9eca25340d77fbe.lua"))()',
}

if games[game.CreatorId] then
	task.wait(math.random())
	if game.CreatorId == 0 then
		print('in')
		repeat 
			loadstring(game:HttpGet(games[game.CreatorId]))()
			wait(10)
		until getgenv().GoombaHub ~= nil;
	else
		loadstring(game:HttpGet(games[game.CreatorId]))()
	end
end
