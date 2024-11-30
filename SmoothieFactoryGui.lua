if _G.CrateCollectorUI then
    _G.CrateCollectorUI:Destroy()
    _G.CrateCollectorUI = nil
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/lucz33n/z33n-ui-library/refs/heads/main/library.lua"))()

local Window = Library.Window('Game Controls')

_G.CrateCollectorUI = Window.Frame

local MainTab = Window.CreateTab('Main Controls')

_G.SMOOTHIEAUTOCRATES = false
_G.SMOOTHIEREBIRTH = false
_G.touchInterest = false
_G.completeObbies = false

local function interactWithCrates()
    while _G.SMOOTHIEAUTOCRATES do
        local playerCharacter = game.Players.LocalPlayer.Character
        local humanoidRootPart = playerCharacter and playerCharacter:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart then
            for _, v in pairs(workspace.RandomCrateDropsFolder:GetDescendants()) do
                if v.Name == "TouchInterest" and v.Parent then
                    firetouchinterest(humanoidRootPart, v.Parent, 0)
                    print("Picked up crates!")
                end
            end
        end
        wait(0.1)
    end
end

local function loopRebirth()
    while _G.SMOOTHIEREBIRTH do
        local success, errorMessage = pcall(function()
            local playerCharacter = game:GetService("Players").LocalPlayer.Character
            local humanoidRootPart = playerCharacter and playerCharacter:FindFirstChild("HumanoidRootPart")
            local rebirthButton = workspace.Tycoons.Tycoon1.RebirthButtons:GetChildren()[5].Button

            if humanoidRootPart and rebirthButton then
                
                rebirthButton.CFrame = humanoidRootPart.CFrame * CFrame.new(0, -3, 0)
                print("Rebirth button teleported to player.")
            end
        end)

        if not success then
            warn("no rebirth button yet.")
        end

        wait(1) -- Check and teleport every second
    end
end


local function prepareButtons()
    local player = game:GetService("Players").LocalPlayer
    local tycoonName = player.Values.Plot.Value.Name

    for _, item in pairs(workspace.Tycoons[tycoonName].PurchaseButtons:GetDescendants()) do
        if item:IsA("BasePart") then
            item.CanCollide = false
            item.CanQuery = false
            item.Transparency = 1
        end
    end

    for _, item in pairs(workspace.Tycoons[tycoonName].UpgradeButtons:GetDescendants()) do
        if item:IsA("BasePart") then
            item.CanCollide = false
            item.CanQuery = false
            item.Transparency = 1
        end
    end
end

local function fireTouchInterests()
    local player = game:GetService("Players").LocalPlayer
    local tycoonName = player.Values.Plot.Value.Name

    while _G.touchInterest do
        local playerCharacter = player.Character
        local humanoidRootPart = playerCharacter and playerCharacter:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart then
            for _, v in pairs(workspace.Tycoons[tycoonName].PurchaseButtons:GetDescendants()) do
                if v.Name == "TouchInterest" and v.Parent then
                    firetouchinterest(humanoidRootPart, v.Parent, 0)
                end
            end

            for _, v in pairs(workspace.Tycoons[tycoonName].UpgradeButtons:GetDescendants()) do
                if v.Name == "TouchInterest" and v.Parent then
                    firetouchinterest(humanoidRootPart, v.Parent, 0)
                end
            end
        end
        wait(0.1)
    end
end

local function completeObbies()
    while _G.completeObbies do
        local playerCharacter = game.Players.LocalPlayer.Character
        local humanoidRootPart = playerCharacter and playerCharacter:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart then
            local obbyButtons = {
                workspace.Obbies.VolcanoObby.Finish.Button,
                workspace.Obbies.IceCavernObby.Finish.Button,
                workspace.Obbies.HardObby.Finish.Button,
                workspace.Obbies.GravityTowerObby.Finish.Button,
                workspace.Obbies.EasyObby.Finish.Button
            }

            for _, button in pairs(obbyButtons) do
                if button:FindFirstChild("TouchInterest") then
                    firetouchinterest(humanoidRootPart, button, 0)
                end
            end
        end
        wait(0.1)
    end
end

prepareButtons()

MainTab.CreateToggle("Enable Auto Crates", function(state)
    _G.SMOOTHIEAUTOCRATES = state
    if state then
        print("Auto Crates Enabled")
        task.spawn(interactWithCrates)
    else
        print("Auto Crates Disabled")
    end
end)

MainTab.CreateToggle("Enable Auto Rebirth", function(state)
    _G.SMOOTHIEREBIRTH = state
    if state then
        print("Auto Rebirth Enabled")
        task.spawn(loopRebirth)
    else
        print("Auto Rebirth Disabled")
    end
end)

MainTab.CreateToggle("Enable Auto Buy", function(state)
    _G.touchInterest = state
    if state then
        print("Auto Buy Enabled")
        task.spawn(fireTouchInterests)
    else
        print("Auto Buy Disabled")
    end
end)

MainTab.CreateToggle("Complete Obbies", function(state)
    _G.completeObbies = state
    if state then
        print("Obby Completion Enabled")
        task.spawn(completeObbies)
    else
        print("Obby Completion Disabled")
    end
end)

MainTab.CreateButton("Run Anti-AFK Script", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/lucz33n/z33n-hub-scripts/refs/heads/main/antiafk.lua'))()
    print("Anti-AFK Script Executed")
end)

MainTab.CreateLabel("made by z33n")
