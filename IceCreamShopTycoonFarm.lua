-- WIP
local DiscordLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt"))()

local win = DiscordLib:Window("zeen hub")

local serv = win:Server("ZEEN CENTRAL", "")

local tgls = serv:Channel("IceCreamShopTycoon")

-- === AutoScoops Toggle ===
local autoScoopsEnabled = false

local function autoScoops()
    task.spawn(function()
        while autoScoopsEnabled do
            local success, err = pcall(function()
                local PublishTopic = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("TycoonService"):WaitForChild("RE"):WaitForChild("PublishTopic")

                for i = 1, 10 do
                    PublishTopic:FireServer("IceCreamStation1_AddScoop", i)
                    task.wait(0) -- small delay to prevent flood
                end
            end)

            if not success then
                warn("AutoScoops Error: " .. tostring(err))
            end

            wait(2) -- main loop delay
        end
    end)
end

tgls:Toggle("AutoScoops", false, function(bool)
    autoScoopsEnabled = bool
    if bool then
        DiscordLib:Notification("Notification", "Auto scoops started!", "Okay!")
        autoScoops()
    else
        DiscordLib:Notification("Notification", "Auto scoops stopped!", "Okay!")
    end
end)

tgls:Seperator()

-- === AutoRestockAll Toggle ===
local autoRestockEnabled = false

local function autoRestock()
    task.spawn(function()
        while autoRestockEnabled do
            local success, err = pcall(function()
                local InvokeTopic = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("TycoonService"):WaitForChild("RF"):WaitForChild("InvokeTopic")

                InvokeTopic:InvokeServer("ConeStock1_Restock")
                task.wait(0.2)

                for i = 1, 10 do
                    InvokeTopic:InvokeServer("RestockScoopFlavor", i)
                    task.wait(0.1)
                end

                InvokeTopic:InvokeServer("ToppingStock_Restock")
                task.wait(0.2)

                InvokeTopic:InvokeServer("FrozenGoods1_Restock")
            end)

            if not success then
                warn("AutoRestock Error: " .. tostring(err))
            end

            wait(5) -- main loop delay
        end
    end)
end

tgls:Toggle("AutoRestockAll", false, function(bool)
    autoRestockEnabled = bool
    if bool then
        DiscordLib:Notification("Notification", "Auto restock started!", "Okay!")
        autoRestock()
    else
        DiscordLib:Notification("Notification", "Auto restock stopped!", "Okay!")
    end
end)

tgls:Seperator()

-- === AutoTopping Toggle (Fixed) ===
local autoToppingEnabled = false

local function autoTopping()
    task.spawn(function()
        while autoToppingEnabled do
            local success, err = pcall(function()
                local PublishTopic = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("TycoonService"):WaitForChild("RE"):WaitForChild("PublishTopic")

                for i = 1, 30 do
                    PublishTopic:FireServer("ToppingStation1_DroppedTopping", i)
                    task.wait(0) -- safe delay to prevent crash
                end
                for i = 1, 30 do
                    PublishTopic:FireServer("ToppingStation2_DroppedTopping", i)
                    task.wait(0) -- safe delay to prevent crash
                end
            end)

            if not success then
                warn("AutoTopping Error: " .. tostring(err))
            end

            wait(2) -- main loop delay
        end
    end)
end

tgls:Toggle("AutoTopping", false, function(bool)
    autoToppingEnabled = bool
    if bool then
        DiscordLib:Notification("Notification", "Auto topping started!", "Okay!")
        autoTopping()
    else
        DiscordLib:Notification("Notification", "Auto topping stopped!", "Okay!")
    end
end)

-- Footer
serv:Channel("by zeen")

win:Server("Main", "http://www.roblox.com/asset/?id=6031075938")
