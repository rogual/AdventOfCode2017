            .text
            .global _start

_start:
            mov $Input, %r15    # Read pointer
            mov $0, %r14        # Cell value
            mov $0, %r12        # Highest
            mov $9999, %r11     # Lowest
            mov $0, %r10        # Final answer

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
            # If we're higher than the highest, update it
            cmpq %r12, %r14
            jng NotHigher
            mov %r14, %r12
NotHigher:
            # If we're lower than the lowest, update it
            cmpq %r11, %r14
            jnl NotLower
            mov %r14, %r11
NotLower:
            # Reset cell variables for next cell
            mov $0, %r14
            ret

EndLine:
            # Subtract high from low & add to answer
            add %r12, %r10
            sub %r11, %r10

            # Reset line variables for next line
            mov $0, %r12
            mov $9999, %r11
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
