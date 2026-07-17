--!strict
-- EffectsController: visual \"juice\". Shows floating +N popups when grass is cut.
-- Crits are gold and sparkly. More effects (particles, sounds, shake) come in M7.

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local Remotes = require(ReplicatedStorage.Shared.Remotes)

local EffectsController = {}

local function showPopup(position: Vector3, amount: number, isCrit: boolean)
	-- Invisible anchor part carries the billboard text
	local anchor = Instance.new("Part")
	anchor.Anchored = true
	anchor.CanCollide = false
	anchor.CanQuery = false
	anchor.Transparency = 1
	anchor.Size = Vector3.new(0.1, 0.1, 0.1)
	anchor.Position = position + Vector3.new(math.random(-10, 10) / 10, 2.5, math.random(-10, 10) / 10)
	anchor.Parent = Workspace

	local billboard = Instance.new("BillboardGui")
	billboard.Size = isCrit and UDim2.fromOffset(180, 60) or UDim2.fromOffset(120, 40)
	billboard.AlwaysOnTop = true
	billboard.Parent = anchor

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.Font = Enum.Font.FredokaOne
	label.TextScaled = true
	label.Text = (isCrit and "\u{2728} +" or "+") .. tostring(amount)
	label.TextColor3 = isCrit and Color3.fromRGB(255, 200, 40) or Color3.fromRGB(190, 255, 120)
	label.TextStrokeTransparency = 0.4
	label.Parent = billboard

	-- Float up and fade out
	local tweenInfo = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(anchor, tweenInfo, { Position = anchor.Position + Vector3.new(0, 3, 0) }):Play()
	TweenService:Create(label, tweenInfo, { TextTransparency = 1, TextStrokeTransparency = 1 }):Play()
	Debris:AddItem(anchor, 0.8)
end

function EffectsController.Init()
	Remotes.Get("TileCut").OnClientEvent:Connect(function(position: Vector3, amount: number, isCrit: boolean)
		showPopup(position, amount, isCrit)
	end)
end

return EffectsController
