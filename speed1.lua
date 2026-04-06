local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local RunService = game:GetService("RunService")

local Window = Rayfield:CreateWindow({
   Name = "Survive the Apocalypse | Speed & Jump",
   LoadingTitle = "Завантаження...",
   LoadingSubtitle = "by Gemini",
})

local MainTab = Window:CreateTab("Головна", 4483362458)

-- Змінні для збереження налаштувань
_G.TargetSpeed = 16
_G.AntiSlow = true

-- Повзунок швидкості
MainTab:CreateSlider({
   Name = "Швидкість бігу (WalkSpeed)",
   Range = {16, 250},
   Increment = 1,
   Suffix = "spd",
   CurrentValue = 16,
   Callback = function(Value)
       _G.TargetSpeed = Value
       local char = game.Players.LocalPlayer.Character
       if char and char:FindFirstChild("Humanoid") then
           char.Humanoid.WalkSpeed = Value
       end
   end,
})

-- Функція Anti-Slow (працює постійно через Heartbeat)
RunService.Heartbeat:Connect(function()
    if _G.AntiSlow then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            -- Якщо гра намагається скинути швидкість (наприклад, після падіння)
            if char.Humanoid.WalkSpeed ~= _G.TargetSpeed then
                char.Humanoid.WalkSpeed = _G.TargetSpeed
            end
        end
    end
end)

-- Кнопка нескінченного стрибка
MainTab:CreateButton({
   Name = "Нескінченний стрибок (Infinite Jump)",
   Callback = function()
       game:GetService("UserInputService").JumpRequest:Connect(function()
           local char = game.Players.LocalPlayer.Character
           if char and char:FindFirstChildOfClass("Humanoid") then
               char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
           end
       end)
       
       Rayfield:Notify({
          Title = "Активовано",
          Content = "Тепер ви можете стрибати у повітрі!",
          Duration = 3
       })
   end,
})

MainTab:CreateSection("Статус")
MainTab:CreateToggle({
   Name = "Anti-Slow Active",
   CurrentValue = true,
   Callback = function(Value)
       _G.AntiSlow = Value
   end,
})
