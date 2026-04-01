local tool = script.Parent
local player = game.Players.LocalPlayer

local UserInputService = game:GetService("UserInputService")

local disparando = false
local cooldown = 0.1

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local texto = Instance.new("TextLabel")
texto.Parent = screenGui
texto.Size = UDim2.new(0, 200, 0, 50)
texto.Position = UDim2.new(0.5, -100, 0.7, 0)
texto.Text = "NAWELL"
texto.BackgroundTransparency = 1
texto.TextColor3 = Color3.fromRGB(255, 0, 0)
texto.TextScaled = true
texto.Visible = false

local function empezarDisparo()
    if disparando then return end
    disparando = true
    texto.Visible = true

    while disparando do
        if tool:FindFirstChild("RemoteEvent") then
            tool.RemoteEvent:FireServer()
        end
        wait(cooldown)
    end
end

local function pararDisparo()
    disparando = false
    texto.Visible = false
end

tool.Equipped:Connect(function()

    -- 📱 Touch (celular)
    UserInputService.TouchStarted:Connect(function()
        empezarDisparo()
    end)

    UserInputService.TouchEnded:Connect(function()
        pararDisparo()
    end)

    -- 🖱️ PC
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            empezarDisparo()
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            pararDisparo()
        end
    end)

end)
