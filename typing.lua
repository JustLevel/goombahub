if game.PlaceId == 12886143095 then

local args = {
    [1] = "GetGlobalData"
}

game:GetService("ReplicatedStorage").Remotes.InfiniteCastleManager:FireServer(unpack(args))

task.wait(0.4)

local args = {
    [1] = "GetData"
}

game:GetService("ReplicatedStorage").Remotes.InfiniteCastleManager:FireServer(unpack(args))

task.wait(1)

local args = {
    [1] = "Play",
    [2] = 0,
    [3] = "True"
}

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("InfiniteCastleManager"):FireServer(unpack(args))
end
