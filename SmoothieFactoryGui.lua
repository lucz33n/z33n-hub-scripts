-- Remove any existing GUI
if _G.CrateCollectorUI then
    _G.CrateCollectorUI:Destroy()
    _G.CrateCollectorUI = nil
end

-- Load the library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/lucz33n/z33n-ui-library/refs/heads/main/library.lua"))()

-- Create the main GUI window
local Window = Library.Window('Game Controls')

-- Keep a reference to the GUI for reloading
_G.CrateCollectorUI = Window.Frame -- Assuming the library exposes a `Frame` property for the main window

-- Create a Tab
local MainTab = Window.CreateTab('Main Controls')

-- Global variables to control the loops
_G.SMOOTHIEAUTOCRATES = false
_G.SMOOTHIEREBIRTH = false
_G.touchInterest = false

-- Function to handle crate interaction
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

-- Function to handle rebirth attempts
local function loopRebirth()
    while _G.SMOOTHIEREBIRTH do
        local success, errorMessage = pcall(function()
            print("Trying to open rebirth menu...")
            -- Trigger the rebirth button using firetouchinterest
            firetouchinterest(
                game:GetService('Players').LocalPlayer.Character.HumanoidRootPart,
                workspace.Tycoons.Tycoon1.RebirthButtons:GetChildren()[5].Button,
                0
            )
        end)

        if not success then
            warn("No rebirth button yet.....")
        end

        wait(10) -- Wait 10 seconds before the next attempt
    end
end

-- Function to prepare buttons for touch interaction
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

-- Function to handle touch interest
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

-- Prepare buttons initially
prepareButtons()

-- Create Toggles in the GUI
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

-- Add a label for clarity
MainTab.CreateLabel("Toggle auto crate collection, rebirth attempts, and touch interest.")
