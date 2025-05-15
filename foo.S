.section .vectors
vector_table:
    .word 0x20001000
    .word reset_handler
    .zero 400

    .section .text
    .align 1
    .type reset_handler, %function
reset_handler:
    MOV	    r1, #0x1
    MOV	    r2, #0x2

    push {r1, r2}

    MOV	    r1, #5
    MOV	    r2, #5

    pop {r2, r1}

    bl .