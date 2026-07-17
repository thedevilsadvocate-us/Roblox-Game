--!strict
-- UIController: builds and updates the HUD (Clippings counter) and the upgrade panel.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage.Shared.GameConfig)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local StatCalculator = require(ReplicatedStorage.Shared.StatCalculator)

local SKILLS: { [string]: any } = GameConfig.SKILLS

local UIController = {}

local clippingsLabel: TextLabel
local toolButton: TextButton
local skillButtons: { [string]: TextButton } = {}

local SKILL_ORDER = { "SharpBlades", "QuickHands" }
local SKILL_DISPLAY = {
	SharpBlades = "Sharp Blades (+2% power)",
	QuickHands = "Quick Hands (+1% speed)",
}

local function formatNumber(n: number): string
	local s = tostring(math.floor(n)):reverse()
	s = s:gsub("(%d%d%d)", "%1,")
	s = s:reverse()
	s = s:gsub("^,", "")
	return s
end

local function makeButton(parent: Instance): TextButton
	local button = Instance.new("TextButton")
	button.Size = UDim2.fromOffset(200, 54)
	button.BackgroundColor3 = Color3.fromRGB(76, 140, 60)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Font = Enum.Font.FredokaOne
	button.TextScaled = true
	button.Text = ""

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = button

	button.Parent = parent
	return button
end

local function buildGui()
	local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

	local gui = Instance.new("ScreenGui")
	gui.Name = "HUD"
	gui.ResetOnSpawn = false

	-- Clippings counter (top center)
	clippingsLabel = Instance.new("TextLabel")
	clippingsLabel.AnchorPoint = Vector2.new(0.5, 0)
	clippingsLabel.Position = UDim2.new(0.5, 0, 0, 8)
	clippingsLabel.Size = UDim2.fromOffset(260, 44)
	clippingsLabel.BackgroundColor3 = Color3.fromRGB(34, 66, 34)
	clippingsLabel.BackgroundTransparency = 0.2
	clippingsLabel.TextColor3 = Color3.fromRGB(190, 255, 120)
	clippingsLabel.Font = Enum.Font.FredokaOne
	clippingsLabel.TextScaled = true
	clippingsLabel.Text = "\u{1F33F} 0"

	local labelCorner = Instance.new("UICorner")
	labelCorner.CornerRadius = UDim.new(0, 10)
	labelCorner.Parent = clippingsLabel
	clippingsLabel.Parent = gui

	-- Upgrade panel (right side)
	local panel = Instance.new("Frame")
	panel.AnchorPoint = Vector2.new(1, 0.5)
	panel.Position = UDim2.new(1, -8, 0.5, 0)
	panel.Size = UDim2.fromOffset(220, 210)
	panel.BackgroundColor3 = Color3.fromRGB(34, 66, 34)
	panel.BackgroundTransparency = 0.3

	local panelCorner = Instance.new("UICorner")
	panelCorner.CornerRadius = UDim.new(0, 10)
	panelCorner.Parent = panel

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 8)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Parent = panel

	toolButton = makeButton(panel)
	for _, skillName in SKILL_ORDER do
		skillButtons[skillName] = makeButton(panel)
	end

	panel.Parent = gui
	gui.Parent = playerGui
end

local function updateUI(state: any)
	clippingsLabel.Text = "\u{1F33F} " .. formatNumber(state.clippings)

	local nextTool = GameConfig.TOOL_TIERS[state.toolTier + 1]
	if nextTool then
		toolButton.Text = `Next Tool: {nextTool.name}\n{formatNumber(nextTool.cost)} Clippings`
	else
		local current = GameConfig.TOOL_TIERS[state.toolTier]
		toolButton.Text = `Tool: {current.name} (MAX)`
	end

	for _, skillName in SKILL_ORDER do
		local button = skillButtons[skillName]
		local level = state.skills[skillName] or 0
		local def = SKILLS[skillName]
		if level >= def.maxLevel then
			button.Text = `{SKILL_DISPLAY[skillName]}\nLv {level} (MAX)`
		else
			local cost = StatCalculator.GetSkillCost(skillName, level)
			button.Text = `{SKILL_DISPLAY[skillName]}\nLv {level} \u{2192} {formatNumber(cost)} Clippings`
		end
	end
end

function UIController.Init()
	buildGui()

	toolButton.Activated:Connect(function()
		Remotes.Get("PurchaseUpgrade"):FireServer("tool")
	end)

	for skillName, button in skillButtons do
		button.Activated:Connect(function()
			Remotes.Get("PurchaseUpgrade"):FireServer("skill", skillName)
		end)
	end

	Remotes.Get("StateChanged").OnClientEvent:Connect(updateUI)
end

function UIController.Start()
	-- Ask the server for our first snapshot now that the UI exists
	Remotes.Get("RequestState"):FireServer()
end

return UIController
