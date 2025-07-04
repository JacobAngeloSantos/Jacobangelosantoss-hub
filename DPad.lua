local player = game.Players.LocalPlayer

-- Disable default movement controls
player.DevTouchMovementMode = Enum.DevTouchMovementMode.Scriptable
player.DevComputerMovementMode = Enum.DevComputerMovementMode.Scriptable

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local runService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- GUI setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "DPadController"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 200)
frame.Position = UDim2.new(0, 30, 1, -250)
frame.BackgroundTransparency = 1
frame.Active = false
frame.Draggable = false

-- D-Pad directions (with arrows)
local directions = {
	{ Name = "Up",    Symbol = "↑", Position = UDim2.new(0.33, 0, 0, 0),     Direction = Vector3.new(0, 0, -1) },
	{ Name = "Down",  Symbol = "↓", Position = UDim2.new(0.33, 0, 0.66, 0),  Direction = Vector3.new(0, 0, 1) },
	{ Name = "Left",  Symbol = "←", Position = UDim2.new(0, 0, 0.33, 0),     Direction = Vector3.new(-1, 0, 0) },
	{ Name = "Right", Symbol = "→", Position = UDim2.new(0.66, 0, 0.33, 0),  Direction = Vector3.new(1, 0, 0) },
}

local activeDirection = nil

for _, data in ipairs(directions) do
	local btn = Instance.new("TextButton", frame)
	btn.Name = data.Name
	btn.Size = UDim2.new(0.33, 0, 0.33, 0)
	btn.Position = data.Position
	btn.Text = data.Symbol
	btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.AutoButtonColor = true
	btn.Font = Enum.Font.SourceSansBold
	btn.TextScaled = true

	btn.MouseButton1Down:Connect(function()
		activeDirection = data.Direction
	end)

	btn.MouseButton1Up:Connect(function()
		if activeDirection == data.Direction then
			activeDirection = nil
			humanoid:Move(Vector3.zero, false)
		end
	end)
end

-- Stop movement if input ends elsewhere
UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		activeDirection = nil
		humanoid:Move(Vector3.zero, false)
	end
end)

-- Move the player while button is held
runService.RenderStepped:Connect(function()
	if activeDirection and humanoid and humanoid.Parent then
		humanoid:Move(activeDirection, true)
	end
end)

-- 🆕 Jump button (with jump arrow symbol)
local jumpBtn = Instance.new("TextButton", screenGui)
jumpBtn.Name = "JumpButton"
jumpBtn.Size = UDim2.new(0, 100, 0, 50)
jumpBtn.Position = UDim2.new(0, 80, 1, -40)
jumpBtn.Text = "⭡" -- Jump arrow
jumpBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
jumpBtn.TextColor3 = Color3.new(1, 1, 1)
jumpBtn.Font = Enum.Font.SourceSansBold
jumpBtn.TextScaled = true

jumpBtn.MouseButton1Click:Connect(function()
	if humanoid and humanoid.Parent then
		humanoid.Jump = true
	end
end)
