#Systick configuration register
.equ systick_csr,   0xE000E010
.equ systick_rvr,   0xE000E014
.equ systick_cvr,   0xE000E018
.equ systick_calib, 0xE000E01C

.equ timeout,       0x00FFFFFF



.section .vectors
vector_table:
    .word 0x20001000
    .word reset_handler

.org 0x3C
    .word systick_handler
    .zero 400

    .section .text
    .align 1
    .type reset_handler, %function
reset_handler:
    MOV	    r5, #0x0

    LDR	    r0, =systick_csr
    LDR	    r1, =systick_rvr
    LDR	    r2, =systick_cvr
    LDR	    r3, =timeout

    STR	    r3, [r1]        //store r3 value in the address present in r1  rvr->0x00FFFFFF
    MOV	    r3, #0x0        //write 0x0 in r3 register
    STR	    r3, [r2]        //store r3 value in the address present in r1  cvr->0x0
    MOV	    r3, #0x7        //write 0x7 in r3 register
    STR	    r3, [r0]        //store r3 value in the address present in r1  csr->0x7

    bl .


    .section .text
    .align 1
    .type systick_handler, %function
systick_handler:
    //ADD	    r5, r5, #1

    push {r4-r7}

    MOV	    r0,r8
    MOV	    r1,r9
    MOV	    r2,r10
    MOV	    r3,r11

    push {r0-r3}

magic:
    pop {r0-r3}

    MOV	    r8,r0
    MOV	    r9,r1
    MOV	    r10,r2
    MOV	    r11,r3

    pop {r4-r7}

    bx lr

# Tasks
    .section .text
    .p2align 4
    .globl main1
    .type main1, %function
main1:
    NOP
    ADD	    r0, r0, #1
    b main1

    .section .text
    .p2align 4
    .globl main2
    .type main2, %function
main2:
    NOP
    ADD	    r1, r1, #2
    b main2

    .section .text
    .p2align 4
    .globl main3
    .type main3, %function
main3:
    NOP
    ADD	    r2, r2, #3
    b main3


    .data
    .align 4
stack_1:
    .word 0x18
    .word 0x19
    .word 0x1a
    .word 0x1b
    .word 0x14
    .word 0x15
    .word 0x16
    .word 0x17
    .word 0x10
    .word 0x11
    .word 0x12
    .word 0x13
    .word 0x1c
    .word 0x309
    .word main1
    .word 0x1000000
    .zero 64
    .align 4
stack_2:
    .word 0x28
    .word 0x29
    .word 0x2a
    .word 0x2b
    .word 0x24
    .word 0x25
    .word 0x26
    .word 0x27
    .word 0x20
    .word 0x21
    .word 0x22
    .word 0x23
    .word 0x2c
    .word 0x309
    .word main2
    .word 0x1000000

    .zero 64
    .align 4
stack_3:
    .word 0x38
    .word 0x39
    .word 0x3a
    .word 0x3b
    .word 0x34
    .word 0x35
    .word 0x36
    .word 0x37
    .word 0x30
    .word 0x31
    .word 0x32
    .word 0x33
    .word 0x3c
    .word 0x309
    .word main3
    .word 0x1000000

