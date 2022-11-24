#####################################################################
#
# CSC258H5S Fall 2021 Assembly Final Project
# University of Toronto, St. George
#
# Student: Zhiqi Zhao, Student Number 1006675634
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1/2/3/4/5 (choose the one the applies)
# milestone 5
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)

# 1. Display the number of lives remaining 
#    (displayed on the top left corner of the screen)

# 2. After final player death, display game over/retry screen. 
#    Restart the game if the “retry” option is chosen.
#    After final death, there will a 0 showed on the top left of the screen 
#    and player can press "r" to restart	

# 3. Add extra random hazards
#    2 black spiders (represented by  black dots) may randomly show up in 
#    goal area, which can kill the frog.

# 4. Dynamic increase in difficulty 
#    The probability of the 2 black spiders showing up will be p if the play
#    has 0 score. After the play get 1 score, the probability the 2 black spiders 
#    showing up will be 8p, which makes the player evidently harder to get the
#    second score.

# 5.Display a death/respawn animation each time the player loses a frog.

# 6. Add powerups to scene.(extra lives)
#    There are two red region in safe area. If the frog go to one of the
#    region, the frog's lives will be 3 even if it has lost some lives already. 

# 7. Display the player’s score at the top of the screen.
#    The score is displayed on the top right of the screen, and it is representd
#    by the number of red square. (0 square for 0 score, 1 square for score, etc.)

# 8. Make the frog point in the direction that it’s traveling 

# Any additional information that the TA needs to know:
# 
# additional keyboard instructions:
# f: move up by 4 units
# r: restry if 3 lives of frog are all run out
#####################################################################
Start:
.data
	displayAddress: .word 0x10008000
	frogX: 14
	frogY: 28
	array: .space 128 #for first road row 
	array2: .space 128 #for second road row
	array3: .space 128 #for first water row
	array4: .space 128 #for second water row
	backgroundColour: .word 0x00ff00 # for storing start, safe, goal colour
	xbottom1: .word 0,1,2,3,4,5
	xbottom2: .word 21,22,23,24,25,26
	xtop1: .word 0,1,2,3,4,5
	xtop2: .word 25,26,27,28,29,30
	livesNumber: 3
	grey: .word 0x808080
	goal1: .word 0
	goal2: .word 0
	deathX: .word 0
	deathY: .word 0
	ifDeath: .word 1
	ifEnd: .word 0
	score: .word 0 # score: 0-2
	hazardsNumber: .word 0 #0-10
	black: .word 0x000000
	direction: .word 0 # o for up, 1 for down, 2 for left, 3 for right

.text
	lw $t0, displayAddress # $t0 stores the base address for display
	li $t1, 0xff0000 # $t1 stores the red colour code
	li $t2, 0x00ff00 # $t2 stores the green colour code
	li $t3, 0x0000ff # $t3 stores the blue colour code
	li $s0, 0x904000 # brown 
	li $s1, 0x008800 # dark green
	li $s2, 0xe28743 # orange
	#sw $t1, 0($t0) # paint the first (top-left) unit red.
	#sw $t2, 4($t0) # paint the second unit on the first row green. Why $t0+4?
	#sw $t3, 128($t0) # paint the first unit on the second row blue. Why +128?
	
############################
#set array ,array2, array3, array4 before run
# set array
addi $t4, $zero, 0
sw $s0,array($t4)
addi $t4, $t4, 4
sw $s0,array($t4)
addi $t4, $t4, 4
sw $s0,array($t4)
addi $t4, $t4, 4
sw $s0,array($t4)
addi $t4, $t4, 4
sw $s0,array($t4)
addi $t4, $t4, 4
sw $s0,array($t4)

addi $t4, $t4, 4 
sw $s2,array($t4) 
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)
addi $t4, $t4, 4 
sw $s2,array($t4)


addi $t4, $t4, 4
sw $s0,array($t4)
addi $t4, $t4, 4
sw $s0,array($t4)
addi $t4, $t4, 4
sw $s0,array($t4)
addi $t4, $t4, 4
sw $s0,array($t4)
addi $t4, $t4, 4
sw $s0,array($t4)
addi $t4, $t4, 4
sw $s0,array($t4)

addi $t4, $t4, 4 
sw $s2,array($t4)

#set array2
addi $t4, $zero,0  
sw $s0,array2($t4) 
addi $t4, $t4, 4
sw $s0,array2($t4)
addi $t4, $t4, 4
sw $s0,array2($t4)
addi $t4, $t4, 4
sw $s0,array2($t4)
addi $t4, $t4, 4
sw $s0,array2($t4)
addi $t4, $t4, 4
sw $s0,array2($t4) 

addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)


addi $t4, $t4, 4 
sw $s0,array2($t4) 
addi $t4, $t4, 4
sw $s0,array2($t4)
addi $t4, $t4, 4
sw $s0,array2($t4)
addi $t4, $t4, 4
sw $s0,array2($t4)
addi $t4, $t4, 4
sw $s0,array2($t4)
addi $t4, $t4, 4
sw $s0,array2($t4)

addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)
addi $t4, $t4, 4
sw $s2,array2($t4)

# set array3
addi $t4, $zero, 0
sw $s1,array3($t4)
addi $t4, $t4, 4
sw $s1,array3($t4)
addi $t4, $t4, 4
sw $s1,array3($t4)
addi $t4, $t4, 4
sw $s1,array3($t4)
addi $t4, $t4, 4
sw $s1,array3($t4)
addi $t4, $t4, 4
sw $s1,array3($t4)

addi $t4, $t4, 4
sw $t3,array3($t4) 
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)
addi $t4, $t4, 4
sw $t3,array3($t4)


addi $t4, $t4, 4
sw $s1,array3($t4)
addi $t4, $t4, 4
sw $s1,array3($t4)
addi $t4, $t4, 4
sw $s1,array3($t4)
addi $t4, $t4, 4
sw $s1,array3($t4)
addi $t4, $t4, 4
sw $s1,array3($t4)
addi $t4, $t4, 4
sw $s1,array3($t4)

addi $t4, $t4, 4
sw $t3,array3($t4)

# set array4
addi $t4, $zero, 0
sw $s1,array4($t4)
addi $t4, $t4, 4
sw $s1,array4($t4)
addi $t4, $t4, 4
sw $s1,array4($t4)
addi $t4, $t4, 4
sw $s1,array4($t4)
addi $t4, $t4, 4
sw $s1,array4($t4)
addi $t4, $t4, 4
sw $s1,array4($t4)

addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)


addi $t4, $t4, 4
sw $s1,array4($t4)
addi $t4, $t4, 4
sw $s1,array4($t4)
addi $t4, $t4, 4
sw $s1,array4($t4)
addi $t4, $t4, 4
sw $s1,array4($t4)
addi $t4, $t4, 4
sw $s1,array4($t4)
addi $t4, $t4, 4
sw $s1,array4($t4)

addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)
addi $t4, $t4, 4
sw $t3,array4($t4)



Step1: 

	# if ifEnd  is 1, exit
	addi $t5, $zero, 1
	lw $t4, ifEnd
	beq $t5, $t4, Restart
	
#Step1: Check for key input
# check if a key is pressed
lw $t8, 0xffff0000
beq $t8, 1, keyboard_input
j checkCollision

# If a key is pressed
keyboard_input:
	lw $t2, 0xffff0004
	beq $t2, 0x61, respond_to_A
	beq $t2, 0x73, respond_to_S
	beq $t2, 0x64, respond_to_D
	beq $t2, 0x77, respond_to_W # move one space
	beq $t2, 0x66, respond_to_F # move four space
	j checkCollision # invalid keystroke
	
respond_to_A:
	addi $t4, $zero, 2
	sw $t4, direction
	
	lw $t4, frogX
	addi $t4, $t4, -1
	beq $t4, -1, GoBackToSafeArea1
	sw $t4, frogX
	
	lw $t4, frogX
	lw $t5, frogY
	addi $t6, $zero, 8 # goal1 x
	addi $t8, $zero, 20 # goal2 x
	addi $t7, $zero, 0 # goal1,2 y
	
	bne $t4, $t6, elseGoal1
	bne $t5, $t7, elseGoal1
	addi $t9, $zero, 1
	sw $t9, goal1
	j GoBackToSafeArea1
	elseGoal1:
	
	bne $t4, $t8, elseGoal2
	bne $t5, $t7, elseGoal2
	addi $t9, $zero, 1
	sw $t9, goal2
	j GoBackToSafeArea1
	elseGoal2:
		
	j checkCollision

respond_to_S:
	addi $t4, $zero, 1
	sw $t4, direction
	
	lw $t4, frogY
	addi $t4, $t4, 1
	beq $t4, 29, GoBackToSafeArea1
	sw $t4, frogY
	
	lw $t4, frogX
	lw $t5, frogY
	addi $t6, $zero, 8 # goal1 x
	addi $t8, $zero, 20 # goal2 x
	addi $t7, $zero, 0 # goal1,2 y
	
	bne $t4, $t6, elseGoal1.1
	bne $t5, $t7, elseGoal1.1
	addi $t9, $zero, 1
	sw $t9, goal1
	j GoBackToSafeArea1
	elseGoal1.1:
	
	bne $t4, $t8, elseGoal2.1
	bne $t5, $t7, elseGoal2.1
	addi $t9, $zero, 1
	sw $t9, goal2
	j GoBackToSafeArea1
	elseGoal2.1:
	
	j checkCollision
	
respond_to_D:
	addi $t4, $zero, 3
	sw $t4, direction
	
	lw $t4, frogX
	addi $t4, $t4, 1
	beq $t4, 29, GoBackToSafeArea1
	sw $t4, frogX
	
	lw $t4, frogX
	lw $t5, frogY
	addi $t6, $zero, 8 # goal1 x
	addi $t8, $zero, 20 # goal2 x
	addi $t7, $zero, 0 # goal1,2 y
	
	bne $t4, $t6, elseGoal1.3
	bne $t5, $t7, elseGoal1.3
	addi $t9, $zero, 1
	sw $t9, goal1
	j GoBackToSafeArea1
	elseGoal1.3:
	
	bne $t4, $t8, elseGoal2.3
	bne $t5, $t7, elseGoal2.3
	addi $t9, $zero, 1
	sw $t9, goal2
	j GoBackToSafeArea1
	elseGoal2.3:
	
	j checkCollision

respond_to_W:
	addi $t4, $zero, 0
	sw $t4, direction
	
	lw $t4, frogY
	addi $t4, $t4, -1
	beq $t4, -1, GoBackToSafeArea1
	sw $t4, frogY

	lw $t4, frogX
	lw $t5, frogY
	addi $t6, $zero, 8 # goal1 x
	addi $t8, $zero, 20 # goal2 x
	addi $t7, $zero, 0 # goal1,2 y
	
	bne $t4, $t6, elseGoal1.4
	bne $t5, $t7, elseGoal1.4
	addi $t9, $zero, 1
	sw $t9, goal1
	j GoBackToSafeArea1
	elseGoal1.4:
	
	bne $t4, $t8, elseGoal2.4
	bne $t5, $t7, elseGoal2.4
	addi $t9, $zero, 1
	sw $t9, goal2
	j GoBackToSafeArea1
	elseGoal2.4:
	
	j checkCollision

respond_to_F:
	addi $t4, $zero, 0
	sw $t4, direction
	
	lw $t4, frogY
	addi $t4, $t4, -4
	addi $t5, $t4,1
	blez $t5, GoBackToSafeArea1
	sw $t4, frogY

	lw $t4, frogX
	lw $t5, frogY
	addi $t6, $zero, 8 # goal1 x
	addi $t8, $zero, 20 # goal2 x
	addi $t7, $zero, 0 # goal1,2 y
	
	bne $t4, $t6, elseGoal1.5
	bne $t5, $t7, elseGoal1.5
	addi $t9, $zero, 1
	sw $t9, goal1
	j GoBackToSafeArea1
	elseGoal1.5:
	
	bne $t4, $t8, elseGoal2.5
	bne $t5, $t7, elseGoal2.5
	addi $t9, $zero, 1
	sw $t9, goal2
	j GoBackToSafeArea1
	elseGoal2.5:
	
	j checkCollision

checkCollision:
	############# for xbottom1
	lw $s6, frogX # s6 stores x of frog
	lw $s7, frogY # s7 stores y of frog
	la $s1, xbottom1
	lw $t4, 0($s1) # t4 stores first x of the rectangle
	lw $t5, 4($s1)
	lw $t6, 8($s1)
	lw $t7, 12($s1)
	lw $t8, 16($s1)
	lw $t9, 20($s1)
	# check collision from top
	addi $s5, $zero, 21
	bne $s7, $s5, checkCollisionBottom  # if frogY is not 21
	beq $s6, $t4, GoBackToSafeArea # if frogY is 24, check x values
	beq $s6, $t5, GoBackToSafeArea
	beq $s6, $t6, GoBackToSafeArea
	beq $s6, $t7, GoBackToSafeArea
	beq $s6, $t8, GoBackToSafeArea
	beq $s6, $t9, GoBackToSafeArea
	addi $s5, $s6, 3 # let s5 be frogX+3
	beq $s5, $t4, GoBackToSafeArea
	beq $s5, $t5, GoBackToSafeArea
	beq $s5, $t6, GoBackToSafeArea
	beq $s5, $t7, GoBackToSafeArea
	beq $s5, $t8, GoBackToSafeArea
	beq $s5, $t9, GoBackToSafeArea
	
	checkCollisionBottom: 
	addi $s5, $zero, 27
	bne $s7, $s5, checkCollisionRight  # if frogY is not 27
	beq $s6, $t4, GoBackToSafeArea # if frogY is 27, check x values
	beq $s6, $t5, GoBackToSafeArea
	beq $s6, $t6, GoBackToSafeArea
	beq $s6, $t7, GoBackToSafeArea
	beq $s6, $t8, GoBackToSafeArea
	beq $s6, $t9, GoBackToSafeArea
	addi $s5, $s6, 3 # let s5 be frogX+3
	beq $s5, $t4, GoBackToSafeArea
	beq $s5, $t5, GoBackToSafeArea
	beq $s5, $t6, GoBackToSafeArea
	beq $s5, $t7, GoBackToSafeArea
	beq $s5, $t8, GoBackToSafeArea
	beq $s5, $t9, GoBackToSafeArea
	
	checkCollisionRight:
	bne $s6, $t9, checkCollisionLeft  # if frogX is not sixth x of the rectangle
	addi $s5, $zero, 21
	beq $s7, $s5, GoBackToSafeArea # if frogY is, check y values
	addi $s5, $zero, 22
	beq $s7, $s5, GoBackToSafeArea				
	addi $s5, $zero, 23
	beq $s7, $s5, GoBackToSafeArea	
	addi $s5, $zero, 24
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 25
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 26
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 27
	beq $s7, $s5, GoBackToSafeArea	
	
	checkCollisionLeft:
	addi $s4, $s6, 3
	bne $s4, $t4, Checkxbottom2   # if frogX+3 is not first x of the rectangle, meaning there is no collision
	addi $s5, $zero, 21
	beq $s7, $s5, GoBackToSafeArea # if frogY is, check y values
	addi $s5, $zero, 22
	beq $s7, $s5, GoBackToSafeArea				
	addi $s5, $zero, 23
	beq $s7, $s5, GoBackToSafeArea	
	addi $s5, $zero, 24
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 25
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 26
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 27
	beq $s7, $s5, GoBackToSafeArea
	
#################################################################	
	#################################################### 
	Checkxbottom2:
	# for xbottom2
	lw $s6, frogX # s6 stores x of frog
	lw $s7, frogY # s7 stores y of frog
	la $s1, xbottom2
	lw $t4, 0($s1) # t4 stores first x of the rectangle
	lw $t5, 4($s1)
	lw $t6, 8($s1)
	lw $t7, 12($s1)
	lw $t8, 16($s1)
	lw $t9, 20($s1)
	# check collision from top
	addi $s5, $zero, 21
	bne $s7, $s5, checkCollisionBottom2  # if frogY is not 21
	beq $s6, $t4, GoBackToSafeArea # if frogY is 24, check x values
	beq $s6, $t5, GoBackToSafeArea
	beq $s6, $t6, GoBackToSafeArea
	beq $s6, $t7, GoBackToSafeArea
	beq $s6, $t8, GoBackToSafeArea
	beq $s6, $t9, GoBackToSafeArea
	addi $s5, $s6, 3 # let s5 be frogX+3
	beq $s5, $t4, GoBackToSafeArea
	beq $s5, $t5, GoBackToSafeArea
	beq $s5, $t6, GoBackToSafeArea
	beq $s5, $t7, GoBackToSafeArea
	beq $s5, $t8, GoBackToSafeArea
	beq $s5, $t9, GoBackToSafeArea
	
	checkCollisionBottom2: 
	addi $s5, $zero, 27
	bne $s7, $s5, checkCollisionRight2  # if frogY is not 27
	beq $s6, $t4, GoBackToSafeArea # if frogY is 27, check x values
	beq $s6, $t5, GoBackToSafeArea
	beq $s6, $t6, GoBackToSafeArea
	beq $s6, $t7, GoBackToSafeArea
	beq $s6, $t8, GoBackToSafeArea
	beq $s6, $t9, GoBackToSafeArea
	addi $s5, $s6, 3 # let s5 be frogX+3
	beq $s5, $t4, GoBackToSafeArea
	beq $s5, $t5, GoBackToSafeArea
	beq $s5, $t6, GoBackToSafeArea
	beq $s5, $t7, GoBackToSafeArea
	beq $s5, $t8, GoBackToSafeArea
	beq $s5, $t9, GoBackToSafeArea
	
	checkCollisionRight2:
	bne $s6, $t9, checkCollisionLeft2  # if frogX is not sixth x of the rectangle
	addi $s5, $zero, 21
	beq $s7, $s5, GoBackToSafeArea # if frogY is, check y values
	addi $s5, $zero, 22
	beq $s7, $s5, GoBackToSafeArea				
	addi $s5, $zero, 23
	beq $s7, $s5, GoBackToSafeArea	
	addi $s5, $zero, 24
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 25
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 26
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 27
	beq $s7, $s5, GoBackToSafeArea	
	
	checkCollisionLeft2:
	addi $s4, $s6, 3
	bne $s4, $t4, Checkxtop1  # if frogX+3 is not first x of the rectangle, meaning there is no collision
	addi $s5, $zero, 21
	beq $s7, $s5, GoBackToSafeArea # if frogY is, check y values
	addi $s5, $zero, 22
	beq $s7, $s5, GoBackToSafeArea				
	addi $s5, $zero, 23
	beq $s7, $s5, GoBackToSafeArea	
	addi $s5, $zero, 24
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 25
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 26
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 27
	beq $s7, $s5, GoBackToSafeArea

#################################################
########## for xtop1
Checkxtop1:
	lw $s6, frogX # s6 stores x of frog
	lw $s7, frogY # s7 stores y of frog
	la $s1, xtop1
	lw $t4, 0($s1) # t4 stores first x of the rectangle
	lw $t5, 4($s1)
	lw $t6, 8($s1)
	lw $t7, 12($s1)
	lw $t8, 16($s1)
	lw $t9, 20($s1)
	# check collision from top
	addi $s5, $zero, 17
	bne $s7, $s5, checkCollisionBottom3  # if frogY is not 21
	beq $s6, $t4, GoBackToSafeArea # if frogY is 24, check x values
	beq $s6, $t5, GoBackToSafeArea
	beq $s6, $t6, GoBackToSafeArea
	beq $s6, $t7, GoBackToSafeArea
	beq $s6, $t8, GoBackToSafeArea
	beq $s6, $t9, GoBackToSafeArea
	addi $s5, $s6, 3 # let s5 be frogX+3
	beq $s5, $t4, GoBackToSafeArea
	beq $s5, $t5, GoBackToSafeArea
	beq $s5, $t6, GoBackToSafeArea
	beq $s5, $t7, GoBackToSafeArea
	beq $s5, $t8, GoBackToSafeArea
	beq $s5, $t9, GoBackToSafeArea
	
	checkCollisionBottom3: 
	addi $s5, $zero, 23
	bne $s7, $s5, checkCollisionRight3  # if frogY is not 27
	beq $s6, $t4, GoBackToSafeArea # if frogY is 27, check x values
	beq $s6, $t5, GoBackToSafeArea
	beq $s6, $t6, GoBackToSafeArea
	beq $s6, $t7, GoBackToSafeArea
	beq $s6, $t8, GoBackToSafeArea
	beq $s6, $t9, GoBackToSafeArea
	addi $s5, $s6, 3 # let s5 be frogX+3
	beq $s5, $t4, GoBackToSafeArea
	beq $s5, $t5, GoBackToSafeArea
	beq $s5, $t6, GoBackToSafeArea
	beq $s5, $t7, GoBackToSafeArea
	beq $s5, $t8, GoBackToSafeArea
	beq $s5, $t9, GoBackToSafeArea
	
	checkCollisionRight3:
	bne $s6, $t9, checkCollisionLeft3  # if frogX is not sixth x of the rectangle
	addi $s5, $zero, 17
	beq $s7, $s5, GoBackToSafeArea # if frogY is, check y values
	addi $s5, $zero, 18
	beq $s7, $s5, GoBackToSafeArea				
	addi $s5, $zero, 19
	beq $s7, $s5, GoBackToSafeArea	
	addi $s5, $zero, 20
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 21
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 22
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 23
	beq $s7, $s5, GoBackToSafeArea	
	
	checkCollisionLeft3:
	addi $s4, $s6, 3
	bne $s4, $t4, Checkxtop2 # if frogX+3 is not first x of the rectangle, meaning there is no collision
	addi $s5, $zero, 17
	beq $s7, $s5, GoBackToSafeArea # if frogY is, check y values
	addi $s5, $zero, 18
	beq $s7, $s5, GoBackToSafeArea				
	addi $s5, $zero, 19
	beq $s7, $s5, GoBackToSafeArea	
	addi $s5, $zero, 20
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 21
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 22
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 23
	beq $s7, $s5, GoBackToSafeArea
	
############################################
############## for xtop2
Checkxtop2:
	lw $s6, frogX # s6 stores x of frog
	lw $s7, frogY # s7 stores y of frog
	la $s1, xtop2
	lw $t4, 0($s1) # t4 stores first x of the rectangle
	lw $t5, 4($s1)
	lw $t6, 8($s1)
	lw $t7, 12($s1)
	lw $t8, 16($s1)
	lw $t9, 20($s1)
	# check collision from top
	addi $s5, $zero, 17
	bne $s7, $s5, checkCollisionBottom4  # if frogY is not 21
	beq $s6, $t4, GoBackToSafeArea # if frogY is 24, check x values
	beq $s6, $t5, GoBackToSafeArea
	beq $s6, $t6, GoBackToSafeArea
	beq $s6, $t7, GoBackToSafeArea
	beq $s6, $t8, GoBackToSafeArea
	beq $s6, $t9, GoBackToSafeArea
	addi $s5, $s6, 3 # let s5 be frogX+3
	beq $s5, $t4, GoBackToSafeArea
	beq $s5, $t5, GoBackToSafeArea
	beq $s5, $t6, GoBackToSafeArea
	beq $s5, $t7, GoBackToSafeArea
	beq $s5, $t8, GoBackToSafeArea
	beq $s5, $t9, GoBackToSafeArea
	
	checkCollisionBottom4: 
	addi $s5, $zero, 23
	bne $s7, $s5, checkCollisionRight4  # if frogY is not 27
	beq $s6, $t4, GoBackToSafeArea # if frogY is 27, check x values
	beq $s6, $t5, GoBackToSafeArea
	beq $s6, $t6, GoBackToSafeArea
	beq $s6, $t7, GoBackToSafeArea
	beq $s6, $t8, GoBackToSafeArea
	beq $s6, $t9, GoBackToSafeArea
	addi $s5, $s6, 3 # let s5 be frogX+3
	beq $s5, $t4, GoBackToSafeArea
	beq $s5, $t5, GoBackToSafeArea
	beq $s5, $t6, GoBackToSafeArea
	beq $s5, $t7, GoBackToSafeArea
	beq $s5, $t8, GoBackToSafeArea
	beq $s5, $t9, GoBackToSafeArea
	
	checkCollisionRight4:
	bne $s6, $t9, checkCollisionLeft4  # if frogX is not sixth x of the rectangle
	addi $s5, $zero, 17
	beq $s7, $s5, GoBackToSafeArea # if frogY is, check y values
	addi $s5, $zero, 18
	beq $s7, $s5, GoBackToSafeArea				
	addi $s5, $zero, 19
	beq $s7, $s5, GoBackToSafeArea	
	addi $s5, $zero, 20
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 21
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 22
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 23
	beq $s7, $s5, GoBackToSafeArea	
	
	checkCollisionLeft4:
	addi $s4, $s6, 3
	bne $s4, $t4, checkxbottom1Water  # if frogX+3 is not first x of the rectangle, meaning there is no collision
	addi $s5, $zero, 17
	beq $s7, $s5, GoBackToSafeArea # if frogY is, check y values
	addi $s5, $zero, 18
	beq $s7, $s5, GoBackToSafeArea				
	addi $s5, $zero, 19
	beq $s7, $s5, GoBackToSafeArea	
	addi $s5, $zero, 20
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 21
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 22
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 23
	beq $s7, $s5, GoBackToSafeArea
	
	
	
	
#####################################################################
	###### check collision for water area
checkxbottom1Water:	
	############# for xbottom1
	lw $s6, frogX # s6 stores x of frog
	lw $s7, frogY # s7 stores y of frog
	la $s1, xbottom1
	lw $t4, 0($s1) # t4 stores first x of the rectangle
	lw $t5, 4($s1)
	lw $t6, 8($s1)
	lw $t7, 12($s1)
	lw $t8, 16($s1)
	lw $t9, 20($s1)
	# check collision from top
	addi $s5, $zero, 9
	bne $s7, $s5, checkCollisionBottom5  # if frogY is not 21
	beq $s6, $t4, GoBackToSafeArea # if frogY is 24, check x values
	beq $s6, $t5, GoBackToSafeArea
	beq $s6, $t6, GoBackToSafeArea
	beq $s6, $t7, GoBackToSafeArea
	beq $s6, $t8, GoBackToSafeArea
	beq $s6, $t9, GoBackToSafeArea
	addi $s5, $s6, 3 # let s5 be frogX+3
	beq $s5, $t4, GoBackToSafeArea
	beq $s5, $t5, GoBackToSafeArea
	beq $s5, $t6, GoBackToSafeArea
	beq $s5, $t7, GoBackToSafeArea
	beq $s5, $t8, GoBackToSafeArea
	beq $s5, $t9, GoBackToSafeArea
	
	checkCollisionBottom5: 
	addi $s5, $zero, 15
	bne $s7, $s5, checkCollisionRight5  # if frogY is not 27
	beq $s6, $t4, GoBackToSafeArea # if frogY is 27, check x values
	beq $s6, $t5, GoBackToSafeArea
	beq $s6, $t6, GoBackToSafeArea
	beq $s6, $t7, GoBackToSafeArea
	beq $s6, $t8, GoBackToSafeArea
	beq $s6, $t9, GoBackToSafeArea
	addi $s5, $s6, 3 # let s5 be frogX+3
	beq $s5, $t4, GoBackToSafeArea
	beq $s5, $t5, GoBackToSafeArea
	beq $s5, $t6, GoBackToSafeArea
	beq $s5, $t7, GoBackToSafeArea
	beq $s5, $t8, GoBackToSafeArea
	beq $s5, $t9, GoBackToSafeArea
	
	checkCollisionRight5:
	bne $s6, $t9, checkCollisionLeft5  # if frogX is not sixth x of the rectangle
	addi $s5, $zero, 9
	beq $s7, $s5, GoBackToSafeArea # if frogY is, check y values
	addi $s5, $zero, 10
	beq $s7, $s5, GoBackToSafeArea				
	addi $s5, $zero, 11
	beq $s7, $s5, GoBackToSafeArea	
	addi $s5, $zero, 12
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 13
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 14
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 15
	beq $s7, $s5, GoBackToSafeArea	
	
	checkCollisionLeft5:
	addi $s4, $s6, 3
	bne $s4, $t4, Checkxbottom2Water   # if frogX+3 is not first x of the rectangle, meaning there is no collision
	addi $s5, $zero, 9
	beq $s7, $s5, GoBackToSafeArea # if frogY is, check y values
	addi $s5, $zero, 10
	beq $s7, $s5, GoBackToSafeArea				
	addi $s5, $zero, 11
	beq $s7, $s5, GoBackToSafeArea	
	addi $s5, $zero, 12
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 13
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 14
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 15
	beq $s7, $s5, GoBackToSafeArea
	
#################################################################	
	#################################################### 
	Checkxbottom2Water:
	# for xbottom2
	lw $s6, frogX # s6 stores x of frog
	lw $s7, frogY # s7 stores y of frog
	la $s1, xbottom2
	lw $t4, 0($s1) # t4 stores first x of the rectangle
	lw $t5, 4($s1)
	lw $t6, 8($s1)
	lw $t7, 12($s1)
	lw $t8, 16($s1)
	lw $t9, 20($s1)
	# check collision from top
	addi $s5, $zero, 9
	bne $s7, $s5, checkCollisionBottom6  # if frogY is not 21
	beq $s6, $t4, GoBackToSafeArea # if frogY is 24, check x values
	beq $s6, $t5, GoBackToSafeArea
	beq $s6, $t6, GoBackToSafeArea
	beq $s6, $t7, GoBackToSafeArea
	beq $s6, $t8, GoBackToSafeArea
	beq $s6, $t9, GoBackToSafeArea
	addi $s5, $s6, 3 # let s5 be frogX+3
	beq $s5, $t4, GoBackToSafeArea
	beq $s5, $t5, GoBackToSafeArea
	beq $s5, $t6, GoBackToSafeArea
	beq $s5, $t7, GoBackToSafeArea
	beq $s5, $t8, GoBackToSafeArea
	beq $s5, $t9, GoBackToSafeArea
	
	checkCollisionBottom6: 
	addi $s5, $zero, 15
	bne $s7, $s5, checkCollisionRight6  # if frogY is not 27
	beq $s6, $t4, GoBackToSafeArea # if frogY is 27, check x values
	beq $s6, $t5, GoBackToSafeArea
	beq $s6, $t6, GoBackToSafeArea
	beq $s6, $t7, GoBackToSafeArea
	beq $s6, $t8, GoBackToSafeArea
	beq $s6, $t9, GoBackToSafeArea
	addi $s5, $s6, 3 # let s5 be frogX+3
	beq $s5, $t4, GoBackToSafeArea
	beq $s5, $t5, GoBackToSafeArea
	beq $s5, $t6, GoBackToSafeArea
	beq $s5, $t7, GoBackToSafeArea
	beq $s5, $t8, GoBackToSafeArea
	beq $s5, $t9, GoBackToSafeArea
	
	checkCollisionRight6:
	bne $s6, $t9, checkCollisionLeft6  # if frogX is not sixth x of the rectangle
	addi $s5, $zero, 9
	beq $s7, $s5, GoBackToSafeArea # if frogY is, check y values
	addi $s5, $zero, 10
	beq $s7, $s5, GoBackToSafeArea				
	addi $s5, $zero, 11
	beq $s7, $s5, GoBackToSafeArea	
	addi $s5, $zero, 12
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 13
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 14
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 15
	beq $s7, $s5, GoBackToSafeArea	
	
	checkCollisionLeft6:
	addi $s4, $s6, 3
	bne $s4, $t4, Checkxtop1Water  # if frogX+3 is not first x of the rectangle, meaning there is no collision
	addi $s5, $zero, 9
	beq $s7, $s5, GoBackToSafeArea # if frogY is, check y values
	addi $s5, $zero, 10
	beq $s7, $s5, GoBackToSafeArea				
	addi $s5, $zero, 11
	beq $s7, $s5, GoBackToSafeArea	
	addi $s5, $zero, 12
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 13
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 14
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 15
	beq $s7, $s5, GoBackToSafeArea

#################################################
########## for xtop1
Checkxtop1Water:
	lw $s6, frogX # s6 stores x of frog
	lw $s7, frogY # s7 stores y of frog
	la $s1, xtop1
	lw $t4, 0($s1) # t4 stores first x of the rectangle
	lw $t5, 4($s1)
	lw $t6, 8($s1)
	lw $t7, 12($s1)
	lw $t8, 16($s1)
	lw $t9, 20($s1)
	# check collision from top
	addi $s5, $zero, 5
	bne $s7, $s5, checkCollisionBottom7  # if frogY is not 21
	beq $s6, $t4, GoBackToSafeArea # if frogY is 24, check x values
	beq $s6, $t5, GoBackToSafeArea
	beq $s6, $t6, GoBackToSafeArea
	beq $s6, $t7, GoBackToSafeArea
	beq $s6, $t8, GoBackToSafeArea
	beq $s6, $t9, GoBackToSafeArea
	addi $s5, $s6, 3 # let s5 be frogX+3
	beq $s5, $t4, GoBackToSafeArea
	beq $s5, $t5, GoBackToSafeArea
	beq $s5, $t6, GoBackToSafeArea
	beq $s5, $t7, GoBackToSafeArea
	beq $s5, $t8, GoBackToSafeArea
	beq $s5, $t9, GoBackToSafeArea
	
	checkCollisionBottom7: 
	addi $s5, $zero, 11
	bne $s7, $s5, checkCollisionRight7  # if frogY is not 27
	beq $s6, $t4, GoBackToSafeArea # if frogY is 27, check x values
	beq $s6, $t5, GoBackToSafeArea
	beq $s6, $t6, GoBackToSafeArea
	beq $s6, $t7, GoBackToSafeArea
	beq $s6, $t8, GoBackToSafeArea
	beq $s6, $t9, GoBackToSafeArea
	addi $s5, $s6, 3 # let s5 be frogX+3
	beq $s5, $t4, GoBackToSafeArea
	beq $s5, $t5, GoBackToSafeArea
	beq $s5, $t6, GoBackToSafeArea
	beq $s5, $t7, GoBackToSafeArea
	beq $s5, $t8, GoBackToSafeArea
	beq $s5, $t9, GoBackToSafeArea
	
	checkCollisionRight7:
	bne $s6, $t9, checkCollisionLeft7  # if frogX is not sixth x of the rectangle
	addi $s5, $zero, 5
	beq $s7, $s5, GoBackToSafeArea # if frogY is, check y values
	addi $s5, $zero, 6
	beq $s7, $s5, GoBackToSafeArea				
	addi $s5, $zero, 7
	beq $s7, $s5, GoBackToSafeArea	
	addi $s5, $zero, 8
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 9
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 10
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 11
	beq $s7, $s5, GoBackToSafeArea	
	
	checkCollisionLeft7:
	addi $s4, $s6, 3
	bne $s4, $t4, Checkxtop2Water # if frogX+3 is not first x of the rectangle, meaning there is no collision
	addi $s5, $zero, 5
	beq $s7, $s5, GoBackToSafeArea # if frogY is, check y values
	addi $s5, $zero, 6
	beq $s7, $s5, GoBackToSafeArea				
	addi $s5, $zero, 7
	beq $s7, $s5, GoBackToSafeArea	
	addi $s5, $zero, 8
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 9
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 10
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 11
	beq $s7, $s5, GoBackToSafeArea
	
############################################
############## for xtop2
Checkxtop2Water:
	lw $s6, frogX # s6 stores x of frog
	lw $s7, frogY # s7 stores y of frog
	la $s1, xtop2
	lw $t4, 0($s1) # t4 stores first x of the rectangle
	lw $t5, 4($s1)
	lw $t6, 8($s1)
	lw $t7, 12($s1)
	lw $t8, 16($s1)
	lw $t9, 20($s1)
	# check collision from top
	addi $s5, $zero, 5
	bne $s7, $s5, checkCollisionBottom8  # if frogY is not 21
	beq $s6, $t4, GoBackToSafeArea # if frogY is 24, check x values
	beq $s6, $t5, GoBackToSafeArea
	beq $s6, $t6, GoBackToSafeArea
	beq $s6, $t7, GoBackToSafeArea
	beq $s6, $t8, GoBackToSafeArea
	beq $s6, $t9, GoBackToSafeArea
	addi $s5, $s6, 3 # let s5 be frogX+3
	beq $s5, $t4, GoBackToSafeArea
	beq $s5, $t5, GoBackToSafeArea
	beq $s5, $t6, GoBackToSafeArea
	beq $s5, $t7, GoBackToSafeArea
	beq $s5, $t8, GoBackToSafeArea
	beq $s5, $t9, GoBackToSafeArea
	
	checkCollisionBottom8: 
	addi $s5, $zero, 11
	bne $s7, $s5, checkCollisionRight8  # if frogY is not 27
	beq $s6, $t4, GoBackToSafeArea # if frogY is 27, check x values
	beq $s6, $t5, GoBackToSafeArea
	beq $s6, $t6, GoBackToSafeArea
	beq $s6, $t7, GoBackToSafeArea
	beq $s6, $t8, GoBackToSafeArea
	beq $s6, $t9, GoBackToSafeArea
	addi $s5, $s6, 3 # let s5 be frogX+3
	beq $s5, $t4, GoBackToSafeArea
	beq $s5, $t5, GoBackToSafeArea
	beq $s5, $t6, GoBackToSafeArea
	beq $s5, $t7, GoBackToSafeArea
	beq $s5, $t8, GoBackToSafeArea
	beq $s5, $t9, GoBackToSafeArea
	
	checkCollisionRight8:
	bne $s6, $t9, checkCollisionLeft8  # if frogX is not sixth x of the rectangle
	addi $s5, $zero, 5
	beq $s7, $s5, GoBackToSafeArea # if frogY is, check y values
	addi $s5, $zero, 6
	beq $s7, $s5, GoBackToSafeArea				
	addi $s5, $zero, 7
	beq $s7, $s5, GoBackToSafeArea	
	addi $s5, $zero, 8
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 9
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 10
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 11
	beq $s7, $s5, GoBackToSafeArea	
	
	checkCollisionLeft8:
	addi $s4, $s6, 3
	bne $s4, $t4, Step2  # if frogX+3 is not first x of the rectangle, meaning there is no collision
	addi $s5, $zero, 5
	beq $s7, $s5, GoBackToSafeArea # if frogY is, check y values
	addi $s5, $zero, 6
	beq $s7, $s5, GoBackToSafeArea				
	addi $s5, $zero, 7
	beq $s7, $s5, GoBackToSafeArea	
	addi $s5, $zero, 8
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 9
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 10
	beq $s7, $s5, GoBackToSafeArea
	addi $s5, $zero, 11
	beq $s7, $s5, GoBackToSafeArea
	j Step2


	
#####################################3								
GoBackToSafeArea1:
	sw $zero, direction
	
	addi $t4, $zero, 14
	sw $t4, frogX
	addi $t5, $zero, 28
	sw $t5, frogY
	j Step2
	
GoBackToSafeArea:
	sw $zero, direction
	
	# record death
	sw $zero, ifDeath
	lw $t5, frogX
	lw $t6, frogY
	sw $t5, deathX
	sw $t6, deathY
	
	# set the frog position to start area
	addi $t4, $zero, 14
	sw $t4, frogX
	addi $t5, $zero, 28
	sw $t5, frogY
	
	# deacrease lives
	lw $t4, livesNumber
	addi $t4, $t4, -1
	sw $t4, livesNumber
	
	# if die 3 times, set ifEnd to 1
	lw $t4, livesNumber
	bne $t4, $zero, elseifEnd
	addi $t5, $zero, 1
	sw $t5, ifEnd
	elseifEnd:
	
	j Step2


Step2:
#Step2: Update the location of the logs, vehicles and other objects

# Update hazards number according to current score 
lw $t4, score 
addi $t5, $zero, 1

bne $t4, $t5, checkScoreEquals0OR2Scenario
li $v0, 42
li $a0, 0
li $a1, 25
syscall
sw $a0, hazardsNumber

j endUpdateHazards

checkScoreEquals0OR2Scenario:
li $v0, 42
li $a0, 0
li $a1, 200
syscall
sw $a0, hazardsNumber

endUpdateHazards:

# If meats hazards
lw $t4, frogX
lw $t5, frogY
lw $t6, hazardsNumber

# scenario 1
addi, $t9, $zero, 9 # check x
bne $t4, $t9, endIFhazards1.1
addi, $t9, $zero, 4 #checky
bne $t5, $t9, endIFhazards1.1
addi, $t9, $zero, 1 #check hazardsNumber
bne $t6, $t9, endIFhazards1.1
lw $t9, livesNumber
addi $t9, $t9, -1
sw $t9, livesNumber
	# record death
	sw $zero, ifDeath
	lw $t5, frogX
	lw $t6, frogY
	sw $t5, deathX
	sw $t6, deathY
	
	# set the frog position to start area
	addi $t4, $zero, 14
	sw $t4, frogX
	addi $t5, $zero, 28
	sw $t5, frogY
endIFhazards1.1:

	# if die 3 times, set ifEnd to 1
	lw $t9, livesNumber
	bne $t9, $zero, elseifEnd2.1
	addi $t9, $zero, 1
	sw $t9, ifEnd
	elseifEnd2.1:

addi, $t9, $zero, 8 # check x
bne $t4, $t9, endIFhazards1.2
addi, $t9, $zero, 4 #checky
bne $t5, $t9, endIFhazards1.2
addi, $t9, $zero, 1 #check hazardsNumber
bne $t6, $t9, endIFhazards1.2
lw $t9, livesNumber
addi $t9, $t9, -1
sw $t9, livesNumber
	# record death
	sw $zero, ifDeath
	lw $t5, frogX
	lw $t6, frogY
	sw $t5, deathX
	sw $t6, deathY
	
	# set the frog position to start area
	addi $t4, $zero, 14
	sw $t4, frogX
	addi $t5, $zero, 28
	sw $t5, frogY
endIFhazards1.2:
	
	# if die 3 times, set ifEnd to 1
	lw $t9, livesNumber
	bne $t9, $zero, elseifEnd2.2
	addi $t9, $zero, 1
	sw $t9, ifEnd
	elseifEnd2.2:
	
addi, $t9, $zero, 7 # check x
bne $t4, $t9, endIFhazards1.3
addi, $t9, $zero, 4 #checky
bne $t5, $t9, endIFhazards1.3
addi, $t9, $zero, 1 #check hazardsNumber
bne $t6, $t9, endIFhazards1.3
lw $t9, livesNumber
addi $t9, $t9, -1
sw $t9, livesNumber
	# record death
	sw $zero, ifDeath
	lw $t5, frogX
	lw $t6, frogY
	sw $t5, deathX
	sw $t6, deathY
	
	# set the frog position to start area
	addi $t4, $zero, 14
	sw $t4, frogX
	addi $t5, $zero, 28
	sw $t5, frogY
endIFhazards1.3:
	
	# if die 3 times, set ifEnd to 1
	lw $t9, livesNumber
	bne $t9, $zero, elseifEnd2.3
	addi $t9, $zero, 1
	sw $t9, ifEnd
	elseifEnd2.3:
	
	
addi, $t9, $zero, 6 # check x
bne $t4, $t9, endIFhazards1.4
addi, $t9, $zero, 4 #checky
bne $t5, $t9, endIFhazards1.4
addi, $t9, $zero, 1 #check hazardsNumber
bne $t6, $t9, endIFhazards1.4
lw $t9, livesNumber
addi $t9, $t9, -1
sw $t9, livesNumber

	# record death
	sw $zero, ifDeath
	lw $t5, frogX
	lw $t6, frogY
	sw $t5, deathX
	sw $t6, deathY
	
	# set the frog position to start area
	addi $t4, $zero, 14
	sw $t4, frogX
	addi $t5, $zero, 28
	sw $t5, frogY
	
endIFhazards1.4:
	
	# if die 3 times, set ifEnd to 1
	lw $t9, livesNumber
	bne $t9, $zero, elseifEnd2.4
	addi $t9, $zero, 1
	sw $t9, ifEnd
	elseifEnd2.4:


	
# scenario 2
addi, $t9, $zero, 22
bne $t4, $t9, endIFhazards3
addi, $t9, $zero, 4
bne $t5, $t9, endIFhazards3
addi, $t9, $zero, 1
bne $t6, $t9, endIFhazards3
lw $t9, livesNumber
addi $t9, $t9, -1
sw $t9, livesNumber
	# record death
	sw $zero, ifDeath
	lw $t5, frogX
	lw $t6, frogY
	sw $t5, deathX
	sw $t6, deathY
	
	# set the frog position to start area
	addi $t4, $zero, 14
	sw $t4, frogX
	addi $t5, $zero, 28
	sw $t5, frogY
endIFhazards3:
	# if die 3 times, set ifEnd to 1
	lw $t9, livesNumber
	bne $t9, $zero, elseifEnd4
	addi $t9, $zero, 1
	sw $t9, ifEnd
	elseifEnd4:

# scenario 3
addi, $t9, $zero, 25
bne $t4, $t9, endIFhazards4
addi, $t9, $zero, 4
bne $t5, $t9, endIFhazards4
addi, $t9, $zero, 1
bne $t6, $t9, endIFhazards4
lw $t9, livesNumber
addi $t9, $t9, -1
sw $t9, livesNumber
	# record death
	sw $zero, ifDeath
	lw $t5, frogX
	lw $t6, frogY
	sw $t5, deathX
	sw $t6, deathY
	
	# set the frog position to start area
	addi $t4, $zero, 14
	sw $t4, frogX
	addi $t5, $zero, 28
	sw $t5, frogY
endIFhazards4:
	# if die 3 times, set ifEnd to 1
	lw $t9, livesNumber
	bne $t9, $zero, elseifEnd5
	addi $t9, $zero, 1
	sw $t9, ifEnd
	elseifEnd5:

addi, $t9, $zero, 23
bne $t4, $t9, endIFhazards4.1
addi, $t9, $zero, 4
bne $t5, $t9, endIFhazards4.1
addi, $t9, $zero, 1
bne $t6, $t9, endIFhazards4.1
lw $t9, livesNumber
addi $t9, $t9, -1
sw $t9, livesNumber
	# record death
	sw $zero, ifDeath
	lw $t5, frogX
	lw $t6, frogY
	sw $t5, deathX
	sw $t6, deathY
	
	# set the frog position to start area
	addi $t4, $zero, 14
	sw $t4, frogX
	addi $t5, $zero, 28
	sw $t5, frogY
endIFhazards4.1:
	# if die 3 times, set ifEnd to 1
	lw $t9, livesNumber
	bne $t9, $zero, elseifEnd5.1
	addi $t9, $zero, 1
	sw $t9, ifEnd
	elseifEnd5.1:

addi, $t9, $zero, 24
bne $t4, $t9, endIFhazards4.2
addi, $t9, $zero, 4
bne $t5, $t9, endIFhazards4.2
addi, $t9, $zero, 1
bne $t6, $t9, endIFhazards4.2
lw $t9, livesNumber
addi $t9, $t9, -1
sw $t9, livesNumber
	# record death
	sw $zero, ifDeath
	lw $t5, frogX
	lw $t6, frogY
	sw $t5, deathX
	sw $t6, deathY
	
	# set the frog position to start area
	addi $t4, $zero, 14
	sw $t4, frogX
	addi $t5, $zero, 28
	sw $t5, frogY
endIFhazards4.2:
	# if die 3 times, set ifEnd to 1
	lw $t9, livesNumber
	bne $t9, $zero, elseifEnd5.2
	addi $t9, $zero, 1
	sw $t9, ifEnd
	elseifEnd5.2:




# Update lives according to life powerups
lw $t4, frogX
lw $t5, frogY

bne $t4, 7, endPowerup1
bne $t5, 16, endPowerup1
addi $t7, $zero, 3
sw $t7, livesNumber
endPowerup1:

bne $t4, 21, endPowerup2
bne $t5, 16, endPowerup2
addi $t7, $zero, 3
sw $t7, livesNumber
endPowerup2:


# Update score
lw $t4, goal1
lw $t5, goal2
addi $t6, $zero, 1
addi $t7, $zero, 2
# goal1 != 0 and goal2 = 0
beq $t4, $zero, elseScore1
bne $t5, $zero, elseScore1
sw $t6, score
elseScore1:

# goal1 = 0 and goal2 != 0
bne $t4, $zero, elseScore2
beq $t5, $zero, elseScore2
sw $t6, score
elseScore2:

# goal1 != 0 and goal2 != 0
beq $t4, $zero, elseScore3
beq $t5, $zero, elseScore3
sw $t7, score
elseScore3:



##### Upadate 4 arrays 

#Update array, shift right
UpadateArray: addi $t4, $zero, 124 #loop index
		lw $t5, array($t4) #fetch the last unit to t5
		addi $t6, $zero, 0 # end loop index
StartArray: beq $t4, $6, EndArray #while t4 > t6
		addi $t7, $t4, -4 # store index -4
		lw $t8, array($t7) # fetch unit from index - 4
		sw $t8, array($t4) # store unit with index-4 to unit with index 
		addi $t4, $t4, -4 # update index
		j StartArray
EndArray: sw $t5, array($t4)

#######################################################################
#also update xtop1
la $s3, xtop1 # s3 be the address of the array

lw $t5,0($s3) # let t5 be first element of the array
addi $t9, $zero, 31 # let t9 store 31
bne $t5, $t9, elsePositionCheck1xtop1 # if t5 is not equal to 31
addi $t5, $zero, 0 # if t5 stores 31, change it to store 0
sw $t5, 0($s3) # store t5 to the array
j endPositionCheck1xtop1
elsePositionCheck1xtop1: addi $t5,$t5, 1 # if t5 does not store 31, t5 = t5+1
		sw $t5, 0($s3)
endPositionCheck1xtop1:

lw $t5,4($s3) # let t5 be first element of the array
addi $t9, $zero, 31
bne $t5, $t9, elsePositionCheck2xtop1
addi $t5, $zero, 0 # if t5 stores 0, change it to store 31
sw $t5, 4($s3) # store t5 to the array
j endPositionCheck2xtop1
elsePositionCheck2xtop1: addi $t5,$t5, 1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 4($s3)
endPositionCheck2xtop1:

lw $t5,8($s3) # let t5 be first element of the array
addi $t9, $zero, 31
bne $t5, $t9, elsePositionCheck3xtop1
addi $t5, $zero, 0 # if t5 stores 0, change it to store 31
sw $t5, 8($s3) # store t5 to the array
j endPositionCheck3xtop1
elsePositionCheck3xtop1: addi $t5,$t5, 1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 8($s3)
endPositionCheck3xtop1:

lw $t5,12($s3) # let t5 be first element of the array
addi $t9, $zero, 31
bne $t5, $t9, elsePositionCheck4xtop1
addi $t5, $zero, 0 # if t5 stores 0, change it to store 31
sw $t5, 12($s3) # store t5 to the array
j endPositionCheck4xtop1
elsePositionCheck4xtop1: addi $t5,$t5, 1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 12($s3)
endPositionCheck4xtop1:

lw $t5,16($s3) # let t5 be first element of the array
addi $t9, $zero, 31
bne $t5, $t9, elsePositionCheck5xtop1
addi $t5, $zero, 0 # if t5 stores 0, change it to store 31
sw $t5, 16($s3) # store t5 to the array
j endPositionCheck5xtop1
elsePositionCheck5xtop1: addi $t5,$t5, 1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 16($s3)
endPositionCheck5xtop1:

lw $t5,20($s3) # let t5 be first element of the array
addi $t9, $zero, 31
bne $t5, $t9, elsePositionCheck6xtop1
addi $t5, $zero, 0 # if t5 stores 0, change it to store 31
sw $t5, 20($s3) # store t5 to the array
j endPositionCheck6xtop1
elsePositionCheck6xtop1: addi $t5,$t5, 1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 20($s3)
endPositionCheck6xtop1:

###########################################################################
#also update xtop2
la $s3, xtop2 # s3 be the address of the array

lw $t5,0($s3) # let t5 be first element of the array
addi $t9, $zero, 31
bne $t5, $t9, elsePositionCheck1xtop2
addi $t5, $zero, 0 # if t5 stores 0, change it to store 31
sw $t5, 0($s3) # store t5 to the array
j endPositionCheck1xtop2
elsePositionCheck1xtop2: addi $t5,$t5, 1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 0($s3)
endPositionCheck1xtop2:

lw $t5,4($s3) # let t5 be first element of the array
addi $t9, $zero, 31
bne $t5, $t9, elsePositionCheck2xtop2
addi $t5, $zero, 0 # if t5 stores 0, change it to store 31
sw $t5, 4($s3) # store t5 to the array
j endPositionCheck2xtop2
elsePositionCheck2xtop2: addi $t5,$t5, 1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 4($s3)
endPositionCheck2xtop2:

lw $t5,8($s3) # let t5 be first element of the array
addi $t9, $zero, 31
bne $t5, $t9, elsePositionCheck3xtop2
addi $t5, $zero, 0 # if t5 stores 0, change it to store 31
sw $t5, 8($s3) # store t5 to the array
j endPositionCheck3xtop2
elsePositionCheck3xtop2: addi $t5,$t5, 1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 8($s3)
endPositionCheck3xtop2:

lw $t5,12($s3) # let t5 be first element of the array
addi $t9, $zero, 31
bne $t5, $t9, elsePositionCheck4xtop2
addi $t5, $zero, 0 # if t5 stores 0, change it to store 31
sw $t5, 12($s3) # store t5 to the array
j endPositionCheck4xtop2
elsePositionCheck4xtop2: addi $t5,$t5, 1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 12($s3)
endPositionCheck4xtop2:

lw $t5,16($s3) # let t5 be first element of the array
addi $t9, $zero, 31
bne $t5, $t9, elsePositionCheck5xtop2
addi $t5, $zero, 0 # if t5 stores 0, change it to store 31
sw $t5, 16($s3) # store t5 to the array
j endPositionCheck5xtop2
elsePositionCheck5xtop2: addi $t5,$t5, 1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 16($s3)
endPositionCheck5xtop2:

lw $t5,20($s3) # let t5 be first element of the array
addi $t9, $zero, 31
bne $t5, $t9, elsePositionCheck6xtop2
addi $t5, $zero, 0 # if t5 stores 0, change it to store 31
sw $t5, 20($s3) # store t5 to the array
j endPositionCheck6xtop2
elsePositionCheck6xtop2: addi $t5,$t5, 1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 20($s3)
endPositionCheck6xtop2:





#update array2, shift left		
UpadateArray2: addi $t4, $zero, 0 #loop index
		lw $t5, array2($zero) #fetch the fist unit to t5
		addi $t6, $zero, 124 # end loop index
StartArray2: beq $t4, $t6, EndArray2 #while t4 > t6
		addi $t7, $t4, 4 # store index+4
		lw $t8, array2($t7) # fetch unit from index+4 
		sw $t8, array2($t4) # store unit with index+4 to unit with index
		addi $t4, $t4, 4 # update index
		j StartArray2
EndArray2: sw $t5, array2($t4)

#######################################################################
#also update xbottom1
la $s3, xbottom1 # s3 be the address of the array
lw $t5,0($s3) # let t5 be first element of the array
bne $t5, $zero, elsePositionCheck1
addi $t5, $zero, 31 # if t5 stores 0, change it to store 31
sw $t5, 0($s3) # store t5 to the array
j endPositionCheck1
elsePositionCheck1: addi $t5,$t5, -1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 0($s3)
endPositionCheck1:

lw $t5,4($s3) # let t5 be first element of the array
bne $t5, $zero, elsePositionCheck2
addi $t5, $zero, 31 # if t5 stores 0, change it to store 31
sw $t5, 4($s3) # store t5 to the array
j endPositionCheck2
elsePositionCheck2: addi $t5,$t5, -1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 4($s3)
endPositionCheck2:

lw $t5,8($s3) # let t5 be first element of the array
bne $t5, $zero, elsePositionCheck3
addi $t5, $zero, 31 # if t5 stores 0, change it to store 31
sw $t5, 8($s3) # store t5 to the array
j endPositionCheck3
elsePositionCheck3: addi $t5,$t5, -1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 8($s3)
endPositionCheck3:

lw $t5,12($s3) # let t5 be first element of the array
bne $t5, $zero, elsePositionCheck4
addi $t5, $zero, 31 # if t5 stores 0, change it to store 31
sw $t5, 12($s3) # store t5 to the array
j endPositionCheck4
elsePositionCheck4: addi $t5,$t5, -1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 12($s3)
endPositionCheck4:

###########################################################################
#also update xbottom2
la $s3, xbottom2 # s3 be the address of the array
lw $t5,0($s3) # let t5 be first element of the array
bne $t5, $zero, elsePositionCheck1xbottom2
addi $t5, $zero, 31 # if t5 stores 0, change it to store 31
sw $t5, 0($s3) # store t5 to the array
j endPositionCheck1xbottom2
elsePositionCheck1xbottom2: addi $t5,$t5, -1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 0($s3)
endPositionCheck1xbottom2:

lw $t5,4($s3) # let t5 be first element of the array
bne $t5, $zero, elsePositionCheck2xbottom2
addi $t5, $zero, 31 # if t5 stores 0, change it to store 31
sw $t5, 4($s3) # store t5 to the array
j endPositionCheck2xbottom2
elsePositionCheck2xbottom2: addi $t5,$t5, -1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 4($s3)
endPositionCheck2xbottom2:

lw $t5,8($s3) # let t5 be first element of the array
bne $t5, $zero, elsePositionCheck3xbottom2
addi $t5, $zero, 31 # if t5 stores 0, change it to store 31
sw $t5, 8($s3) # store t5 to the array
j endPositionCheck3xbottom2
elsePositionCheck3xbottom2: addi $t5,$t5, -1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 8($s3)
endPositionCheck3xbottom2:

lw $t5,12($s3) # let t5 be first element of the array
bne $t5, $zero, elsePositionCheck4xbottom2
addi $t5, $zero, 31 # if t5 stores 0, change it to store 31
sw $t5, 12($s3) # store t5 to the array
j endPositionCheck4xbottom2
elsePositionCheck4xbottom2: addi $t5,$t5, -1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 12($s3)
endPositionCheck4xbottom2:

lw $t5,16($s3) # let t5 be first element of the array
bne $t5, $zero, elsePositionCheck5xbottom2
addi $t5, $zero, 31 # if t5 stores 0, change it to store 31
sw $t5, 16($s3) # store t5 to the array
j endPositionCheck5xbottom2
elsePositionCheck5xbottom2: addi $t5,$t5, -1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 16($s3)
endPositionCheck5xbottom2:

lw $t5,20($s3) # let t5 be first element of the array
bne $t5, $zero, elsePositionCheck6xbottom2
addi $t5, $zero, 31 # if t5 stores 0, change it to store 31
sw $t5, 20($s3) # store t5 to the array
j endPositionCheck6xbottom2
elsePositionCheck6xbottom2: addi $t5,$t5, -1 # if t5 does not store 0, t5 = t5-1
		sw $t5, 20($s3)
endPositionCheck6xbottom2:



#Update array3, shift right
UpadateArray3: addi $t4, $zero, 124 #loop index
		lw $t5, array3($t4) #fetch the last unit to t5
		addi $t6, $zero, 0 # end loop index
StartArray3: beq $t4, $6, EndArray3 #while t4 > t6
		addi $t7, $t4, -4 # store index -4
		lw $t8, array3($t7) # fetch unit from index - 4
		sw $t8, array3($t4) # store unit with index-4 to unit with index 
		addi $t4, $t4, -4 # update index
		j StartArray3
EndArray3: sw $t5, array3($t4)

#update array4, shift left		
UpadateArray4: addi $t4, $zero, 0 #loop index
		lw $t5, array4($zero) #fetch the fist unit to t5
		addi $t6, $zero, 124 # end loop index
StartArray4: beq $t4, $t6, EndArray4 #while t4 > t6
		addi $t7, $t4, 4 # store index+4
		lw $t8, array4($t7) # fetch unit from index+4 
		sw $t8, array4($t4) # store unit with index+4 to unit with index
		addi $t4, $t4, 4 # update index
		j StartArray4
EndArray4: sw $t5, array4($t4)

j Step3

Step3:
#Step3: Redraw the screen
#Draw goal region
mainDrawGoal: add $t4, $t0, $zero # set $t4 to displayAddress
		addi $t5, $t0, 1024 # set $t5 to 1024($t0)
		lw $t9, backgroundColour
STARTDrawGoal: beq $t4, $t5, ENDDrawGoal # while $t4 < $t5
		sw $t9, 0($t4) 	#draw a unit
		addi $t4, $t4, 4 #update $t4
		j STARTDrawGoal
ENDDrawGoal:

#Draw safe region
mainDrawSafe: add $t4, $t0, 2048 # set $t4 to 2048($t0)
		addi $t5, $t0, 2560 # set $t5 to 2560($t0)
		lw $t9, backgroundColour 
STARTDrawSafe: beq $t4, $t5, ENDDrawSafe # while $t4 < $t5
		sw $t9, 0($t4) 	#draw a unit 
		addi $t4, $t4, 4 #update $t4
		j STARTDrawSafe
ENDDrawSafe:

#Draw start region
mainDrawStart: add $t4, $t0, 3584 # set $t4 to 3584($t0)
		addi $t5, $t0, 4096 # set $t5 to 4096($t0)
		lw $t9, backgroundColour
STARTDrawStart: beq $t4, $t5, ENDDrawStart # while $t4 < $t5
		sw $t9, 0($t4) 	#draw a unit 
		addi $t4, $t4, 4 #update $t4
		j STARTDrawStart
ENDDrawStart:



############################
#Draw first road row

DrawFirstVehiclerow1: addi $t5, $t0, 2560 # set $t4 to 2048($t0)
		addi $t6, $t0, 2688 # set $t5 to 2560($t0)
		add $t7, $zero, $zero #specify index in array
STARTDrawFirstVehiclerow1: beq $t5, $t6, ENDDrawFirstVehiclerow1 # while $t4 < $t5
		lw $t9, array($t7)
		sw $t9, 0($t5) 	#draw a unit 
		addi $t5, $t5, 4 #update $t4
		addi $t7, $t7, 4
		j STARTDrawFirstVehiclerow1
ENDDrawFirstVehiclerow1:

DrawFirstVehiclerow2: addi $t5, $t0, 2688 # set $t4 to 2048($t0)
		addi $t6, $t0, 2816 # set $t5 to 2560($t0)
		add $t7, $zero, $zero #specify index in array
STARTDrawFirstVehiclerow2: beq $t5, $t6, ENDDrawFirstVehiclerow2 # while $t4 < $t5
		lw $t9, array($t7)
		sw $t9, 0($t5) 	#draw a unit 
		addi $t5, $t5, 4 #update $t4
		addi $t7, $t7, 4
		j STARTDrawFirstVehiclerow2
ENDDrawFirstVehiclerow2:

DrawFirstVehiclerow3: addi $t5, $t0, 2816 # set $t4 to 2048($t0)
		addi $t6, $t0, 2944 # set $t5 to 2560($t0)
		add $t7, $zero, $zero #specify index in array
STARTDrawFirstVehiclerow3: beq $t5, $t6, ENDDrawFirstVehiclerow3 # while $t4 < $t5
		lw $t9, array($t7)
		sw $t9, 0($t5) 	#draw a unit 
		addi $t5, $t5, 4 #update $t4
		addi $t7, $t7, 4
		j STARTDrawFirstVehiclerow3
ENDDrawFirstVehiclerow3:


DrawFirstVehiclerow4: addi $t5, $t0, 2944 # set $t4 to 2048($t0)
		addi $t6, $t0, 3072 # set $t5 to 2560($t0)
		add $t7, $zero, $zero #specify index in array
STARTDrawFirstVehiclerow4: beq $t5, $t6, ENDDrawFirstVehiclerow4 # while $t4 < $t5
		lw $t9, array($t7)
		sw $t9, 0($t5) 	#draw a unit 
		addi $t5, $t5, 4 #update $t4
		addi $t7, $t7, 4
		j STARTDrawFirstVehiclerow4
ENDDrawFirstVehiclerow4:



#Draw second vehicle row
#Set array2
################# 1

DrawSecondVehiclerow1: addi $t5, $t0, 3072 # set $t4 to 2048($t0)
		addi $t6, $t0, 3200 # set $t5 to 2560($t0)
		add $t7, $zero, $zero #specify index in array
STARTDrawSecondVehiclerow1: beq $t5, $t6, ENDDrawSecondVehiclerow1 # while $t4 < $t5
		lw $t9, array2($t7)
		sw $t9, 0($t5) 	#draw a unit 
		addi $t5, $t5, 4 #update $t4
		addi $t7, $t7, 4
		j STARTDrawSecondVehiclerow1
ENDDrawSecondVehiclerow1:

DrawSecondVehiclerow2: addi $t5, $t0, 3200 # set $t4 to 2048($t0)
		addi $t6, $t0, 3328 # set $t5 to 2560($t0)
		add $t7, $zero, $zero #specify index in array
STARTDrawSecondVehiclerow2: beq $t5, $t6, ENDDrawSecondVehiclerow2 # while $t4 < $t5
		lw $t9, array2($t7)
		sw $t9, 0($t5) 	#draw a unit 
		addi $t5, $t5, 4 #update $t4
		addi $t7, $t7, 4
		j STARTDrawSecondVehiclerow2
ENDDrawSecondVehiclerow2:

DrawSecondVehiclerow3: addi $t5, $t0, 3328 # set $t4 to 2048($t0)
		addi $t6, $t0, 3456 # set $t5 to 2560($t0)
		add $t7, $zero, $zero #specify index in array
STARTDrawSecondVehiclerow3: beq $t5, $t6, ENDDrawSecondVehiclerow3 # while $t4 < $t5
		lw $t9, array2($t7)
		sw $t9, 0($t5) 	#draw a unit 
		addi $t5, $t5, 4 #update $t4
		addi $t7, $t7, 4
		j STARTDrawSecondVehiclerow3
ENDDrawSecondVehiclerow3:

DrawSecondVehiclerow4: addi $t5, $t0, 3456 # set $t4 to 2048($t0)
		addi $t6, $t0, 3584 # set $t5 to 2560($t0)
		add $t7, $zero, $zero #specify index in array
STARTDrawSecondVehiclerow4: beq $t5, $t6, ENDDrawSecondVehiclerow4 # while $t4 < $t5
		lw $t9, array2($t7)
		sw $t9, 0($t5) 	#draw a unit 
		addi $t5, $t5, 4 #update $t4
		addi $t7, $t7, 4
		j STARTDrawSecondVehiclerow4
ENDDrawSecondVehiclerow4:


############################

#Draw first water row
DrawFirstWaterRow1: addi $t5, $t0, 1024 # set $t4 to 2048($t0)
		addi $t6, $t0, 1152 # set $t5 to 2560($t0)
		add $t7, $zero, $zero #specify index in array
STARTFDrawFirstWaterRow1: beq $t5, $t6, ENDDrawFirstWaterRow1 # while $t4 < $t5
		lw $t9, array3($t7)
		sw $t9, 0($t5) 	#draw a unit 
		addi $t5, $t5, 4 #update $t4
		addi $t7, $t7, 4
		j STARTFDrawFirstWaterRow1
ENDDrawFirstWaterRow1:

DrawFirstWaterRow2: addi $t5, $t0, 1152 # set $t4 to 2048($t0)
		addi $t6, $t0, 1280 # set $t5 to 2560($t0)
		add $t7, $zero, $zero #specify index in array
STARTFDrawFirstWaterRow2: beq $t5, $t6, ENDDrawFirstWaterRow2 # while $t4 < $t5
		lw $t9, array3($t7)
		sw $t9, 0($t5) 	#draw a unit 
		addi $t5, $t5, 4 #update $t4
		addi $t7, $t7, 4
		j STARTFDrawFirstWaterRow2
ENDDrawFirstWaterRow2:

DrawFirstWaterRow3: addi $t5, $t0, 1280 # set $t4 to 2048($t0)
		addi $t6, $t0, 1408 # set $t5 to 2560($t0)
		add $t7, $zero, $zero #specify index in array
STARTFDrawFirstWaterRow3: beq $t5, $t6, ENDDrawFirstWaterRow3 # while $t4 < $t5
		lw $t9, array3($t7)
		sw $t9, 0($t5) 	#draw a unit 
		addi $t5, $t5, 4 #update $t4
		addi $t7, $t7, 4
		j STARTFDrawFirstWaterRow3
ENDDrawFirstWaterRow3:

DrawFirstWaterRow4: addi $t5, $t0, 1408 # set $t4 to 2048($t0)
		addi $t6, $t0, 1536 # set $t5 to 2560($t0)
		add $t7, $zero, $zero #specify index in array
STARTFDrawFirstWaterRow4: beq $t5, $t6, ENDDrawFirstWaterRow4 # while $t4 < $t5
		lw $t9, array3($t7)
		sw $t9, 0($t5) 	#draw a unit 
		addi $t5, $t5, 4 #update $t4
		addi $t7, $t7, 4
		j STARTFDrawFirstWaterRow4
ENDDrawFirstWaterRow4:


#Draw second water row
DrawSecondWaterRow1: addi $t5, $t0, 1536 # set $t4 to 2048($t0)
		addi $t6, $t0, 1664 # set $t5 to 2560($t0)
		add $t7, $zero, $zero #specify index in array
STARTSecondWaterRow1: beq $t5, $t6, ENDSecondWaterRow1 # while $t4 < $t5
		lw $t9, array4($t7)
		sw $t9, 0($t5) 	#draw a unit 
		addi $t5, $t5, 4 #update $t4
		addi $t7, $t7, 4
		j STARTSecondWaterRow1
ENDSecondWaterRow1:

DrawSecondWaterRow2: addi $t5, $t0, 1664 # set $t4 to 2048($t0)
		addi $t6, $t0, 1792 # set $t5 to 2560($t0)
		add $t7, $zero, $zero #specify index in array
STARTSecondWaterRow2: beq $t5, $t6, ENDSecondWaterRow2 # while $t4 < $t5
		lw $t9, array4($t7)
		sw $t9, 0($t5) 	#draw a unit 
		addi $t5, $t5, 4 #update $t4
		addi $t7, $t7, 4
		j STARTSecondWaterRow2
ENDSecondWaterRow2:

DrawSecondWaterRow3: addi $t5, $t0, 1792 # set $t4 to 2048($t0)
		addi $t6, $t0, 1920 # set $t5 to 2560($t0)
		add $t7, $zero, $zero #specify index in array
STARTSecondWaterRow3: beq $t5, $t6, ENDSecondWaterRow3 # while $t4 < $t5
		lw $t9, array4($t7)
		sw $t9, 0($t5) 	#draw a unit 
		addi $t5, $t5, 4 #update $t4
		addi $t7, $t7, 4
		j STARTSecondWaterRow3
ENDSecondWaterRow3:

DrawSecondWaterRow4: addi $t5, $t0, 1920 # set $t4 to 2048($t0)
		addi $t6, $t0, 2048 # set $t5 to 2560($t0)
		add $t7, $zero, $zero #specify index in array
STARTSecondWaterRow4: beq $t5, $t6, ENDSecondWaterRow4 # while $t4 < $t5
		lw $t9, array4($t7)
		sw $t9, 0($t5) 	#draw a unit 
		addi $t5, $t5, 4 #update $t4
		addi $t7, $t7, 4
		j STARTSecondWaterRow4
ENDSecondWaterRow4:

#Draw frog

lw $t9, ifDeath
# if the frog is not dead
beq, $t9, $zero, drawDeadFrog

# record direction
lw $t6, direction
bne $t6, $zero, endUp # t6=0
lw $t4, frogX
lw $t5, frogY
#Calculate the topleft of frog's memory, which is 128Y+4X
 #calculate 128Y
 main128Y: add $t7, $zero, $zero  #want $t7 to store 128 Y
 	add $t8, $zero, 128 #loop 128 times
 	add $t9, $zero, $zero # loop accumulator
 start128Y: beq $t9, $t8, end128Y #while $t9< $8
 	add $t7, $t7, $t5
 	addi $t9, $t9, 1
 	j start128Y
 end128Y:
 #calculate 4X
add $t6, $zero, $t4 # want $t6 to store 4X
add $t6, $t6, $t4
add $t6, $t6, $t4
add $t6, $t6, $t4
 #calculate 128Y+4X
add $t6, $t6, $t7 #t6 stores 128Y+4X
add $t6, $t0, $t6 #t6 stores topleft of frog's address
sw $t1, 0($t6)
sw $t1, 12($t6)

sw $t1, 132($t6)
sw $t1, 136($t6)

sw $t1, 260($t6)
sw $t1, 264($t6)


sw $t1, 384($t6)
sw $t1, 388($t6)
sw $t1, 392($t6)
sw $t1, 396($t6)
endUp:

# record direction
lw $t6, direction
addi $t4, $zero, 1
bne $t6, $t4, endDown # t6=1
lw $t4, frogX
lw $t5, frogY
#Calculate the topleft of frog's memory, which is 128Y+4X
 #calculate 128Y
 main128Y.1: add $t7, $zero, $zero  #want $t7 to store 128 Y
 	add $t8, $zero, 128 #loop 128 times
 	add $t9, $zero, $zero # loop accumulator
 start128Y.1: beq $t9, $t8, end128Y.1 #while $t9< $8
 	add $t7, $t7, $t5
 	addi $t9, $t9, 1
 	j start128Y.1
 end128Y.1:
 #calculate 4X
add $t6, $zero, $t4 # want $t6 to store 4X
add $t6, $t6, $t4
add $t6, $t6, $t4
add $t6, $t6, $t4
 #calculate 128Y+4X
add $t6, $t6, $t7 #t6 stores 128Y+4X
add $t6, $t0, $t6 #t6 stores topleft of frog's address
sw $t1, 0($t6)
sw $t1, 4($t6)
sw $t1, 8($t6)
sw $t1, 12($t6)

sw $t1, 132($t6)
sw $t1, 136($t6)

sw $t1, 260($t6)
sw $t1, 264($t6)


sw $t1, 384($t6)
sw $t1, 396($t6)
endDown:

# record direction
lw $t6, direction
addi $t4, $zero, 2
bne $t6, $t4, endLeft # t6=2
lw $t4, frogX
lw $t5, frogY
#Calculate the topleft of frog's memory, which is 128Y+4X
 #calculate 128Y
 main128Y.2: add $t7, $zero, $zero  #want $t7 to store 128 Y
 	add $t8, $zero, 128 #loop 128 times
 	add $t9, $zero, $zero # loop accumulator
 start128Y.2: beq $t9, $t8, end128Y.2 #while $t9< $8
 	add $t7, $t7, $t5
 	addi $t9, $t9, 1
 	j start128Y.2
 end128Y.2:
 #calculate 4X
add $t6, $zero, $t4 # want $t6 to store 4X
add $t6, $t6, $t4
add $t6, $t6, $t4
add $t6, $t6, $t4
 #calculate 128Y+4X
add $t6, $t6, $t7 #t6 stores 128Y+4X
add $t6, $t0, $t6 #t6 stores topleft of frog's address
sw $t1, 0($t6)
sw $t1, 12($t6)

sw $t1, 132($t6)
sw $t1, 136($t6)
sw $t1, 140($t6)

sw $t1, 260($t6)
sw $t1, 264($t6)
sw $t1, 268($t6)

sw $t1, 384($t6)
sw $t1, 396($t6)
endLeft:


# record direction
lw $t6, direction
addi $t4, $zero, 3
bne $t6, $t4, endRight # t6=3
lw $t4, frogX
lw $t5, frogY
#Calculate the topleft of frog's memory, which is 128Y+4X
 #calculate 128Y
 main128Y.3: add $t7, $zero, $zero  #want $t7 to store 128 Y
 	add $t8, $zero, 128 #loop 128 times
 	add $t9, $zero, $zero # loop accumulator
 start128Y.3: beq $t9, $t8, end128Y.3 #while $t9< $8
 	add $t7, $t7, $t5
 	addi $t9, $t9, 1
 	j start128Y.3
 end128Y.3:
 #calculate 4X
add $t6, $zero, $t4 # want $t6 to store 4X
add $t6, $t6, $t4
add $t6, $t6, $t4
add $t6, $t6, $t4
 #calculate 128Y+4X
add $t6, $t6, $t7 #t6 stores 128Y+4X
add $t6, $t0, $t6 #t6 stores topleft of frog's address
sw $t1, 0($t6)
sw $t1, 12($t6)

sw $t1, 128($t6)
sw $t1, 132($t6)
sw $t1, 136($t6)

sw $t1, 256($t6)
sw $t1, 260($t6)
sw $t1, 264($t6)


sw $t1, 384($t6)
sw $t1, 396($t6)
endRight:




j endDrawFrog

# draw dead frog
drawDeadFrog:
lw $t4, deathX
lw $t5, deathY
#Calculate the topleft of frog's memory, which is 128Y+4X
 #calculate 128Y
 main128Y1: add $t7, $zero, $zero  #want $t7 to store 128 Y
 	add $t8, $zero, 128 #loop 128 times
 	add $t9, $zero, $zero # loop accumulator
 start128Y1: beq $t9, $t8, end128Y1 #while $t9< $8
 	add $t7, $t7, $t5
 	addi $t9, $t9, 1
 	j start128Y1
 end128Y1:
 #calculate 4X
add $t6, $zero, $t4 # want $t6 to store 4X
add $t6, $t6, $t4
add $t6, $t6, $t4
add $t6, $t6, $t4
 #calculate 128Y+4X
add $t6, $t6, $t7 #t6 stores 128Y+4X
add $t6, $t0, $t6 #t6 stores topleft of frog's address
sw $t1, 0($t6)
sw $t1, 12($t6)

sw $t1, 132($t6)
sw $t1, 136($t6)

sw $t1, 260($t6)
sw $t1, 264($t6)


sw $t1, 384($t6)
sw $t1, 396($t6)

addi $t4, $zero, 1
sw $t4, ifDeath
li $v0, 32
li $a0, 50
syscall
endDrawFrog:



# Draw Goal 1
lw $t4, goal1
addi $t5, $zero, 1
lw $t6, grey
beq $t4, $t5, drawFrog1
add $t4, $t0, $zero

sw $t6, 32($t4)
sw $t6, 36($t4)
sw $t6, 40($t4)
sw $t6, 44($t4)

sw $t6, 160($t4)
sw $t6, 164($t4)
sw $t6, 168($t4)
sw $t6, 172($t4)

sw $t6, 288($t4)
sw $t6, 292($t4)
sw $t6, 296($t4)
sw $t6, 300($t4)

sw $t6, 416($t4)
sw $t6, 420($t4)
sw $t6, 424($t4)
sw $t6, 428($t4)

j drawGoal1End

drawFrog1:
addi $t6, $zero, 32 #t6 stores 128Y+4X
add $t6, $t0, $t6 #t6 stores topleft of frog's address
sw $t1, 0($t6)
sw $t1, 12($t6)

sw $t1, 132($t6)
sw $t1, 136($t6)

sw $t1, 260($t6)
sw $t1, 264($t6)


sw $t1, 384($t6)
sw $t1, 388($t6)
sw $t1, 392($t6)
sw $t1, 396($t6)

drawGoal1End:


# Draw Goal 2
lw $t4, goal2
addi $t5, $zero, 1
lw $t6, grey
beq $t4, $t5, drawFrog2
add $t4, $t0, $zero

sw $t6, 80($t4)
sw $t6, 84($t4)
sw $t6, 88($t4)
sw $t6, 92($t4)

sw $t6, 208($t4)
sw $t6, 212($t4)
sw $t6, 216($t4)
sw $t6, 220($t4)

sw $t6, 336($t4)
sw $t6, 340($t4)
sw $t6, 344($t4)
sw $t6, 348($t4)

sw $t6, 464($t4)
sw $t6, 468($t4)
sw $t6, 472($t4)
sw $t6, 476($t4)

j drawGoal2End

drawFrog2:
addi $t6, $zero, 80 #t6 stores 128Y+4X
add $t6, $t0, $t6 #t6 stores topleft of frog's address
sw $t1, 0($t6)
sw $t1, 12($t6)

sw $t1, 132($t6)
sw $t1, 136($t6)

sw $t1, 260($t6)
sw $t1, 264($t6)


sw $t1, 384($t6)
sw $t1, 388($t6)
sw $t1, 392($t6)
sw $t1, 396($t6)

drawGoal2End:

# draw the number of lives remaining.
lw $t4, livesNumber
addi $t5, $zero, 1
addi $t6, $zero, 2
addi $t7, $zero, 3

bne $t4, $t5, elselife1
sw $t1, 12($t0)
sw $t1, 140($t0)
sw $t1, 268($t0)
sw $t1, 396($t0)
sw $t1, 524($t0)
elselife1:

bne $t4, $t6, elselife2
sw $t1, 4($t0)
sw $t1, 8($t0)
sw $t1, 12($t0)
sw $t1, 140($t0)
sw $t1, 268($t0)
sw $t1, 264($t0)
sw $t1, 260($t0)
sw $t1, 388($t0)
sw $t1, 516($t0)
sw $t1, 520($t0)
sw $t1, 524($t0)
elselife2:

bne $t4, $t7, elselife3
sw $t1, 4($t0)
sw $t1, 8($t0)
sw $t1, 12($t0)
sw $t1, 140($t0)
sw $t1, 268($t0)
sw $t1, 264($t0)
sw $t1, 260($t0)
sw $t1, 396($t0)
sw $t1, 516($t0)
sw $t1, 520($t0)
sw $t1, 524($t0)
elselife3:



# Draw score
lw $t4, score
addi $t5, $zero, 1
addi $t6, $zero, 2
# score = 1
beq $t4, $zero, endDrawScore1
beq $t4, $t6, endDrawScore1
sw $t1, 244($t0)
sw $t1, 248($t0)
sw $t1, 372($t0)
sw $t1, 376($t0)
endDrawScore1:

# score = 2
beq $t4, $zero, endDrawScore2
beq $t4, $t5, endDrawScore2
sw $t1, 244($t0)
sw $t1, 248($t0)
sw $t1, 372($t0)
sw $t1, 376($t0)

sw $t1, 232($t0)
sw $t1, 236($t0)
sw $t1, 360($t0)
sw $t1, 364($t0)
endDrawScore2:



# Draw safe region
# Draw two lives powerups in darkgreen
# 1st
sw $t1, 2076($t0)
sw $t1, 2080($t0)
sw $t1, 2084($t0)
sw $t1, 2088($t0)

sw $t1, 2204($t0)
sw $t1, 2208($t0)
sw $t1, 2212($t0)
sw $t1, 2216($t0)

sw $t1, 2332($t0)
sw $t1, 2336($t0)
sw $t1, 2340($t0)
sw $t1, 2344($t0)

sw $t1, 2460($t0)
sw $t1, 2464($t0)
sw $t1, 2468($t0)
sw $t1, 2472($t0)
# 2nd
sw $t1, 2132($t0)
sw $t1, 2136($t0)
sw $t1, 2140($t0)
sw $t1, 2144($t0)

sw $t1, 2260($t0)
sw $t1, 2264($t0)
sw $t1, 2268($t0)
sw $t1, 2272($t0)

sw $t1, 2388($t0)
sw $t1, 2392($t0)
sw $t1, 2396($t0)
sw $t1, 2400($t0)

sw $t1, 2516($t0)
sw $t1, 2520($t0)
sw $t1, 2524($t0)
sw $t1, 2528($t0)



# Draw hazards
lw $t4, hazardsNumber
lw $t5, black

bne $t4, 1, endDrawHazards
sw $t5, 676($t0)
sw $t5, 740($t0)
endDrawHazards:

j Step4



Step4:
#Step4: Sleep
li $v0, 32
li $a0, 20
syscall

j Step5

Step5:
#Steo5: Go back to Step1
j Step1


Restart:
# draw game over screen
sw $t1, 4($t0)
sw $t1, 8($t0)
sw $t1, 12($t0)
sw $t1, 132($t0)
sw $t1, 140($t0)
sw $t1, 396($t0)
sw $t1, 268($t0)
sw $t1, 260($t0)
sw $t1, 388($t0)
sw $t1, 516($t0)
sw $t1, 520($t0)
sw $t1, 524($t0)


addi $t4, $zero, 0
addi $t5, $zero, 1
addi $t6, $zero, 3
sw $t6 livesNumber 
sw $t5 ifDeath 
sw $t4 ifEnd 
sw $t4 goal1
sw $t4 goal2
sw $t4, score
sw $t4, hazardsNumber
sw $t4, direction

# check if key is pressed
CheckKey:
lw $t8, 0xffff0000
beq $t8, 1, keyboard_input1
j CheckKey

# If a key is pressed
keyboard_input1:
	lw $t2, 0xffff0004
	beq $t2, 0x72, respond_to_R
	j CheckKey
	
respond_to_R:
	j Step1




	

