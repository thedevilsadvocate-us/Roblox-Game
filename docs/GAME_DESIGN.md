# Mow the Kingdom — Game Design Blueprint

## 1. Concept

**The Hook:** The Kingdom of Verdania has been abandoned for 100 years and is now buried under an ocean of overgrowth: **~2,000,000 blades of grass**. Armed with nothing but rusty shears, the player snips their way across the land to uncover roads, villages, farms, and finally the royal castle. Fully restore the kingdom, and the crown is theirs.

**Genre:** Incremental / grind-to-goal simulator (monotonous task → one massive goal), with deep upgrade-driven progression.

**Why it works:**
- Instantly readable goal with viral potential ("I mowed an ENTIRE KINGDOM")
- Progress is the map itself: every cleared tile stays cleared, restored zones visibly come alive
- Discovery buried under the grass keeps the grind exciting
- Constant sense of acceleration through upgrades

**Map model:** Every player has their **own private, persistent kingdom**. There is no shared community map. Servers act as social hubs (visiting, leaderboards, cosmetics show-off).

---

## 2. Core Loop (30-second cycle)

1. **Snip** grass with your tool (click/hold, AoE grows with upgrades)
2. **Collect Clippings** (in-game currency) that pop out of cut grass
3. **Discover** items hidden in the overgrowth: coins, chests, relics, trapped NPCs
4. **Spend Clippings** on upgrades → cut wider, faster, stronger
5. Zone fully cleared → **restoration event** → new zone unlocks → repeat, stronger

---

## 3. Progression & Upgrades

### 3.1 Big Upgrades (Clippings)

- **Tool tiers** (15 tiers): Rusty Shears (1 blade/snip) → Sickle → Scythe → Push Mower → Horse-Drawn Mower → Steam Mower → Riding Mower → Mechanized Harvester → ... → Robo-Mower (massive AoE)
- **Movement**: boots → horse → cart → mount upgrades
- **Auto-mowers**: deployable units (goats, sheep, robot mowers) that graze zones passively, including offline (capped)

### 3.2 Small Upgrades — "Kingdom Skills" (Clippings)

A leveled micro-upgrade tree. Each skill has 25–100 levels with small per-level gains and gently scaling costs, so there is **always something affordable to buy** between big purchases:

| Skill | Effect per level | Levels |
|---|---|---|
| Sharp Blades | +2% cut power | 100 |
| Quick Hands | +1% swing speed | 50 |
| Wide Arc | +0.5% cut radius | 50 |
| Swift Boots | +1% walk speed | 30 |
| Clipping Magnet | +2% collect range | 40 |
| Greener Thumb | +1% Clipping value | 100 |
| Lucky Snips | +0.2% crit chance | 50 |
| Golden Touch | +2% crit multiplier | 50 |
| Goat Whisperer | +1% auto-mower speed | 50 |
| Deep Pockets | +2% offline earnings cap | 25 |
| Treasure Sense | +1% rare find chance | 50 |
| Endurance | +1% sprint duration | 30 |

Design intent: hundreds of cheap incremental purchases smooth the progression curve and provide constant dopamine hits.

### 3.3 Luck & Crits

- "Golden Blade" critical snips (10x Clippings), chance and multiplier scale with skills
- Rare finds under grass: coins, chests, relics, pet eggs

---

## 4. Monetization (Robux)

**Golden rule:** everything that grants power is also earnable free, just slower. Robux is the skip lane at every scale. Cosmetics may be Robux-exclusive.

### 4.1 Direct purchases
- **Any big upgrade** (tool tier, mount, auto-mower) purchasable directly; price scales with tier (e.g., ~25 R$ early tiers → ~400 R$ top tiers)
- **Small upgrade bundles**: "+10 levels" for any Kingdom Skill (small cost) or "Max this skill" (medium cost)
- **Zone skip tokens**: instantly clear a zone's remaining grass (price scales with zone)
- **Prestige skip**: buy the permanent prestige multiplier early (premium price)

### 4.2 Gamepasses (permanent)
- 2x Clippings
- VIP Royal Scythe (permanent 3x snip power)
- Auto-Collect
- Extra Goat Slots (more auto-mowers)
- Teleport Anywhere
- 2x Offline Earnings
- Lucky Pass (2x rare finds)

### 4.3 Dev products (consumable)
- Timed boosts (e.g., 2x Clippings for 30 min)
- Clipping packs
- **Grass Bombs**: instantly clear a huge circle with a confetti explosion
- Premium pet eggs (better odds, exclusive pets)

### 4.4 Cosmetics shop (Robux)
- Tool skins, trails, crowns, pet accessories, victory emotes

### 4.5 Bundles
- One-time **Starter Pack** and **Mega Pack** (tool tier + skill levels + boost) — high-conversion value offers

---

## 5. Zones & Restoration (retention engine)

The kingdom is split into zones, each gated by the previous one's completion. Clearing a zone triggers a **restoration cutscene**: buildings repair themselves, flowers bloom, lights turn on, NPCs return with quests.

| Zone | Reveal & unlock |
|---|---|
| Village Outskirts (tutorial) | First NPC freed: the Old Gardener, your guide |
| Farmlands | Unlock goat auto-mowers; barn shop opens |
| The Royal Road | Fast-travel carts between cleared zones |
| Riverside Village | NPC quests, daily contracts board |
| The Hedge Maze | Puzzle zone: rare chests, first pet egg |
| Dark Forest Edge | Tougher "ironweed" grass, needs Tier 8+ tools |
| Castle Town | Marketplace, cosmetics shop, leaderboard plaza |
| **The Castle** | Throne room: claim the crown... and find the King's map showing **more overgrown kingdoms beyond the mountains** (prestige) |

### Pacing target
First kingdom (~2,000,000 blades) tuned so a free player reaches the castle in roughly **15–25 hours** of play.

### Prestige — "New Kingdom"
Claiming the crown awards a **permanent multiplier** + exclusive crown cosmetic, then unlocks the next kingdom: Desert Kingdom (cacti) → Frost Kingdom (frozen grass) → Shadow Kingdom (glowing nightgrass). Each kingdom is 5–10x bigger. Infinite scaling.

---

## 6. Retention & Social

- **Private kingdoms**: progress is 100% personal and persistent
- **Visiting**: players can visit friends' kingdoms to view progress and optionally grant a small "helper boost" (no actual mowing of others' maps)
- **Personal milestone rewards** for zone completions and blade-count thresholds
- **Pets**: hatched from eggs found under grass; they mow and collect alongside the player
- **Daily rewards, streaks, and quests** ("Cut 5,000 blades today")
- **Global leaderboards**: all-time blades cut, fastest zone clears, richest player
- **Limited-time events**: "Regrowth Weekend" (grass partially regrows, but 5x Clippings), seasonal grass skins (pumpkin patch, snow)

---

## 7. Aesthetic & Feel

- Bright, chunky **low-poly medieval** style (broad appeal, fast to build, performant)
- Heavy "juice": grass pops with particles and sound on every cut, satisfying number popups, screen shake on big AoE clears
- Gentle music that swells when a zone is restored

---

## 8. Open Questions / Next Steps

- Technical plan: Rojo project structure, folder layout
- Grass rendering & performance strategy (chunked grass tiles, streaming)
- Data persistence design (player kingdom state, upgrade levels, prestige)
- Economy tuning spreadsheet (costs, earn rates, pacing curve)
- MVP scope definition for first playable
