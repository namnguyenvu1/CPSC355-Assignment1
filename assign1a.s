// Name: Nam Nguyen Vu
// UCID: 30154892
// Tutorial 1
// TA: Akram
// CPSC 355 Assignment 1 (Part a)

.extern printf
fmt:	.string "With x = %d, the corresponding value of y is %d.\t The current max value of y is %d\n"

	.global main
	.balign 4

main:	stp	x29, x30, [sp, -16]!
	mov	x29, sp

	//Body of the main function
	mov	x19, -10	// Register for x, x starts at -10
	mov	x20, 0		// Register for y
	mov	x21, 0		// Register for ymax

	//loop body
test:	cmp	x19, 10		// The pre-test loop, stop when x reach 10
	b.gt	exit		// Exit the loop and branch to exit if x > 10

	mov	x20, 0		// Add 0 as initial value for y

	mov	x22, -4		// Use x22 as temporary register to partially calculate y (x22 = -4)
	mul	x22, x22, x19	// x22 = -4 * x
	mul	x22, x22, x19	// x22 = -4 * x^2
	mul	x22, x22, x19	// x22 = -4 * x^3
	mul	x22, x22, x19	// x22 = -4 * x^4
	add	x20, x20, x22	// Add temp value of x22 to y (currently y = -4 * x^4) 

	mov	x22, 301	// x22 = 301
	mul	x22, x22, x19	// x22 = 301 * x
	mul	x22, x22, x19	// x22 = 301 * x^2
	add	x20, x20, x22	// Add temp value of x22 to y (currently y = -4 * x^4 + 301x^2) 

	mov	x22, 56		// x22 = 56
	mul	x22, x22, x19	// x22 = 56 * x
	add	x20, x20, x22	// Add temp value of x22 to y (currently y = -4 * x^4 + 301x^2 + 56x) 

	add	x20, x20, -103	// Add -103 to y (currently y = -4 * x^4 + 301x^2 + 56x - 103) 
	
	cmp	x19, -10	// If x = -10, assign y to y max
	b.eq	assign		// Branch to assign function to add value y max to y

	cmp	x20, x21	// Compare y with current y max
	b.gt	assign		// If y > current y max, branch to assign function to add value y max to y
	
print:	ldr	x0, =fmt	// Formatting the print
	mov	x1, x19		// Add value of x to register x1 to format the printing
	mov	x2, x20		// Add value of y to register x2 to format the printing
	mov	x3, x21		// Add value of current y max to register x3 to format the printing
	bl	printf		// Print the statement
	add 	x19, x19, 1	// Add 1 to x to continue the loop
	b	test		// Branch to test function to check whether the loop continue or not

assign:	mov	x21, x20	// Change current y max value
	b	print		// Branch back to print

exit:	mov	x0,0		// The last 3 lines are function to exit the code
	ldp	x29, x30, [sp], 16
	ret
