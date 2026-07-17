# Mow the Kingdom — Technical Plan

## 1. Toolchain

| Tool | Purpose |
|---|---|
| **Roblox Studio** | The game engine and editor. The game runs and is published from here. |
| **VS Code** | Where all game code lives and is edited. |
| **Git + GitLab** | Version control. All code and design docs live in this repository. |
| **Rojo** | Syncs the `src/` folder from this repo into Roblox Studio in real time. |

**Why Rojo?** Roblox Studio normally stores scripts inside a binary place file, which cannot be version-controlled. Rojo lets us keep every script as a plain `.luau` file in this repo, and mirrors them into Studio automatically.

## 2. Project Structure

```
roblox-game/
├── default.project.json      # Rojo config: maps src/ folders into Roblox services
├── docs/                     # Design + technical documentation
└── src/
    ├── server/               # Runs on Roblox servers only (secure logic)
    │   ├── init.server.luau  # Server entry point (bootstraps all services)
    │   └── Services/         # One module per game system
    ├── client/               # Runs on each player's device (UI, effects, input)
    │   ├── init.client.luau  # Client entry point (bootstraps all controllers)
    │   └── Controllers/      # One module per client system
    └── shared/               # Code and config used by both server and client
        └── GameConfig.luau   # All tunable game numbers in one place
```

Mapping (see `default.project.json`):
- `src/server` → `ServerScriptService.Server`
- `src/client` → `StarterPlayer.StarterPlayerScripts.Client`
- `src/shared` → `ReplicatedStorage.Shared`

## 3. Architecture

### 3.1 Golden rules
1. **The server is the source of truth.** All currency, upgrade, and progress changes happen on the server. The client only *requests* actions and *renders* results. This prevents exploiters from giving themselves free Clippings.
2. **All tunable numbers live in `GameConfig.luau`.** Costs, multipliers, zone sizes — never hardcoded inside logic.
3. **One module per system.** Services (server) and Controllers (client) each own one responsibility.

### 3.2 Server services (build order)

| Service | Responsibility | Milestone |
|---|---|---|
| `PlayerDataService` | Load/cache/save player profiles (Clippings, upgrades, progress) | M1 (stub) / M2 (DataStore) |
| `GrassService` | Owns grass state per player kingdom; validates cut requests; awards Clippings | M1 |
| `UpgradeService` | Tool tiers + Kingdom Skills: validates purchases, applies effects | M1 |
| `ZoneService` | Zone completion detection, restoration events, zone gating | M3 |
| `MonetizationService` | Gamepasses, dev products, Robux purchase processing | M4 |
| `AutoMowerService` | Goats/robo-mowers, offline earnings | M5 |
| `PetService` | Pet hatching, equipping, pet mowing | M6 |

### 3.3 Client controllers

| Controller | Responsibility |
|---|---|
| `MowController` | Input handling, swing animation, sends cut requests |
| `UIController` | HUD (Clippings counter), shop menus, upgrade screens |
| `EffectsController` | Particles, sounds, number popups, screen shake ("juice") |
| `CameraController` | Restoration cutscenes |

### 3.4 Client–server communication
- A single `Remotes` folder in `ReplicatedStorage`, created by the server at startup
- `RemoteEvent`s for actions (RequestCut, PurchaseUpgrade) and state pushes (ClippingsChanged, ZoneRestored)
- Server **always validates**: is the player close enough to that grass? Can they afford that upgrade? Rate-limit cut requests to swing-speed cap

## 4. Grass System (performance strategy)

Naively placing ~2,000,000 grass parts would crash any device. Instead:

1. **Chunked tiles**: each zone is a grid of tiles (e.g., 4×4 studs). Each tile represents N "blades" (e.g., 50). Cutting a tile awards N blades of progress. ≈ 40k tiles total, streamed per zone — very manageable.
2. **Server state = numbers, not parts**: the server stores per-tile remaining-blade counts in tables, not physical objects.
3. **Client rendering**: visible grass tiles are rendered client-side near the player (visuals only). When a tile is cut, the server updates state; the client swaps the tile to "mowed" and plays effects.
4. **Zone streaming**: only the player's current zone is fully rendered; other zones show a cheap low-detail overgrowth shell.

## 5. Data Persistence

- Roblox **DataStore** (via ProfileStore module for session-locking and safety) — added in M2
- Per-player profile schema (v1):

```lua
{
  version = 1,
  clippings = 0,
  totalBladesCut = 0,
  toolTier = 1,
  skills = { SharpBlades = 0, QuickHands = 0, ... },
  zones = { ["VillageOutskirts"] = { tilesCut = 0, restored = false }, ... },
  prestige = 0,
  gamepasses = {},
  pets = {},
  loginStreak = 0,
}
```

- Zone tile detail is stored compactly (counts per chunk, not per tile) to stay under DataStore size limits

## 6. Milestones

| Milestone | Deliverable |
|---|---|
| **M0** | ✅ This scaffold: Rojo project syncs into Studio, server + client boot logs |
| **M1** | Core MVP: one test zone of grass tiles, click to mow, earn Clippings, HUD counter, first 3 tool tiers + 2 skills (data in memory only) |
| **M2** | Persistence: DataStore saving/loading, rejoin keeps progress |
| **M3** | Zones: full Zone 1–3 maps, zone completion + restoration events, gating |
| **M4** | Monetization: gamepasses, dev products, Robux upgrade purchases |
| **M5** | Auto-mowers + offline earnings |
| **M6** | Pets, dailies, quests, leaderboards |
| **M7** | Polish: cutscenes, music, effects pass, icon/thumbnails, publish |
