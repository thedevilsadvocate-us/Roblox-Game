--!strict
-- StatCalculator: pure functions that turn profile data into gameplay stats.
-- Shared so server (authoritative) and client (display/prediction) always agree.

local GameConfig = require(script.Parent.GameConfig)

local SKILLS: { [string]: any } = GameConfig.SKILLS

local StatCalculator = {}

-- How many blades one swing cuts, given tool tier and Sharp Blades level
function StatCalculator.GetBladesPerSwing(toolTier: number, skills: { [string]: number }): number
	local tool = GameConfig.TOOL_TIERS[toolTier] or GameConfig.TOOL_TIERS[1]
	local sharpLevel = skills.SharpBlades or 0
	local multiplier = 1 + sharpLevel * SKILLS.SharpBlades.effectPerLevel
	return math.max(1, math.floor(tool.bladesPerSwing * multiplier + 0.5))
end

-- Seconds between swings, reduced by Quick Hands
function StatCalculator.GetSwingCooldown(skills: { [string]: number }): number
	local quickLevel = skills.QuickHands or 0
	return GameConfig.BASE_SWING_COOLDOWN / (1 + quickLevel * SKILLS.QuickHands.effectPerLevel)
end

-- Clipping cost of the next level of a skill (exponential growth)
function StatCalculator.GetSkillCost(skillName: string, currentLevel: number): number
	local skill = SKILLS[skillName]
	return math.floor(skill.baseCost * skill.costGrowth ^ currentLevel + 0.5)
end

return StatCalculator
