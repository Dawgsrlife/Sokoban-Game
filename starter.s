##############################################################################
# Author: Alexander He Meng
# Course: CSC258 by UTM's Department of Mathematical & Computational Sciences
# Project: A Game of Sokoban in RISC-V Assembly
# Due Date: October 18th, 2024
#
# NOTES:
# - In-line comments use the prefix '$' to denote registers.
# - 
##############################################################################

.data
# Game Setup and Object Coordinates:
gridsize:               .byte 8,8  # Denote walls using '#'
character:              .byte 0,0  # Denote using '@'
box:                    .byte 0,0  # Denote using '*'
target:                 .byte 0,0  # Denote using 'X'

# Predetermined Object String Representations:
empty_space:            .string " "
newline:                .string "\n"
character_str:          .string "@"
box_str:                .string "*"
target_str:             .string "X"
empty_tile:             .string "."

# Prompts
move_prompt:            .string "\nMake your move!\nLeft, Right, Up, or Down?\n(Use your WASD keys!): "
invalid_prompt:         .string "\nWoah there, please use your WASD keys and try again!\n"
win_prompt:             .string "\nCongratulations; you won!\n"

.text
.globl _start

_start:
    li a6, 0  # clean the win indicator register
    # MAYBE MAKE A FUNCTION TO CLEAN UP ALL THE REGISTERS!

    # TODO: Generate locations for the character, box, and target. Static
    # locations in memory have been provided for the (x, y) coordinates 
    # of each of these elements.
    # 
    # There is a notrand function that you can use to start with. It's 
    # really not very good; you will replace it with your own rand function
    # later. Regardless of the source of your "random" locations, make 
    # sure that none of the items are on top of each other and that the 
    # board is solvable.


    # Finding a random position for the character, box, and target:
    # Setup:
    la t6, gridsize
    lb t0, 0(t6)  # Prepare the MAX rows
    lb t1, 1(t6)  # Prepare the MAX columns

    # CHARACTER:
    # Obtain random values and keep them in $a0 and $a1:
    mv a0, t0  # arg. 1: MAX rows
    mv a1, t1  # arg. 2: MAX cols
    jal generate_two_random_values

    # Modify the character byte array with the valid RNG values
    la a0, character  # load the character coords as the first arg.
    jal modify_byte_array

    # BOX (need to avoid overlapping coords with CHARACTER):

    # TODO: ensure that generated coords aren't overlapping
    # with previously generated coords

    # Prepare MAX rows and MAX cols
    mv a0, t0
    mv a1, t1
    jal generate_two_random_values

    # Modify the box byte array with the valid RNG values
    la a0, box  # load the box coords as the first arg.
    jal modify_byte_array

    # TARGET:

    # TODO: ensure that generated coords aren't overlapping
    # with previously generated coords

    # Prepare MAX rows and MAX cols
    mv a0, t0
    mv a1, t1
    jal generate_two_random_values

    # Modify the target byte array with the valid RNG values
    la a0, target  # load the target coords as the first arg.
    jal modify_byte_array
   
    # TODO: Now, print the gameboard. Select symbols to represent the walls,
    # character, box, and target. Write a function that uses the location of
    # the various elements (in memory) to construct a gameboard and that 
    # prints that board one character at a time.
    # HINT: You may wish to construct the string that represents the board
    # and then print that string with a single syscall. If you do this, 
    # consider whether you want to place this string in static memory or 
    # on the stack.


    # Legend:
    # - Denote walls using '#'
    # - Denote the character using '@'
    # - Denote boxes using '*'
    # - Denote targets using 'X'

    # The board will be printed starting from the game loop below.

    # TODO: Enter a loop and wait for user input. Whenever user input is
    # received, update the gameboard state with the new location of the 
    # player (and if applicable, box and target). Print a message if the 
    # input received is invalid or if it results in no change to the game 
    # state. Otherwise, print the updated game state. 
    #
    # You will also need to restart the game if the user requests it and 
    # indicate when the box is located in the same position as the target.
    # For the former, it may be useful for this loop to exist in a function,
    # to make it cleaner to exit the game loop.
    GAME_LOOP:
        jal run_game

        # Check if a winner was received
        li t0, 127  # Winning flag
        beq t0, a6, win_game  # jump to win game function

        j GAME_LOOP

    # TODO: That's the base game! Now, pick a pair of enhancements and
    # consider how to implement them.

    # ENHANCEMENTS:

	
exit:
    li a7, 10
    ecall
    
    
# --- HELPER FUNCTIONS ---
# Feel free to use, modify, or add to them however you see fit.
     
# Arguments: an integer MAX in $a0
# Return: A number from 0 (inclusive) to MAX (exclusive)
notrand:
    mv t0, a0
    li a7, 30
    ecall             # time syscall (returns milliseconds)
    remu a0, a0, t0   # modulus on bottom bits 
    li a7, 32
    ecall             # sleeping to try to generate a different number
    jr ra


# Takes user input indefinitely until receiving a move
# which lies between 0 (inclusive) and MAX (exclusive).
#
# Updates (and prints to the console) the game
# with the result of the user input.
#
# Post-Conditions:
# - The intended move yields a valid tile exactly 1 unit
#   from the current tile.
# Return:
# - The WASD ASCII value for input direction in $a0
# - The move's row in $a1 and the move's column in $a2
run_game:
    la a0, gridsize  # prepare the gridsize
    la a1, move_prompt  # prepare the move prompt

    # Stash the $ra
    addi sp, sp, -4
    sw ra, 0(sp)

    lb t0, 0(a0)  # track the row bound
    lb t1, 1(a0)  # track the col bound

    # Grab the current player position:
    la a2, character
    lb a3, 0(a2)  # current row
    lb a4, 1(a2)  # current col

    # Take user input indefinitely
	addi sp, sp, -4
	sw a1, 0(sp)  # stash $a1
    # mv t5, a1  # Store the prompt address in $t5
    INPUT_LOOP:
        # Print the board state before asking for the move:
		jal print_board_state

        # Take user input for this "iteration"
        li a7, 4
		lw a0, 0(sp)  # retrieve $a1
        ecall
        
        li a7, 12  # take char (WASD move), stored in $a0
        ecall
        mv t6, a0  # take note of the actual WASD move

        # Print a newline for console spacing
        li a7, 4
        la a0, newline
        ecall
        
        # Determine the resultant move
        # $a0 stores the user input ASCII value
        mv a0, t6  # restore $a0
        mv a1, a3  # prepare current row
        mv a2, a4  # prepare current col

        jal handle_move_direction
        # $a1 and $a2 will store the intended move's coords

        # Loop back if the user does not move with WASD:
        # The previous function call would set $a0 to 0
        bne a0, zero, VALID_MOVE
        li a7, 4
        la a0, invalid_prompt
        ecall
        j INPUT_LOOP  # loop back

        VALID_MOVE:
        # Now, ($a1, $a2) should represent the new coordinates
        # of the user's intended move.

        # === BOUNDS!!! ===
        # Loop back if the intended move is not within the bounds:
        blt a1, zero, INPUT_LOOP  # lower bound for row
        bge a1, t0, INPUT_LOOP  # upper bound for row
        blt a2, zero, INPUT_LOOP  # lower bound for col
        bge a2, t1, INPUT_LOOP  # upper bound for col
        
        # If there is no loopback, then return the coords
        # in $a1 and $a2.

        # Assert $t0 and $t1 store the max number of rows and columns.
        # Write the intended move into memory:
		jal handle_move_behaviour

        # $t6 should still store the direction char ASCII value

    # Retrieve the $ra
	addi sp, sp, 4  # restore the stack pointer to where $ra is stashed
    lw ra, 0(sp)
    addi sp, sp, 4  # restore the stack pointer to its original position

    jr ra  # to return


# Determines the resultant move and returns the corresponding coordinates.
# Arguments:
# - $a0, the move ASCII value
# - $a1, the row number
# - $a2, the column number
# Return:
# - $a0 becomes zero if $a0 wasn't originally one of WASD.
# - The updated $a1 and $a2, representing the new coords from the move.
handle_move_direction:
    # Determine the resultant move
    # Move Up:
    li t2, 87  # Uppercase W
    beq a0, t2, MOVE_UP
    li t2, 119  # lowercase w
    beq a0, t2, MOVE_UP
    # Move Down:
    li t2, 83  # Uppercase S
    beq a0, t2, MOVE_DOWN
    li t2, 115  # lowercase s
    beq a0, t2, MOVE_DOWN
    # Move Left:
    li t2, 65  # Uppercase A
    beq a0, t2, MOVE_LEFT
    li t2, 97  # lowercase a
    beq a0, t2, MOVE_LEFT
    # Move Right:
    li t2, 68  # Uppercase D
    beq a0, t2, MOVE_RIGHT
    li t2, 100  # lowercase d
    beq a0, t2, MOVE_RIGHT

    # This means $a0 was not one of WASD
    li a0, 0
    jr ra

    # Determine the coords of the new move
    MOVE_UP:
        addi a1, a1, -1
        j DONE_MOVE
    MOVE_DOWN:
        addi a1, a1, 1
        j DONE_MOVE
    MOVE_LEFT:
        addi a2, a2, -1
        j DONE_MOVE
    MOVE_RIGHT:
        addi a2, a2, 1
        # fall through
    DONE_MOVE:

    # Return
    jr ra


# Handle the move behaviour depending on the user's input
# Arguments:
# - $a0, the WASD direction char ASCII of the move
# - $a1, the intended row to move towards
# - $a2, the intended column to move towards
# Preconditions:
# - Assume the intended new coordinate is correctly bounded,
#   and that it is exactly 1 unit from the current coordinate.
handle_move_behaviour:
    # Stash $ra
    addi sp, sp, -4
    sw ra, 0(sp)

    # Take note of the intended move
    mv t5, a1
    mv t6, a2

    # Take note of the Box's coords
    la a5, box
    lb a3, 0(a5)  # row of box
    lb a4, 1(a5)  # col of box

    bne a1, a3, UPDATE_PLAYER_COORDS  # compare to player row
    bne a2, a4, UPDATE_PLAYER_COORDS  # compare to player col
    # Reaching here means the player intends to "move into a box"
    # Player Pushes Box Case:

    # Now, call the box-handling function

    # This function should use the same args. as the given params.
    # Params. $a1 and $a2 are directly the args.
    # Assert $t0 and $t1 store the max number of rows and columns
    jal handle_box_move  # sets $a0 to 0 if box doesn't move
    # Check if the box was moved
    beq a0, zero, NO_UPDATES

    UPDATE_PLAYER_COORDS:
    la t0, character
    sb t5, 0(t0)
    sb t6, 1(t0)

    NO_UPDATES:
    # Retrieve $ra
    lw ra, 0(sp)
    addi sp, sp, 4  # deallocate the stack

    # Return
    jr ra


# Uses the suggested moving direction to determine whether
# the box can move or not. Make the move if it is possible.
#
# Arguments:
# - $a0, the WASD direction to which the Box moves
# - $a1 and $a2 as the current row and column of the Box
# Returns: $a0 is 0 if the box was not moved
handle_box_move:
    # Stash the return address
    addi sp, sp, -4
    sw ra, 0(sp)

    # Hypothetical Box Move:
    jal handle_move_direction
    # $a0 is zero if it wasn't one of WASD.
    # $a1 and $a2 become the intended coords of the box movement

    # Check bounds for box:
    blt a1, zero, BOX_NOT_MOVED
    bge a1, t0, BOX_NOT_MOVED  # Assume $t0 stores num of rows
    blt a2, zero, BOX_NOT_MOVED
    bge a2, t1, BOX_NOT_MOVED  # Assume $t1 stores num of cols

    # Make the move if the bound check passes
    # NOT IMPLEMENTED: May want to do more checks before making the move
    j MOVE_DONE

    # The Box would go out of bounds
    BOX_NOT_MOVED:
    li a0, 0  # Indicate that the box has not moved
    j BOX_RETURN

    # If the box is moved by the player,
    # then the move must be in WASD
    MOVE_DONE:
    # NOT IMPLEMENTED: The Box would hit an Inner Wall

    # NOT IMPLEMENTED: The Box would hit a Box

    la t0, target
    lb t1, 0(t0)  # row of target
    lb t2, 1(t0)  # col of target
    # Compare new box move's coords to target coords 
    bne a1, t1, MOVE_BOX
    bne a2, t2, MOVE_BOX
    # The Box would enter a Target
    li a6, 127  # to indicate that the game is won!

    # The Box and Target coordinates should be the same
    # Let fall-through into the following label handle storing new box coords

    MOVE_BOX:
    # The Box would move freely (air)
    la t0, box
    sb a1, 0(t0)  # store new row of box
    sb a2, 1(t0)  # store new col of box

    # RETURN
    BOX_RETURN:
    # Retrieve the return address
    lw ra, 0(sp)
    addi sp, sp, 4  # deallocate the stack

    jr ra


# Obtain random values and keep them in $a0 and $a1:
# Arguments: MAX number of rows in $a0 and MAX number of columns in $a1
# Returns:
# - In $a1: a random row between 0 (inclusive) and MAX rows (exclusive)
# - In $a2: a random row between 0 (inclusive) and MAX cols (exclusive)
# Note: This function calls another function, so store $ra on the stack
generate_two_random_values:
    mv t2, a1  # temp store MAX columns in $t2

    # Taking note of $ra:
    addi sp, sp, -4  # allocate 4 bytes on the stack
    sw ra, 0(sp)  # save the return address at the new $sp

    # Generating random numbers:
    # $a0 currently stores MAX rows
    jal notrand  # returns a random valid row in $a0
    mv a3, a0  # put it temporarily into $a3 to avoid losing it

    # $t2 currently stores MAX cols
    mv a0, t2  # prepare $a0 = num of columns
    jal notrand  # returns a random valid column; $a0 is MAX cols
    mv a2, a0  # put it into $a2
    mv a1, a3  # bring $a3 into $a1 to match returns

    # Grabbing the original $ra:
    lw ra, 0(sp)  # restore the original $ra from the stack
    addi sp, sp, 4  # deallocate the stack

    # Returning to the original ra:
    jr ra


ensure_unique_coordinates:
    RNG_LOOP:
        # TODO: COMPLETE THIS!


# Modifies the values of the given byte:
# Arguments:
# - $a0 is the byte in memory
# - $a3 is the new first element
# - $a2 is the new second element
modify_byte_array:
    # Modify the first element:
    sb a3, 0(a0)

    # Modify the second element:
    sb a2, 1(a0)

    # Return to $ra
    jr ra


# Prints the current board state to the console
print_board_state:
    # This function calls at least one other function:
    addi sp, sp, -4
    sw ra, 0(sp)

    # Load the gridsize address (to be safe)
    la t6, gridsize

    # Store board size:
    # $t6 currently stores the gridsize address
    lb t2, 0(t6)  # $t2 refers to the number of rows
    lb a0, 1(t6)  # $a0 refers to the number of columns
    mv t6, a0  # make $t6 also refer to the number of columns

    # Initialize the row counter
    li t0, 0  # loop incrementor for FIRST_WHILE

    # Before the loop which prints the board, print the column numbers:
    jal print_column_numbers

    # First loop - all rows
    FIRST_WHILE:
        bge t0, t2, EXIT_FIRST  # continue if y-coord in [0, gridsize - 1]

        # Before printing across, print the current row number:
        mv a0, t0  # move the incrementor value into $a0 for printing
        li a7, 1  # prepare integer printing
        ecall

        # Initialize the column counter
        li t1, 0  # loop incrementor for SECOND_WHILE
        # Second loop - tiles across columns, filling a row
        SECOND_WHILE:
            bge t1, t6, EXIT_SECOND  # continue if x-coord in [0, gridsize - 1]

            # Prepare arguments representing the current tile position:
            mv a0, t0  # arg: row number
            mv a1, t1  # arg: col number
            jal handle_tile_printing  # to print the object at the current tile

            addi t1, t1, 1  # to increment the current column
            j SECOND_WHILE
        EXIT_SECOND:
        # After printing across, print the current row
        mv a0, t0
        li a7, 1
        ecall
        # Print a newline
        la a0, newline
        li a7, 4
        ecall


        addi t0, t0, 1  # to increment the current row
        j FIRST_WHILE
    EXIT_FIRST:
    # After the while loop, print the column numbers.
    mv a0, t6
    jal print_column_numbers

    # Undo the stack pointer
    lw ra, 0(sp)
    addi sp, sp, 4

    # Return to the address of the original function call
    jr ra


# Prints a row of just the numbers of each column.
# Arguments: $a0, the grid size
print_column_numbers:
    li t3, 0  # loop accumulator
    mv a2, a0  # stores the grid size

    WHILE:
        bge t3, a2, EXIT_WHILE
        
        li a7, 1  # prepare integer printing
        mv a0, t3  # move the loop accumulator into a0 for printing
        ecall

        addi t3, t3, 1  # increment loop accumulator
        j WHILE
    EXIT_WHILE:
        # Print a newline
        la a0, newline
        li a7, 4
        ecall

    jr ra


# Checks if the provided tile is empty, a character, wall, box, or target,
# printing the corresponding object.
# Arguments:
# - $a0, the row of the provided tile
# - $a1, the column of the provided tile
handle_tile_printing:
    # Compare to character
    la t3, character
    lb t4, 0(t3)
    lb t5, 1(t3)
    # Check if the character x- and y-values are the current
    bne a0, t4, not_char
    bne a1, t5, not_char
    # Proceed to print the character if passes
    la a0, character_str
    li a7, 4  # prepare string printing
    ecall
    j done_tile  # jump to the end of funct.

    not_char:
    # Compare to box
    la t3, box
    lb t4, 0(t3)
    lb t5, 1(t3)
    # Check if the box x- and y-values are the current
    bne a0, t4, not_box
    bne a1, t5, not_box
    # Proceed to print the box if passes
    la a0, box_str
    li a7, 4
    ecall
    j done_tile  # jump to the end of funct.
    
    not_box:
    # Compare to target
    la t3, target
    lb t4, 0(t3)
    lb t5, 1(t3)
    # Check if the target x- and y-values are the current
    bne a0, t4, not_target
    bne a1, t5, not_target
    # Proceed to print the target if passes
    la a0, target_str
    li a7, 4
    ecall
    j done_tile
    
    not_target:
    # Print the empty tile
    la t3, empty_tile
    mv a0, t3
    li a7, 4
    ecall
    # fall-through

    done_tile:
    jr ra  # jump back to the return address of this function call


# End the game and report that the game is won!
win_game:
    # Print out the win prompt:
    li a7, 4
    la a0, win_prompt

    # Exit the program
    j exit

################################################# EVERYTHING BELOW THIS HAS NOT BEEN CHECKED ####################################################

# Move the character based on input direction
# Arguments: $a0 = direction, (0 = left, 1 = right, 2 = up, 3 = down)
# move_character:
#     # Loading the character's coords:
#     la t0, character  # load addr. of character
#     lb t1, 0(t0)  # load character's x-coord into $t1
#     lb t2, 1(t0)  # load character's y-coord into $t2

#     # Load 1, 2, 3:
#     li t3, 1
#     li t4, 2
#     li t5, 3

#     # Checking the direction:
#     beq a0, x0, move_left_char  # If $a0 == 0, move left
#     beq a0, t3, move_right_char  # If $a0 == 1, move right
#     beq a0, t4, move_up_char  # If $a0 == 2, move up
#     beq a0, t5, move_down_char  # If $a0 == 3, move down

#     # Check collision detection:
#     # TODO: add this!

#     # Store the new coords:
#     sb t1, 0(t0)  # store x-coords into character
#     sb t2, 1(t0)  # store y-coords into character

#     # Return to $ra:
#     jr ra

# move_left_char:
#     addi t1, t1, -1  # decrease x-coord (move left)
#     j move_character_done

# move_right_char:
#     addi t1, t1, 1  # increase x-coord (move right)
#     j move_character_done

# move_up_char:
#     addi t2, t2, -1  # decrease y-coord (move up; lower is greater)
#     j move_character_done

# move_down_char:
#     addi t2, t2, 1  # increase y-coord
#     # fall-thru

# move_character_done:
#     j move_character


# # Move the box based on input direction
# # Arguments: $a0 = direction (0 = left, 1 = right, 2 = up, 3 = down)
# # Note: Uses the same logic as moving the character
# move_box:
#     # Load coords
#     la t0, box
#     lb t1, 0(t0)
#     lb t2, 1(t0)

#     # Check directions
    

#     # Store new coords

#     # Return to $ra
#     jr ra


# # Move the target based on input direction
# # Arguments: $a0 = direction (0 = left, 1 = right, 2 = up, 3 = down)
# # Note: Uses the same logic as moving the character
# move_target:
#     # Load coords
#     la t0, target
#     lb t1, 0(t0)
#     lb t2, 1(t0)

#     # Check directions

#     # Store new coords

#     # Return to $ra
#     jr ra


# ensure_solveable:

# check_collisions:
