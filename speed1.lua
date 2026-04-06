local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Window = Rayfield:CreateWindow({
   Name = "VMAXHUB | Survive God",
   LoadingTitle = "1234Завантаження систем...",
   LoadingSubtitle = "by vibewmax",
})

local MainTab = Window:CreateTab("Головна", 4483362458)
local CombatTab = Window:CreateTab("Бой", 4483362458)

-- Налаштування (Змінні)
_G.TargetSpeed = 16
_G.AntiSlow = true
_G.InfJump = false
_G.KillAura = false
_G.AuraRange = 15

-- [ВКЛАДКА ГОЛОВНА]
MainTab:CreateSlider({
   Name = "Швидкість бігу (WalkSpeed)",
   Range = {16, 250},
   Increment = 1,
   Suffix = "spd",
   CurrentValue = 16,
   Callback = function(Value)
       _G.TargetSpeed = Value
   end,
})

MainTab:CreateToggle({
   Name = "Anti-Slow (Стабільний біг)",
   CurrentValue = true,
   Callback = function(Value)
       _G.AntiSlow = Value
   end,
})

MainTab:CreateToggle({
   Name = "Нескінченний стрибок",
   CurrentValue = false,
   Callback = function(Value)
       _G.InfJump = Value
   end,
})

-- [ВКЛАДКА БОЙ]
CombatTab:CreateToggle({
   Name = "Kill Aura (Авто-атака)",
   CurrentValue = false,
   Callback = function(Value)
       _G.KillAura = Value
   end,
})

CombatTab:CreateSlider({
   Name = "Радіус аури",
   Range = {5, 30},
   Increment = 1,
   Suffix = " studs",
   CurrentValue = 15,
   Callback = function(Value)
       _G.AuraRange = Value
   end,
})

-- ЛОГІКА ANTI-SLOW & SPEED
RunService.Heartbeat:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        if _G.AntiSlow and char.Humanoid.WalkSpeed ~= _G.TargetSpeed then
            char.Humanoid.WalkSpeed = _G.TargetSpeed
        end
    end
end)

-- ЛОГІКА НЕКСІНЧЕННОГО СТРИБКА
UserInputService.JumpRequest:Connect(function()
    if _G.InfJump then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end
end)

-- ЛОГІКА KILL AURA (ПОКРАЩЕНА)
RunService.Stepped:Connect(function()
    if _G.KillAura then
        local player = game.Players.LocalPlayer
        local char = player.Character
        local tool = char and char:FindFirstChildOfClass("Tool")
        
        if tool and char:FindFirstChild("HumanoidRootPart") then
            -- Шукаємо ворогів по всьому Workspace
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if not _G.KillAura then break end
                
                -- Перевірка: чи це Humanoid, чи він живий і чи це не ти
                if v:IsA("Humanoid") and v.Parent ~= char and v.Health > 0 then
                    local targetRoot = v.Parent:FindFirstChild("HumanoidRootPart") or v.Parent:FindFirstChild("Head")
                    
                    if targetRoot then
                        local dist = (char.HumanoidRootPart.Position - targetRoot.Position).Magnitude
                        
                        if dist <= _G.AuraRange then
                            -- Активація зброї
                            tool:Activate()
                            
                            -- Нанесення шкоди через дотик Handle
                            local handle = tool:FindFirstChild("Handle")
                            if handle then
                                firetouchinterest(handle, targetRoot, 0)
                                firetouchinterest(handle, targetRoot, 1)
                            end
                            break -- Б'ємо одну ціль за раз для швидкості
                        end
                    end
                end
            end
        end
