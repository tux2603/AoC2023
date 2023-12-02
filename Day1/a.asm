.global _start
_start:

@ R0 will be used as a pointer to the current character in the string
LDR R0, =input

@ R1 will be used to store the running total
MOV R1, #0

@ R2 will be used to store the value of the first digit in the current string
MOV R2, #10

@ R3 will be used to store the value of the second digit in the current string
MOV R3, #0

@ loop until we reach the zero terminator
parse_loop:
    LDRB R4, [R0]

    @ if we reach the zero terminator, we're done
    CMP R4, #0
    BEQ loop

    @ if the current character is a digit, we need to parse it
    CMP R4, #'0'
    BLT not_digit
    CMP R4, #'9'
    BGT not_digit

    @ if R2 is 0x10, we haven't found the first digit yet
    CMP R2, #10

    @ store the current digit in R2 if we haven't found the first digit yet
    BNE found_second_digit
    MOV R2, R4
    SUB R2, R2, #'0'
	MOV R3, R2
    B end_loop

    @ store the current digit in R3 if we have found the first digit
    found_second_digit:
    MOV R3, R4
    SUB R3, R3, #'0'
    B end_loop

    not_digit:

    @ if the current character is a newline, we add the total and reset the digits
    CMP R4, #'\n'
    BNE end_loop
    MUL R2, R2, R4 @ R4 is 0x0A
    ADD R2, R2, R3
    ADD R1, R1, R2
    MOV R2, #10
    MOV R3, #0

    end_loop:
    @ increment the pointer to the next character and loop
    ADD R0, R0, #1
    B parse_loop

	
@ once this loop is reached the final result will be in R1
loop:
B loop

.data
@ replace this with input.txt
input: .asciz "1abc2\npqr3stu8vwx\na1b2c3d4e5f\ntreb7uchet\n"