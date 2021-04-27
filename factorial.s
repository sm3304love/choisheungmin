.globl factorial

.data
n: .word 8

.text
main:
    la t0, n #n의 주소를 t0에 저장
    lw a0, 0(t0) #t0가 가지는 word 자료형인 8을 a0에 저장
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
 loop:
    addi t4, x0, 1
    lw t1, 0(t0)
    addi t1, t1, -1
    addi t2, t1, -1
    beq t1, x0, exit
    beq t1, t4, exit
    mul t3, t1, t2
    mul a0, a0, t3
    addi t1, t1, -1
    sw  t1 , 0(t0)
    bne t2, x0, loop
    jr ra
exit :
    jr ra

    

