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

    digit:
        @ if R2 is 0x10, we haven't found the first digit yet
        CMP R2, #10

        @ store the current digit in R2 if we haven't found the first digit yet
        BNE found_second_digit
        found_first_digit:
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
        BNE check_string_1
        MUL R2, R2, R4 @ R4 is 0x0A
        ADD R2, R2, R3
        ADD R1, R1, R2
        MOV R2, #10
        MOV R3, #0
        B end_loop

        @ To check the strings:
        @  - verify that all the necessary characters are present
        @  - increment the pointer to skip the extra characters
        @  - load the proper value into R4
        @  - jump to digit processing
        @ Is this the best way, probably not, but it works and it's easy to write
        check_string_1:
            LDRB R4, [R0]
            CMP R4, #'o'
            BNE check_string_2
            LDRB R4, [R0, #1]
            CMP R4, #'n'
            BNE check_string_2
            LDRB R4, [R0, #2]
            CMP R4, #'e'
            BNE check_string_2
            @ ADD R0, R0, #2
            MOV R4, #'1'
            B digit

        check_string_2:
            LDRB R4, [R0]
            CMP R4, #'t'
            BNE check_string_3
            LDRB R4, [R0, #1]
            CMP R4, #'w'
            BNE check_string_3
            LDRB R4, [R0, #2]
            CMP R4, #'o'
            BNE check_string_3
            @ ADD R0, R0, #2
            MOV R4, #'2'
            B digit

        check_string_3:
            LDRB R4, [R0]
            CMP R4, #'t'
            BNE check_string_4
            LDRB R4, [R0, #1]
            CMP R4, #'h'
            BNE check_string_4
            LDRB R4, [R0, #2]
            CMP R4, #'r'
            BNE check_string_4
            LDRB R4, [R0, #3]
            CMP R4, #'e'
            BNE check_string_4
            LDRB R4, [R0, #4]
            CMP R4, #'e'
            BNE check_string_4
            @ ADD R0, R0, #4
            MOV R4, #'3'
            B digit

        check_string_4:
            LDRB R4, [R0]
            CMP R4, #'f'
            BNE check_string_5
            LDRB R4, [R0, #1]
            CMP R4, #'o'
            BNE check_string_5
            LDRB R4, [R0, #2]
            CMP R4, #'u'
            BNE check_string_5
            LDRB R4, [R0, #3]
            CMP R4, #'r'
            BNE check_string_5
            @ ADD R0, R0, #3
            MOV R4, #'4'
            B digit

        check_string_5:
            LDRB R4, [R0]
            CMP R4, #'f'
            BNE check_string_6
            LDRB R4, [R0, #1]
            CMP R4, #'i'
            BNE check_string_6
            LDRB R4, [R0, #2]
            CMP R4, #'v'
            BNE check_string_6
            LDRB R4, [R0, #3]
            CMP R4, #'e'
            BNE check_string_6
            @ ADD R0, R0, #3
            MOV R4, #'5'
            B digit

        check_string_6:
            LDRB R4, [R0]
            CMP R4, #'s'
            BNE check_string_7
            LDRB R4, [R0, #1]
            CMP R4, #'i'
            BNE check_string_7
            LDRB R4, [R0, #2]
            CMP R4, #'x'
            BNE check_string_7
            @ ADD R0, R0, #2
            MOV R4, #'6'
            B digit

        check_string_7:
            LDRB R4, [R0]
            CMP R4, #'s'
            BNE check_string_8
            LDRB R4, [R0, #1]
            CMP R4, #'e'
            BNE check_string_8
            LDRB R4, [R0, #2]
            CMP R4, #'v'
            BNE check_string_8
            LDRB R4, [R0, #3]
            CMP R4, #'e'
            BNE check_string_8
            LDRB R4, [R0, #4]
            CMP R4, #'n'
            BNE check_string_8
            @ ADD R0, R0, #4
            MOV R4, #'7'
            B digit

        check_string_8:
            LDRB R4, [R0]
            CMP R4, #'e'
            BNE check_string_9
            LDRB R4, [R0, #1]
            CMP R4, #'i'
            BNE check_string_9
            LDRB R4, [R0, #2]
            CMP R4, #'g'
            BNE check_string_9
            LDRB R4, [R0, #3]
            CMP R4, #'h'
            BNE check_string_9
            LDRB R4, [R0, #4]
            CMP R4, #'t'
            BNE check_string_9
            @ ADD R0, R0, #4
            MOV R4, #'8'
            B digit

        check_string_9:
            LDRB R4, [R0]
            CMP R4, #'n'
            BNE check_string_0
            LDRB R4, [R0, #1]
            CMP R4, #'i'
            BNE check_string_0
            LDRB R4, [R0, #2]
            CMP R4, #'n'
            BNE check_string_0
            LDRB R4, [R0, #3]
            CMP R4, #'e'
            BNE check_string_0
            @ ADD R0, R0, #3
            MOV R4, #'9'
            B digit

        check_string_0:
            LDRB R4, [R0]
            CMP R4, #'z'
            BNE end_loop
            LDRB R4, [R0, #1]
            CMP R4, #'e'
            BNE end_loop
            LDRB R4, [R0, #2]
            CMP R4, #'r'
            BNE end_loop
            LDRB R4, [R0, #3]
            CMP R4, #'o'
            BNE end_loop
            @ ADD R0, R0, #3
            MOV R4, #'0'
            B digit

    end_loop:
    @ increment the pointer to the next character and loop
    ADD R0, R0, #1
    B parse_loop


@ once this loop is reached the final result will be in R1
loop:
B loop

.data
@ replace this with input.txt
input: .asciz "two1nine\neightwothree\nabcone2threexyz\nxtwone3four\n4nineeightseven2\nzoneight234\n7pqrstsixteen\n"