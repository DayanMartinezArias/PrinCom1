.data 
prompt1: .asciiz "Introduza un número para repasar su tabla (0 para salir): "
por: .asciiz " x "
igual: .asciiz " = "
perc: .asciiz "% "
final_msg: .asciiz "Porcentage de aciertos: "
next_opt: .asciiz "Qué tabla desea repasar ahora (0 para salir): "
end_msg: .ascii "Programa finalizado"
comienzo: .word 0
aciertos: .word 0
comp: .word 0


.text
main:
#Guardar "comienzo" en $s1
lw $s1, comienzo

#Guardar "aciertos" en $s4
lw $s4, aciertos

#Guardar "comp" en $s5
lw $s5, comp

#Print ascii
li $v0, 4  
la $a0, prompt1
syscall

#Read int
li $v0, 5
syscall

#$0 = $v0
move $s0, $v0

#if $s0 = 0 => jump to end
beq $s0, $zero, end

#PARTE DEL LOOP
loop:
#print int
li $v0, 1
move $a0, $s0
syscall

#print "x"
li $v0, 4
la $a0, por
syscall

#Print second number
li $v0, 1
move $a0, $s1
syscall

#print "="
li $v0, 4
la $a0, igual
syscall

#Read result
li $v0, 5
syscall

#Store result in $s3
move $s3, $v0

#Imprimir salto de linea
li $v0, 11
li $a0, '\n'

#comprobacion
mul $s5, $s0, $s1
beq $s3, $s5, suma

#Salto a "suma_rein"
j suma_rein 

suma_rein:
#Sumamos +1 a $s1
add $s1, $s1, 1

#Reiniciamos el loop
ble $s1, 10, loop

#Salto a "Mostrar aciertos"
j mostrar_aciertos

mostrar_aciertos:
#Mostrar mensaje de aciertos
li $v0, 4
la $a0, final_msg
syscall

#Imprimir número
mul $s4, $s4, 10
sub $s4, $s4, 10
li $v0, 1
move $a0, $s4
syscall

#Imprimir "%"
li $v0, 4
la $a0, perc
syscall

#Imprimir salto de linea
li $v0, 11
li $a0, '\n'
syscall

j main

#Salto al final
j end

#+1 PUNTO
suma:
add $s4, $s4, 1
j suma_rein

#FINAL DEL PROGRAMA
end:
#Final msg
li $v0, 4
la $a0, end_msg
syscall

#end of program
li $v0, 10
syscall

