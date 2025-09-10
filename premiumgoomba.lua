if not game:IsLoaded() then
    game.Loaded:Wait()
end

wait(math.random())

local games = {
    [33820338] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- AR
    --[7381705] = 'https://api.luarmor.net/files/v3/loaders/59349c34a86ce8d8b52691bc8df9a94c.lua', -- FISCH
    [9122948] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- AWTD
    [10611639] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- AA
    [17219742] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- AV
    [15009415] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- ARX
    [34063840] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- Anime Rising
    [35812225] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- AS2
    [5292947] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- AWTDX
	[10749844] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- AG
	[35139043] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua' -- AC
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
