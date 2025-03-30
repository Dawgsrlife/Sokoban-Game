# 🎮 Sokoban — RISC-V Assembly  
_A Sokoban Puzzle Game by Alexander He Meng_  
_Last Updated: October 19th, 2024_

![Built with RISC-V](https://img.shields.io/badge/Built%20with-RISC--V%20Assembly-blueviolet)
![Runs on CPULator](https://img.shields.io/badge/Platform-CPULator%20RV32--SPIM-brightgreen)
![Multiplayer Support](https://img.shields.io/badge/Feature-Multiplayer-informational)
![Status](https://img.shields.io/badge/Status-Playable%20%26%20Complete-success)

---

## 📚 Overview

> **Sokoban** is a classic puzzle game where you push boxes (`*`) onto target positions (`X`).  
This project is a **pure RISC-V Assembly** implementation, playable entirely inside CPULator (a browser-based simulator).  

💡 No installation, no build system — just run it directly online.

---

## 🎯 Features

- ✅ Guaranteed solvable puzzles
- ✅ Multiplayer Mode (up to any number of players)
- ✅ Reset-aware Move Tracking
- ✅ Leaderboard after all players finish
- ✅ Simple, responsive Terminal UI
- ✅ 100% Assembly implementation

---

## 💻 Running the Game

### ✅ Step 1 — Launch Simulator  
Open [CPULator RV32-SPIM](https://cpulator.01xz.net/?sys=rv32-spim)  
![Step 1](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/1.png)

---

### ✅ Step 2 — Open the Source File  
Go to `File > Open...` or press `Ctrl + O` / `Cmd + O`.  
![Step 2](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/2.png)

---

### ✅ Step 3 — Load `sokobangame.s`  
Select your downloaded `sokobangame.s` file.  
![Step 3](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/3.png)

---

### ✅ Step 4 — Compile the Program  
Click `Compile and Load` or press `F5`.  
![Step 5](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/5.png)

---

### ✅ Step 5 — Run  
Click `Continue`.  
![Step 6](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/6.png)

---

### ✅ Step 6 — Start Playing  
The Terminal will display your game!  
![Step 7](https://github.com/Dawgsrlife/Sokoban-Game/blob/main/User%20Guide%20Screenshots/7.png)

---

## 🎮 Controls

| Action | Key |
|--------|------|
| Move Up | `W` |
| Move Down | `S` |
| Move Left | `A` |
| Move Right | `D` |
| Reset | `R` |

> 💡 Resets do not clear your move history (important for fair multiplayer scoring).

---

## 🛠️ Customization

### Change Board Size

```asm
.data
gridsize: .byte 8,8   # Change dimensions here
```

---

## 🧑‍🤝‍🧑 Multiplayer Mode

Before starting, you’ll be asked:

```text
Enter the number of players:
```

Each player gets the same randomly generated board.  
The game automatically displays a **leaderboard** at the end.

---

## 🥇 Example Prompt

```text
Make your move!
Left, Right, Up, or Down?
(Use your WASD keys! Or, use "r" to reset):
```

---

## 🏆 Showcase / Demo

Coming soon!  
Recommended: Use **screen-to-gif** to capture CPULator gameplay for your Devpost demo.

---

## ✅ Notes for Devpost
> If you're submitting:
- Include screenshots exactly like above
- Optionally record gameplay
- Link this README directly under your “Demo / Setup” section
- Clearly state: "Playable fully online using CPULator (no install needed)"

---

## 🙌 Author

**Alexander He Meng**  
Email: alex.meng@mail.utoronto.ca  
GitHub: [github.com/Dawgsrlife](https://github.com/Dawgsrlife)  

---

> 💬 Contributions, forks, and PRs welcome!
