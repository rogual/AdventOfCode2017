            .text
            .global _start

_start:
            mov $Input, %r15      # Read pointer

            mov $0, %r14          # Cell value
            mov $LineBuffer, %r13 # Line buffer pointer
            mov $0, %r10          # Final answer

ReadChar:
            xor %rax, %rax
            mov (%r15), %al

            # Check for tab
            mov $9, %rbx
            cmpq %rax, %rbx
            je Tab

            # Check for newline
            mov $10, %rbx
            cmpq %rax, %rbx
            je Newline

            # Check for end of input
            mov $0, %rbx
            cmpq %rax, %rbx
            je EndInput

            # Not a tab or newline; must be digit
Digit:
            # Get digit's value by subtracting ASCII '0'
            sub $48, %rax

            # Shift & add to cell value
            imulq $10, %r14
            add %rax, %r14

ReadNextChar:
            inc %r15
            jmp ReadChar

Newline:
            call EndCell
            call EndLine
            jmp ReadNextChar

Tab:
            call EndCell
            jmp ReadNextChar

EndCell:
            # Write cell value into line buffer
            movq %r14, (%r13)
            addq $8, %r13

            # Reset cell variables for next cell
            mov $0, %r14
            ret

EndLine:
            # Nested loop to find which pair of values divides
            # Loop vars are %r11 and %r12
            mov $0, %r11
LoopI:
            mov $0, %r12
LoopJ:
            cmp %r11, %r12
            je Continue

            mov LineBuffer(%r11), %rbx
            mov LineBuffer(%r12), %rcx

            # Try this division
            mov $0, %rdx
            mov %rbx, %rax
            div %rcx

            # Result now in rax, remainder in rdx
            # Break if remainder=0
            mov $0, %rbx
            cmp %rbx, %rdx
            je DivResultFound

Continue:

            add $8, %r12
            cmpq $128, %r12
            jne LoopJ

            add $8, %r11
            cmpq $128, %r11
            jne LoopI

            # Div result not found. Error!
            mov $-1, %r10
            jmp EndInput


DivResultFound:
            # Add div result to final answer
            add %rax, %r10

            # Reset line variables for next line
            mov $LineBuffer, %r13
            ret

EndInput:
            # Write answer to stdout as 64-bit binary

            mov $8, %rdx

            movq %r10, (Input)
            mov $Input, %rsi
            pushq $0x1
            pop %rax
            mov %rax, %rdi
            syscall


            # Exit
            xor %rdi, %rdi
            pushq $0x3c
            pop %rax
            syscall

            .data
Input:
            .incbin "aoc2.in"
            .byte 0
InputEnd:

            .align 16
LineBuffer:
            .rept 16
            .quad 0
            .endr
