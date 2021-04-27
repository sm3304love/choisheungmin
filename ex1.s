.data 
source:
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest:
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text 
main:
    addi t0, x0, 0 # the register representing the variable k is t0.
    addi s0, x0, 0 #the register representing the variable sum is s0.
    la s1, source #Since s1 has the first address of the source array, it works as a pointer to the source.
    la s2, dest # Since s2 has the first address of the dest array, it works as a pointer to the dest.
loop:
    slli s3, t0, 2 # k 변수의 값을 4배 하고 s3에 저장(index)
    add t1, s1, s3 # source[k]의 값을 t1에 저장
    lw t2, 0(t1) #t2 = t1
    beq t2, x0, exit # if t2 == x0, move to exit
    add a0, x0, t2 #t2의 값과 x0의 값을 더해 a0에 저장
    addi sp, sp, -8 ## sp의 값에서 8을 뺀 것을 sp에 다시 저장
    sw t0, 0(sp) #sp가 가지고 있는 값인 메모리 주소에 t0의 값 대입
    sw t2, 4(sp) #(sp가 가지는 메모리 주소 + 4)의 위치에 t2값 대입
    jal square #square으로 점프 
    lw t0, 0(sp) # sp가 가지고 있던 주소 속 값을 t0에 대입
    lw t2, 4(sp) # (sp+4)가 가지고 있던 주소 속 값을 t2에 대입
    addi sp, sp, 8 # sp의 값에 8을 더해 stack pointer 값 원상복구
    add t2, x0, a0 # a0의 값을 t2에 저장
    add t3, s2, s3 #dest[k]의 값을 t3에 저장
    sw t2, 0(t3) #dest[k]의 값을 t2에 전달
    add s0, s0, t2 #t2 와 sum을 더한 것을 sum에 저장 
    addi t0, t0, 1 # k ++
    jal x0, loop
square:
    add t0, a0, x0 # a0와 x0을 더해서 t0에 저장
    add t1, a0, x0 # a0와 x0을 더해서 t1에 저장
    addi t0, t0, 1 # t0에 t0 + 1을 한 값 저장 (x+1)
    addi t2, x0, -1 # t2에 x0 - 1을 한 값 저장(-1)
    mul t1, t1, t2 #t1과 t2를 곱한 값을 t1에 저장 (x*-1)
    mul a0, t0, t1 #t0와 t1을 곱한 값 a0에 저장 (a0 = -x*(x+1))
    jr ra
exit:
    add a0, x0, s0 #sum을 a0에 저장
    add a1, x0, x0 # al을 0으로 초기화
    ecall # Terminate ecall
