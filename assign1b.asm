// Name: Nam Nguyen Vu
// UCID: 30154892
// Tutorial 1
// TA: Akram
// CPSC 355 Assignment 1 (Part b)

.extern printf
fmt:    .string "With x = %d, the corresponding value of y is %d.\t The current max value of y is %d\n"
      
        .global main
        .balign 4

main:   stp     x29, x30, [sp, -16]!		
        mov     x29, sp

        define(i_r, x19)                        // Register for x
        define(x_r, x20)                        // Register for y
        define(a_r, x21)                        // Register for yMax
        define(b_r, x22)                        // Register for partial calculation of function

        mov     i_r, -10			// Initialize value -10 for x
        b       test				// Go to the bottom of the loop to test

top:    mov     x_r, 0				// Initialize y = 0

        mov     b_r, -4				// Move -4 to b_r (The register used to partially calculate y)
        mul     b_r, b_r, i_r			// y temp = -4 * x
        mul     b_r, b_r, i_r			// y temp = -4 * x^2
        mul     b_r, b_r, i_r			// y temp = -4 * x^3
	madd    x_r, b_r, i_r, x_r		// y current = y temp * x + y (y current = -4 * x^3 * x + 0 = -4x^4) 

        mov     b_r, 301			// Move 301 to b_r
        mul     b_r, b_r, i_r			// y temp = 301 * x
	madd    x_r, b_r, i_r, x_r		// y current = y temp * x + y (y current = 301x * x + -4x^4 = -4x^4 + 301x^2) 

        mov     b_r, 56				// Move 56 to b_r
	madd    x_r, b_r, i_r, x_r		// y current = y temp * x + y (y current = -4x^4 + 301x^2 + 56x) 
	
        mov     b_r, -103			// Move -103 to b_r
        add     x_r, x_r, b_r			// y current = y temp * x + y (y current = -4x^4 + 301x^2 + 56x - 103) 

        cmp     i_r, -10			// If x = -10, assign y to y max
        b.eq    assign				// Branch to assign function to add value y max to y

        cmp     x_r, a_r			// Compare y with current y max
        b.gt    assign				// If y > current y max, branch to assign function to add value y max to y

print:  ldr     x0, =fmt			// Formatting the print
        mov     x1, x19				// Add value of x to register x1 to format the printing
        mov     x2, x20				// Add value of y to register x2 to format the printing
        mov     x3, x21				// Add value of current y max to register x3 to format the printing

        bl      printf				// Print the statement

        add     i_r, i_r, 1			// Add 1 to x to continue the loop
        b       test				// Branch to test function to check whether the loop continue or not

assign: mov     a_r, x_r			// Change current y max value
        b       print				// Branch back to print

test:   cmp     i_r, 10				// The pre-test loop, stop when x reach 10
        b.le    top				// Exit the loop and branch to exit if x > 10

exit:   mov     x0, 0				// The last 3 lines are function to exit the code
        ldp     x29, x30, [sp], 16
        ret
