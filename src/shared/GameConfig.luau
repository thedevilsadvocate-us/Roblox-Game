--!strict
-- GameConfig: every tunable number in the game lives here.
-- Never hardcode balance values inside game logic; reference this module instead.

local GameConfig = {
	-- Economy
	CLIPPINGS_PER_BLADE = 1,
	CRIT_BASE_CHANCE = 0.01, -- 1% base "Golden Blade" chance
	CRIT_BASE_MULTIPLIER = 10,

	-- Grass tiles
	BLADES_PER_TILE = 50,
	TILE_SIZE_STUDS = 4,

	-- Tool tiers: bladesPerSwing = how many blades one swing cuts, cost in Clippings
	TOOL_TIERS = {
		{ name = "Rusty Shears", bladesPerSwing = 1, cost = 0 },
		{ name = "Sickle", bladesPerSwing = 3, cost = 100 },
		{ name = "Scythe", bladesPerSwing = 8, cost = 750 },
		-- Tiers 4-15 added in M1/M3 balancing pass
	},

	-- Kingdom Skills: small leveled upgrades
	SKILLS = {
		SharpBlades = { maxLevel = 100, effectPerLevel = 0.02, baseCost = 25, costGrowth = 1.08 },
		QuickHands = { maxLevel = 50, effectPerLevel = 0.01, baseCost = 40, costGrowth = 1.10 },
		-- Remaining skills added in M1
	},

	-- Swing
	BASE_SWING_COOLDOWN = 0.5, -- seconds between swings before QuickHands
	CUT_RANGE = 16, -- max studs between player and a tile to cut it

	-- Test meadow (M1): grid of tiles next to spawn
	MEADOW_GRID = 40, -- 40x40 tiles = 80,000 blades
}

return GameConfig
