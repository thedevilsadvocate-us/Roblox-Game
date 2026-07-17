# Mow the Kingdom (Roblox)

An incremental Roblox game: mow an entire overgrown medieval kingdom, one blade at a time, upgrading from rusty shears to a robo-mower fleet.

- 📘 [Game Design Blueprint](docs/GAME_DESIGN.md)
- 🛠️ [Technical Plan](docs/TECH_PLAN.md)

## One-time setup (do these in order)

1. **Install Roblox Studio**: go to [create.roblox.com](https://create.roblox.com), log in with your Roblox account, click **Get Studio** and install it.
2. **Install Git**: download from [git-scm.com](https://git-scm.com/downloads) and install with default options.
3. **Install VS Code**: download from [code.visualstudio.com](https://code.visualstudio.com) and install.
4. **Clone this repository**: open VS Code → press `Ctrl+Shift+P` → type `Git: Clone` → press Enter → paste `https://gitlab.com/businessmans1984-group/roblox-game.git` → pick a folder → click **Open** when asked.
5. **Install the Rojo extension**: in VS Code, click the Extensions icon (four squares, left sidebar) → search `Rojo` → install **Rojo – Roblox Studio Sync** (by evaera).
6. **Install the Rojo Studio plugin**: press `Ctrl+Shift+P` → type `Rojo: Open Menu` → Enter. If prompted, let it install the Rojo binary. In the menu, click **Install Roblox Studio Plugin**.

## Every time you work on the game

1. Open the project folder in VS Code.
2. Press `Ctrl+Shift+P` → `Rojo: Open Menu` → click **default.project.json** to start the sync server (status bar shows Rojo running).
3. Open **Roblox Studio** → create/open a place (**New → Baseplate** the first time, then **File → Save to Roblox As...** to keep it).
4. In Studio: **Plugins** tab → **Rojo** button → **Connect**.
5. Code now syncs live from VS Code into Studio. Press **Play** (F5) in Studio to test.

### Verifying it works
After connecting and pressing Play, open the Output window in Studio (**View → Output**). You should see:

```
[Server] Initialized PlayerDataService
[Server] Mow the Kingdom server is running!
[Client] Mow the Kingdom client loaded!
```
