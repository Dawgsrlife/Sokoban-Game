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
gridsize:    .byte 8,8  # Denote walls using '#'
character:   .byte 0,0  # Denote using '@'
box:         .byte 0,0  # Denote using '*'
target:      .byte 0,0  # Denote using 'X'
board_state: .string "" # This will be constantly updated

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
    jal generate_two_random_values

    # Modify the character byte array with $a0 and $a1, respectively:
    mv a2, a0  # put one of the random values as the third arg.
    # $a1 already contains another random int.
    la a0, character 
    jal modify_byte_array

    # BOX (same logic):
    jal generate_two_random_values
    mv a2, a0  # move one value into a2
    la a0, box
    jal modify_byte_array

    # TARGET (same logic):
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
    mv a1, a0  # $a1 stores a random number
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
# - $a1 is the new first element
# - $a2 is the new second element
modify_byte_array:
    # Modify the first element:
    sb a1, 0(a0)

    # Modify the second element:
    sb a2, 1(a0)

    # Return to $ra
    jr ra


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
