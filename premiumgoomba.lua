if not game:IsLoaded() then
    game.Loaded:Wait()
end

wait(math.random())

local games = {
    [33820338] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- AR
    --[7381705] = 'https://api.luarmor.net/files/v3/loaders/59349c34a86ce8d8b52691bc8df9a94c.lua', -- FISCH
    [9122948] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- AWTD
    [10611639] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- AA
    [17219742] = 'https://api.luarmor.net/files/v3/loaders/e00b1b0e84de58dc4a1c01dccfee7ed6.lua', -- AV
    [15009415] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- ARX
    [34063840] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- Anime Rising
    [35812225] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- AS2
    [5292947] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- AWTDX
	[10749844] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- AG
	[35139043] = 'https://api.luarmor.net/files/v3/loaders/20c88b02f28095d0b4187d98043d91fd.lua', -- AC
	[34873522] = 'https://api.luarmor.net/files/v3/loaders/12acd0668d7dbeb1246c3c53a26b129a.lua', -- AE
	[12229756] = 'https://api.luarmor.net/files/v3/loaders/daa049be0dc81633b3bca7fee91ca156.lua', -- ALS
	[35821155] = 'https://api.luarmor.net/files/v3/loaders/79bd179df58d5aba0b9569a61798ef2c.lua', -- AW
	[33861560] = 'https://api.luarmor.net/files/v3/loaders/b903396774d0a11fadefd37e41c98c44.lua', -- UTD
	[8204913] = 'https://api.luarmor.net/files/v3/loaders/db9c70e6f6933a5c4757c80fffefd51b.lua', -- UTD (OG)
	[35958846] = 'https://api.luarmor.net/files/v4/loaders/3589a9e33afc5013b0a37580bf98802b.lua', -- AP
	[35757133] = 'https://api.luarmor.net/files/v4/loaders/8701b873d7fe9f2b58fa6433e589aa35.lua', -- SoloHunters
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
