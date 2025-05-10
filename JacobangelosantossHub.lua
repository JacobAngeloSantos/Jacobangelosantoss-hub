local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("Jacobangelosantoss Hub", "DarkTheme")
local Tab = Window:NewTab("Universal")
local Section = Tab:NewSection("Universal")
Section:NewButton("Fly gui", "Fly gui", function()
    loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\40\39\104\116\116\112\115\58\47\47\103\105\115\116\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\109\101\111\122\111\110\101\89\84\47\98\102\48\51\55\100\102\102\57\102\48\97\55\48\48\49\55\51\48\52\100\100\100\54\55\102\100\99\100\51\55\48\47\114\97\119\47\101\49\52\101\55\52\102\52\50\53\98\48\54\48\100\102\53\50\51\51\52\51\99\102\51\48\98\55\56\55\48\55\52\101\98\51\99\53\100\50\47\97\114\99\101\117\115\37\50\53\50\48\120\37\50\53\50\48\102\108\121\37\50\53\50\48\50\37\50\53\50\48\111\98\102\108\117\99\97\116\111\114\39\41\44\116\114\117\101\41\41\40\41\10\10")()
end)
Section:NewButton("3rd person", "you know what this does", function()
    -- LocalScript (place in StarterPlayerScripts) START LONG
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

camera.CameraType = Enum.CameraType.Scriptable

local cameraDistance = 10
local cameraHeight = 5
local minZoom, maxZoom = 5, 20
local rotationSpeed = 0.3

local yaw = 0
local rotating = false
local lastMousePosition = Vector2.zero

-- Input handlers
UserInputService.InputBegan:Connect(function(input, processed)
	if input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.Touch then
		rotating = true
		lastMousePosition = input.Position
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.Touch then
		rotating = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if rotating and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - lastMousePosition
		yaw = yaw - delta.X * rotationSpeed * 0.01
		lastMousePosition = input.Position
	elseif input.UserInputType == Enum.UserInputType.MouseWheel then
		cameraDistance = math.clamp(cameraDistance - input.Position.Z, minZoom, maxZoom)
	end
end)

-- Update camera position each frame
RunService.RenderStepped:Connect(function()
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local root = player.Character.HumanoidRootPart
		local direction = CFrame.new(Vector3.zero) * CFrame.Angles(0, yaw, 0)
		local offset = direction.LookVector * -cameraDistance + Vector3.new(0, cameraHeight, 0)
		camera.CFrame = CFrame.new(root.Position + offset, root.Position + Vector3.new(0, cameraHeight / 2, 0))
	    -- ENDDD
end)
end)
