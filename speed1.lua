local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Window = Rayfield:CreateWindow({
   Name = "VMAXHUB | Apocalypse God",
   LoadingTitle = "Ініціалізація бойових систем...",
   LoadingSubtitle = "by vibewmax",
})

local MainTab = Window:CreateTab("Головна", 4483362458)
local CombatTab = Window:CreateTab("Бой", 4483362458)

-- Змінні
_G.TargetSpeed = 16
_G.AntiSlow = true
_G.InfJump = false
_G.KillAura = false
_G.AuraRange = 15

-- [Вкладка Головна]
MainTab:CreateSlider({
   Name = "Швидкість бігу",
   Range = {16, 250},
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
   Name = "Нескінченний стрибок",
   CurrentValue = false,
   Callback = function(Value) _G.InfJump = Value end,
})

-- [Вкладка Бой]
CombatTab:CreateToggle({
   Name = "Kill Aura (Авто-атака)",
   CurrentValue = false,
   Callback = function(Value) _G.KillAura = Value end,
})

CombatTab:CreateSlider({
   Name = "Радіус аури",
   Range = {5, 30},
   Increment = 1,
   CurrentValue = 15,
   Callback = function(Value) _G.AuraRange = Value end,
})

-- Логіка Kill Aura
RunService.Stepped:Connect(function()
    if _G.KillAura then
        local player = game.Players.LocalPlayer
        local char = player.Character
        local tool = char and char:FindFirstChildOfClass("Tool")
        
        if tool and char:FindFirstChild("HumanoidRootPart") then
            -- Шукаємо найближчого ворога (NPC або Зомбі)
            for _, v in pairs(game.Workspace:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v ~= char then
                    local dist = (char.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                    
                    if dist <= _G.AuraRange and v.Humanoid.Health > 0 then
                        -- Симулюємо удар (активуємо інструмент)
                        tool:Activate()
                        
                        -- Для деяких ігор потрібно додатково викликати дотик Handle
                        local handle = tool:FindFirstChild("Handle")
                        if handle then
                            firetouchinterest(handle, v.HumanoidRootPart, 0)
                            firetouchinterest(handle, v.HumanoidRootPart, 1)
                        end
                        break -- Б'ємо одну ціль за раз для стабільності
                    end
                end
            end
        end
    end
end)

-- Інші функції (Jump & Speed)
UserInputService.JumpRequest:Connect(function()
    if _G.InfJump then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char.Humanoid:ChangeState("Jumping")
        end
    end
end)

RunService.Heartbeat:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") and _G.AntiSlow then
        if char.Humanoid.WalkSpeed ~= _G.TargetSpeed then
            char.Humanoid.WalkSpeed = _G.TargetSpeed
        end
    end
end)
