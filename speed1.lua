local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "VMAXHUB | Final Fix",
   LoadingTitle = "123Запуск...",
   LoadingSubtitle = "by vibewmax",
})

local MainTab = Window:CreateTab("Головна", 4483362458)
local CombatTab = Window:CreateTab("Бой", 4483362458)

_G.TargetSpeed = 16
_G.AntiSlow = true
_G.InfJump = false
_G.KillAura = false
_G.AuraRange = 15

MainTab:CreateSlider({
   Name = "Speed",
   Range = {16, 200},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value) _G.TargetSpeed = Value end,
})

MainTab:CreateToggle({
   Name = "Anti-Slow",
   CurrentValue = true,
   Callback = function(Value) _G.AntiSlow = Value end,
})

MainTab:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Callback = function(Value) _G.InfJump = Value end,
})

CombatTab:CreateToggle({
   Name = "Kill Aura",
   CurrentValue = false,
   Callback = function(Value) _G.KillAura = Value end,
})

CombatTab:CreateSlider({
   Name = "Aura Range",
   Range = {5, 30},
   Increment = 1,
   CurrentValue = 15,
   Callback = function(Value) _G.AuraRange = Value end,
})

-- Логіка (Швидкість)
game:GetService("RunService").Heartbeat:Connect(function()
    pcall(function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            if _G.AntiSlow and char.Humanoid.WalkSpeed ~= _G.TargetSpeed then
                char.Humanoid.WalkSpeed = _G.TargetSpeed
            end
        end
    end)
end)

-- Логіка (Стрибок)
game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfJump then
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
        end)
    end
end)

-- Логіка (Аура)
game:GetService("RunService").Stepped:Connect(function()
    if _G.KillAura then
        local char = game.Players.LocalPlayer.Character
        local tool = char and char:FindFirstChildOfClass("Tool")
        if tool and char:FindFirstChild("HumanoidRootPart") then
            for _, v in pairs(game.Workspace:GetChildren()) do
                local eHuman = v:FindFirstChild("Humanoid")
                local eRoot = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("Head")
                if eHuman and eHuman.Health > 0 and v ~= char and eRoot then
                    if (char.HumanoidRootPart.Position - eRoot.Position).Magnitude <= _G.AuraRange then
                        tool:Activate()
                        local h = tool:FindFirstChild("Handle")
                        if h then
                            firetouchinterest(h, eRoot, 0)
                            firetouchinterest(h, eRoot, 1)
                        end
                        break
                    end
                end
            end
        end
    end
end)
