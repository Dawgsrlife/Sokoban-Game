# 🎮 Sokoban — RISC-V Assembly
_A Game of Sokoban by Alexander He Meng_  
_Last Updated: October 19th, 2024_

---

## 📜 Table of Contents
- [Introduction](#introduction)
- [Running the Game via CPULator](#running-the-game-via-cpulator)
- [Controls](#controls)
- [Features](#features)
- [Customization](#customization)
- [Enhancements](#enhancements)
- [Credits](#credits)

---

## 🟣 Introduction

Sokoban is a logic puzzle game where you push boxes onto target tiles within a grid.  
In this RISC-V Assembly implementation:
- You **push** boxes but **cannot pull**.
- The board is always solvable.
- Playable entirely in your browser without needing real RISC-V hardware.

---

## 🟢 Running the Game via CPULator

With an internet connection, you can run this game without any additional setup.

### Step-by-Step:

1. Visit [CPULator RV32-SPIM](https://cpulator.01xz.net/?sys=rv32-spim)  
   ![Step 1](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/1.png)

2. Load the game:  
   - Click `File > Open...`  
   - Or press `Ctrl + O` (Windows) / `Cmd + O` (Mac)  
   ![Step 2](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/2.png)

3. Select `Sokoban.s` from your computer (suggested: place it in `Downloads`).  
   ![Step 3](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/3.png)

4. The code will now load into the editor.  
   ![Step 4](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/4.png)

5. Compile the game:  
   - Click `Compile and Load`  
   - Or press `F5`  
   ![Step 5](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/5.png)

6. Click `Continue` to start.  
   ![Step 6](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/6.png)

7. Focus on the `Terminal` panel and start playing!  
   ![Step 7](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/7.png)

8. 💡 If you encounter errors, reload the page (`Ctrl + R` / `Cmd + R`) and restart from Step 1.  
   ![Step 8](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/8.png)

---

## 🎮 Controls

| Action | Input |
|--------|-------|
| Move Up | `W` or `w` |
| Move Down | `S` or `s` |
| Move Left | `A` or `a` |
| Move Right | `D` or `d` |
| Reset Board | `R` or `r` |

---

## ✨ Features

- **Guaranteed Solvable Boards**  
- **Multiplayer Mode**  
- **Leaderboard Generation**  
- **Player Character**: `@`  
- **Box**: `*`  
- **Target**: `X`  
- **Walls**: Outer borders (no internal walls)

---

## ⚙️ Customization

### Changing the Board Size
In `Sokoban.s`, adjust the `gridsize` variable in the `.data` section to change the board's dimensions.

### Resetting the Game
Type `r` at any time to restart your current attempt.

### Multiplayer
Specify the number of players at the start.  
Each player will play the same generated board in turn.  
After all players finish, a leaderboard will be displayed ranking players by move count.

---

## 🥇 Enhancements

- **Multiplayer Tracking**:  
  Each player is individually tracked. Resets do not erase the move count.
  
- **Replay Awareness**:  
  Players can't cheese by resetting to only save optimal runs.

- **Leaderboard**:  
  Printed after all players finish.

---

## 🙌 Credits

Made entirely in **RISC-V Assembly** by Alexander He Meng.

---

> 💬 Feel free to fork, modify, and play around with the code!
