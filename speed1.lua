local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Window = Rayfield:CreateWindow({
   Name = "VMAXHUB | Survive the Apocalypse",
   LoadingTitle = "loading...",
   LoadingSubtitle = "by vibewmax",
})

local MainTab = Window:CreateTab("Головна", 4483362458)

-- Змінні
_G.TargetSpeed = 16
_G.AntiSlow = true
_G.InfJump = false

-- Повзунок швидкості
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

-- Перемикач Anti-Slow
MainTab:CreateToggle({
   Name = "Anti-Slow (Стабільний біг)",
   CurrentValue = true,
   Callback = function(Value)
       _G.AntiSlow = Value
   end,
})

-- Перемикач Нескінченного стрибка
MainTab:CreateToggle({
   Name = "Нескінченний стрибок (Inf Jump)",
   CurrentValue = false,
   Callback = function(Value)
       _G.InfJump = Value
   end,
})

-- Обробка стрибка
UserInputService.JumpRequest:Connect(function()
    if _G.InfJump then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end
end)

-- Обробка швидкості (Anti-Slow)
RunService.Heartbeat:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        if _G.AntiSlow and char.Humanoid.WalkSpeed ~= _G.TargetSpeed then
            char.Humanoid.WalkSpeed = _G.TargetSpeed
        end
    end
end)

Rayfield:Notify({
    Title = "Скрипт активовано",
    Content = "Налаштуйте швидкість та стрибок у меню!",
    Duration = 5
})
