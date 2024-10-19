##############################################################################
### Author: Alexander He Meng
### Course: CSC258 by UTM's Department of Mathematical & Computational Sciences
### Project: A Game of Sokoban in RISC-V Assembly
### Due Date: October 19th, 2024
##############################################################################

# User Guide - Welcome to a Game of Sokoban!

## === Introduction ===
#### - Sokoban is a game which involves boxes, targets, walls, and a player character.
#### - The player is able to push boxes, but cannot pull!
#### - The objective is to fill all targets on the board by pushing boxes into them.
#### - The game is always generated to be solveable, so if the player is stuck, they must restart the game.

## Using CPULator to run this game...
### - With a browser and an internet connection, there is no need for a RISC-V processor and shoving in the entirety of the Sokoban.s code for a case of complex hardware.
### - Instead, navigate to `https://cpulator.01xz.net/?sys=rv32-spim` and run the game there! Here are the steps:
![Image of CPULator: https://prnt.sc/ykAUEHjLtbk6](https://prnt.sc/ykAUEHjLtbk6 "This is an image of CPULator")
### 1. Around the top middle of the website, hover over `File` and select `Open...`; alternatively, run `CTRL` + `O` for Windows OS users, or `CMD` + `O` for MAC OS users.
![Image of Opening File: https://prnt.sc/45QtQFzSMqtS](https://prnt.sc/45QtQFzSMqtS "This is an image of opening a file in CPULator")
### 2. Make sure to have the Sokoban.s file in an easy-access directory on your PC (such as the `Downloads` folder), and simply double-click or open it.
![Image of Opening File from File Explorer: https://prnt.sc/ZXVqNhfFbUQ2](https://prnt.sc/ZXVqNhfFbUQ2)
### 3. All of the code for this Sokoban game should develop into the main `Editor` panel located in the centre of the website.
![Image of CPULator After Loading Sokoban.s File: https://prnt.sc/ZvjuZPMSjoG3](https://prnt.sc/ZvjuZPMSjoG3)
### 4. Now, to run and start interacting with the game file, click the `Compile and Load` button (or use the `F5` shortcut key). If you cannot find this button, make sure you're viewing the `Editor` panel first; you can use the hotkeys `CTRL`/`CMD` + `E` to instantly navigate to the panel.
![Image of Directions to Run RISC-V File: https://prnt.sc/J7xSkvJm4PdG](https://prnt.sc/J7xSkvJm4PdG)
### 5. Then, click the `Continue` button located slightly above `Compile and Load`, or just left of the top-middle of the website.
![Image of Clicking the Continue Button: https://prnt.sc/ExQKJDXE131k](https://prnt.sc/ExQKJDXE131k)
### 6. Finally, focus your attention to the `Terminal` window. You've now run the game and can begin to play! Just make sure your cursor is focused on the window as well, which you can do with a quick click in the Terminal window.
![Image of the Terminal Window: https://prnt.sc/tQLZLAqrxuXZ](https://prnt.sc/tQLZLAqrxuXZ)
### 7. And if you have any issues, such as with messages from the `Messages` panel (located from along the bottom) indicating any sort of error, simply reload the page (`CTRL`/`CMD` + `R`) and repeat *Steps 1-6*. Enjoy!
![Image of Game in Console: https://prnt.sc/GS_sGiTT-bjk](https://prnt.sc/GS_sGiTT-bjk)

## How will the game represent walls or the character?
- In this implementation of the game, I end up not including any internal walls, so the walls are simply represented by the row and column numbers which surround the board (sort of like a border)!
- The character is represented by the '@' character.

## How can the user change the gameboard size?
- The user can change the gameboard size by directly modifying the data memory in the .s file.

## How will the game indicate that the character cannot move in the direction indicated by the user?
- The player character cannot move in the direction indicated by the user if and only if they try to exceed the boundaries of the board.
- In this case, the board will simply reflect no changes as the user is stuck in trying to collide with a wall boundary!

## How does the user indicate that they want to restart?
- During each game, the user has the option to reset their board by entering 'r' or 'R' as input through the console. The game will continually print prompt hints which suggest which commands are available to the user.
- After a full multiplayer game, where all players have completed their games, they have the option to completely restart all their games with the previously generated board, also by entering 'r' or 'R'.

## How will the game celebrate the player successfully solving the puzzle?
- After each user completes their puzzle, the game will indicate through the console that the user has won, along with the number of moves it took to complete the puzzle.
- After all players have completed their puzzle game, the game will indicate this, and it will proceeed to print a leaderboard of the top players.

## === Enhancement: Multiplayer ===
- Multiplayer is an enhancement which this Sokoban game incorporates, where the game prompts the user to enter the number of players for this game.
- The game will then consider as many simulations of the same generated game as there are players, and indicate above the board which player's turn it is.
- Each player will fully complete a play of the board until they win—that is, push the box into the target—before the next player begins to play.
- If a player gets stuck and/or chooses to reset their game during their play state, their moves will continually be tracked since their first. This means players cannot just play to figure out a strategy and simply reset the board prior to winning, only to exercise the optimal strategy after the reset.
- As hinted above, at the end of the game, the distributions of player scores (in least to greatest number of moves) is provided in the console, showing who performed the best to worst for the same generated game.

## That's It!
- These are all the insights needed to run and play this game of Sokoban, coded in RISC-V Assembly; enjoy!
