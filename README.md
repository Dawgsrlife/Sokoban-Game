# 🎮 Sokoban — RISC-V Assembly  
_A Game of Sokoban by Alexander He Meng_  
_Last Updated: October 19th, 2024_

![Built with RISC-V](https://img.shields.io/badge/Built%20with-RISC--V%20Assembly-blueviolet)
![Runs on CPULator](https://img.shields.io/badge/Platform-CPULator%20RV32--SPIM-brightgreen)
![Multiplayer Support](https://img.shields.io/badge/Feature-Multiplayer-informational)
![Status](https://img.shields.io/badge/Status-Playable%20%26%20Complete-success)

---

## 📜 Table of Contents
- [Introduction](#introduction)
- [Running the Game via CPULator](#running-the-game-via-cpulator)
- [Controls](#controls)
- [Features](#features)
- [Customization](#customization)
- [Enhancements](#enhancements)
- [Example Gameplay](#example-gameplay)
- [Credits](#credits)

---

## 🟣 Introduction

Sokoban is a legendary puzzle game about pushing boxes (`*`) onto targets (`X`).  
This implementation is fully written in **RISC-V Assembly**, made to run directly on **CPULator** without extra setup.

Features:
- Push-only box movement.
- Guaranteed solvable levels.
- Optional multiplayer mode.
- Runs fully in your browser.

---

## 🟢 Running the Game via CPULator

> 💡 **Tip:** You do NOT need any hardware or special toolchain. Just a browser.

---

### Step 1 — Launch CPULator  
[👉 CPULator RV32-SPIM](https://cpulator.01xz.net/?sys=rv32-spim)  
![Step 1](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/1.png)

---

### Step 2 — Load Sokoban  
Click `File > Open...` or press `Ctrl + O` / `Cmd + O`.  
![Step 2](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/2.png)

---

### Step 3 — Select Source  
Choose `sokobangame.s` from your computer.  
![Step 3](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/3.png)

---

### Step 4 — Editor View  
Your code appears here.  
![Step 4](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/4.png)

---

### Step 5 — Compile  
Click `Compile and Load` or press `F5`.  
![Step 5](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/5.png)

---

### Step 6 — Run  
Click `Continue` to begin.  
![Step 6](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/6.png)

---

### Step 7 — Play!  
The terminal is now active.  
![Step 7](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/7.png)

---

### Step 8 — Example Gameplay  
![Step 8](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/8.png)

---

> ⚠ **If you see any errors**, reload the page (`Ctrl + R`) and retry from Step 2.

---

## 🎮 Controls

| Action | Input |
|--------|-------|
| Move Up | `W` |
| Move Down | `S` |
| Move Left | `A` |
| Move Right | `D` |
| Reset Board | `R` |

> ✅ **Tip:** Commands are case-insensitive (`w`, `W` both work)

---

## ✨ Features

- ✔ **Guaranteed solvable board generation**  
- ✔ **Multiplayer support**  
- ✔ **Leaderboard generation**  
- ✔ **Replay-aware move tracking**  
- ✔ **Minimal and clear terminal UI**  
- ✔ 100% low-level implementation in **RISC-V Assembly**

---

## ⚙️ Customization

### Change Board Size
Modify the `.data` section:

```asm
.data
gridsize: .byte 8,8   # Change to any dimensions
```

---

### Multiplayer
The game will prompt:

```text
Enter the number of players (press Enter too!):
```

Specify the number of players, and each will take turns solving the board.  
A **leaderboard** will appear after all players finish.

---

### Reset Anytime
Just press:

```text
r
```

to reset your current run without affecting your move history (used for fairness in multiplayer).

---

## 🥇 Enhancements

- 🟣 **Replay-aware**: Resetting does not clear move counts.
- 🟣 **Leaderboard**: Sorted automatically.
- 🟣 **Shared Board**: Same randomly generated board for all players.
- 🟣 **Fair-play Enforcement**: No reset abuse.

---

## ✅ Example In-Game Prompt

```text
Make your move!
Left, Right, Up, or Down?
(Use your WASD keys! Or, use "r" to reset):
```

---

## 🙌 Credits

Developed by Alexander He Meng  
Contact: alex.meng@mail.utoronto.ca  
Course: CSC258 — Computer Organization  
Institution: University of Toronto

---

> 💬 Contributions, forks, and pull requests are welcome!
