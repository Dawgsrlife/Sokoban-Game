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

Sokoban is a logic puzzle game where you control a player to push boxes onto targets.  
This implementation is written entirely in **RISC-V Assembly**.

Features:
- Push-only movement.
- Guaranteed solvable boards.
- Multiplayer support.
- Works directly on the CPULator RV32 SPIM simulator.

---

## 🟢 Running the Game via CPULator

> 💡 **Tip:** You do NOT need a real RISC-V processor.

---

### Step 1 — Open CPULator
Visit 👉 [CPULator RV32-SPIM](https://cpulator.01xz.net/?sys=rv32-spim)  
![Step 1](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/1.png)

---

### Step 2 — Load the Game  
Click `File > Open...` or use `Ctrl + O` / `Cmd + O`.  
![Step 2](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/2.png)

---

### Step 3 — Select the Source File  
Choose `sokobangame.s` from your local folder.  
![Step 3](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/3.png)

---

### Step 4 — Loaded into the Editor  
Your code will appear in the center panel.  
![Step 4](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/4.png)

---

### Step 5 — Compile  
Click `Compile and Load` or press `F5`.  
![Step 5](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/5.png)

---

### Step 6 — Run the Game  
Click `Continue`.  
![Step 6](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/6.png)

---

### Step 7 — Terminal Display  
Focus on the terminal to start playing!  
![Step 7](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/7.png)

---

### Step 8 — In-Game Example  
Move using WASD, Reset using `R`.  
![Step 8](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/8.png)

> ⚠ **Note:** If you encounter errors, press `Ctrl + R` to reload and restart from Step 2.

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

- Guaranteed solvable board generation
- Multiplayer mode
- Leaderboard generation
- Replay-tracking to prevent cheating via resets
- Minimal but readable terminal UI
- 100% written in **RISC-V Assembly**

---

## ⚙️ Customization

### Change Board Size
Modify the `.data` section of `sokobangame.s` and adjust the `gridsize`.

### Reset
Type `r` anytime during your turn.

### Multiplayer
Enter the number of players at the start.  
After all players finish, the game prints a sorted leaderboard.

---

## 🥇 Enhancements

- 🔄 **Replay-aware resets** (moves still count)
- 🏆 **Leaderboard** shown at the end
- 🎭 **Equal board for all players** (fair multiplayer)
- 🟣 **Fully assembly-level** implementation

---

## 🙌 Credits

Developed by Alexander He Meng (alex.meng@mail.utoronto.ca)  
Made with ❤️ and lots of registers.

---

> 💬 Feel free to fork, play, or contribute!
