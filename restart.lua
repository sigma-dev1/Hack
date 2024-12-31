local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local UIS = game:GetService("UserInputService")

-- Creazione del pulsante
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, -25)
button.Text = "Restart Terminal"
button.BackgroundColor3 = Color3.new(1, 0.5, 0)  -- Colore arancione
button.Parent = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")

-- Variabili per il trascinamento
local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = button.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

button.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Funzione di riavvio del terminale
local function restartTerminal()
    print("Restarting terminal...")
    os.execute("shutdown -r now")  -- Comando per riavviare il terminale
end

button.MouseButton1Click:Connect(restartTerminal)
