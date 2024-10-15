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
gridsize:    .byte 8,8  # Denote walls using '#'
character:   .byte 0,0  # Denote using '@'
box:         .byte 0,0  # Denote using '*'
target:      .byte 0,0  # Denote using 'X'

# Predetermined Object String Representations:
empty_space:    .string " "
newline:        .string "\n"
character_str:  .string "@"
box_str:        .string "*"
target_str:     .string "X"
empty_tile:     .string "."


.text
.globl _start

_start:
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

    # CHARACTER:
    # Obtain random values and keep them in $a0 and $a1:
    la t6, gridsize
    lb a0, 0(t6)  # Prepare the gridsize as the MAX for the function 
    jal generate_two_random_values

    # Modify the character byte array with $a0 and $a1, respectively:
    mv a2, a0  # put one of the random values as the third arg.
    # $a1 already contains another random int.
    la a0, character
    jal modify_byte_array

    # BOX (same logic):
    lb a0, 0(t6)  # Prepare the gridsize as the MAX for the function
    jal generate_two_random_values
    mv a2, a0  # move one value into a2
    la a0, box
    jal modify_byte_array

    # TARGET (same logic):
    lb a0, 0(t6)  # Prepare the gridsize as the MAX for the function
    jal generate_two_random_values
    mv a2, a0
    la a0, target
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
    jal print_board_state

    



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

    # TODO: That's the base game! Now, pick a pair of enhancements and
    # consider how to implement them.
	
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


# Obtain random values and keep them in $a0 and $a1:
# Arguments: an integer MAX in $a0
# Returns: Two numbers from 0 (inclusive) to MAX (exclusive), in $a0 and $a1
# Note: This function calls another function, so store $ra on the stack
generate_two_random_values:
    mv t0, a0  # $t0 also stores MAX, but so does $a0

    # Taking note of $ra:
    addi sp, sp, -4  # allocate 4 bytes on the stack
    sw ra, 0(sp)  # save the return address at the new $sp

    # Generating random numbers:
    jal notrand
    mv a3, a0  # $a3 stores a random number
    mv a0, t0  # move back MAX as an arg.
    jal notrand  # $a0 stores another random number

    # Grabbing the original $ra:
    lw ra, 0(sp)  # restore the original $ra from the stack
    addi sp, sp, 4  # deallocate the stack

    # Returning to the original ra:
    jr ra


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

    # Store board size:
    lb a0, 1(t6)  # t6 stores the gridsize address
    mv t2, a0  # also put the gridsize into $t2, num of columns

    # Take note of the current coordinate, starting at (0, 0)
    li t1, 0  # loop incrementor for FIRST_WHILE

    # Before the loop which prints the board, print the column numbers:
    jal print_column_numbers
    # Print a newline
    la a0, newline
    li a7, 4
    ecall
    # First loop - all rows
    FIRST_WHILE:
        bge t1, t2, EXIT_FIRST  # continue if y-coord in [0, gridsize - 1]

        # Before printing across, print the current row number:
        mv a0, t1  # move the incrementor value into a0 for printing
        li a7, 1  # prepare integer printing
        ecall

        li t0, 0  # loop incrementor for SECOND_WHILE
        # Second loop - tiles across columns, filling a row
        SECOND_WHILE:
            bge t0, t2, EXIT_SECOND  # continue if x-coord in [0, gridsize - 1]

            # Prepare arguments representing the current tile position:
            mv a0, t0
            mv a1, t1
            jal handle_tile_printing  # to print the object at the current tile

            addi t0, t0, 1  # to increment the x-value
            j SECOND_WHILE
        EXIT_SECOND:
        # After printing across, print the current row
        mv a0, t1
        li a7, 1
        ecall
        # Print a newline
        la a0, newline
        li a7, 4
        ecall


        addi t1, t1, 1  # to increment the y-value
        j FIRST_WHILE
    EXIT_FIRST:
    # After the while loop, print the column numbers.
    lb a0, 1(t6)  # restore the gridsize to $a0
    jal print_column_numbers
    # Print a newline, twice
    la a0, newline
    li a7, 4
    ecall
    ecall

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
    jr ra


# Checks if the provided tile is empty, a character, wall, box, or target,
# printing the corresponding object.
# Arguments:
# - $a0, the x-coord of the provided tile
# - $a1, the y-coord of the provided tile
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

################################################# EVERYTHING BELOW THIS HAS NOT BEEN CHECKED ####################################################

# Move the character based on input direction
# Arguments: $a0 = direction, (0 = left, 1 = right, 2 = up, 3 = down)
move_character:
    # Loading the character's coords:
    la t0, character  # load addr. of character
    lb t1, 0(t0)  # load character's x-coord into $t1
    lb t2, 1(t0)  # load character's y-coord into $t2

    # Load 1, 2, 3:
    li t3, 1
    li t4, 2
    li t5, 3

    # Checking the direction:
    beq a0, x0, move_left_char  # If $a0 == 0, move left
    beq a0, t3, move_right_char  # If $a0 == 1, move right
    beq a0, t4, move_up_char  # If $a0 == 2, move up
    beq a0, t5, move_down_char  # If $a0 == 3, move down

    # Check collision detection:
    # TODO: add this!

    # Store the new coords:
    sb t1, 0(t0)  # store x-coords into character
    sb t2, 1(t0)  # store y-coords into character

    # Return to $ra:
    jr ra

move_left_char:
    addi t1, t1, -1  # decrease x-coord (move left)
    j move_character_done

move_right_char:
    addi t1, t1, 1  # increase x-coord (move right)
    j move_character_done

move_up_char:
    addi t2, t2, -1  # decrease y-coord (move up; lower is greater)
    j move_character_done

move_down_char:
    addi t2, t2, 1  # increase y-coord
    # fall-thru

move_character_done:
    j move_character


# Move the box based on input direction
# Arguments: $a0 = direction (0 = left, 1 = right, 2 = up, 3 = down)
# Note: Uses the same logic as moving the character
move_box:
    # Load coords
    la t0, box
    lb t1, 0(t0)
    lb t2, 1(t0)

    # Check directions
    

    # Store new coords

    # Return to $ra
    jr ra


# Move the target based on input direction
# Arguments: $a0 = direction (0 = left, 1 = right, 2 = up, 3 = down)
# Note: Uses the same logic as moving the character
move_target:
    # Load coords
    la t0, target
    lb t1, 0(t0)
    lb t2, 1(t0)

    # Check directions

    # Store new coords

    # Return to $ra
    jr ra


ensure_solveable:

check_collisions:
