.data
puntajeA:       .word 85        # puntaje jugador A
puntajeB:       .word 72        # puntaje jugador B
diferencia:     .word 0         # diferencia puntajeA - puntajeB
iguales:        .word 0         # 1 si ambos tienen el mismo puntaje, 0 si no
msg_iguales:    .asciiz "Puntajes iguales\n"
msg_diferencia: .asciiz "Diferencia de puntos: "
msg_distintos:  .asciiz "\nPuntajes diferentes\n"

.text
.globl main

main:
    # Cargar datos desde memoria hacia registros
    lw   $t0, puntajeA          # $t0 = puntajeA (85)
    lw   $t1, puntajeB          # $t1 = puntajeB (72)

    # Resta: diferencia puntajeA - puntajeB
    sub  $t2, $t0, $t1          # $t2 = 85 - 72 = 13

    # Comparacion: ambos jugadores obtuvieron el mismo puntaje?
    seq  $t3, $t0, $t1          # $t3 = 1 si son iguales, 0 si no (85 != 72 -> 0)

    # Guardar resultados en memoria
    sw   $t2, diferencia        # diferencia = 13
    sw   $t3, iguales           # iguales = 0

    # Decidir que mostrar en pantalla segun el resultado de la comparacion
    bne  $t3, $zero, Iguales    # si iguales == 1, mostrar "Puntajes iguales"

Diferentes:
    # Mostrar "Diferencia de puntos: "
    li   $v0, 4
    la   $a0, msg_diferencia
    syscall

    # Mostrar el valor numerico de la diferencia
    li   $v0, 1
    add  $a0, $t2, $zero
    syscall

    # Mostrar "Puntajes diferentes"
    li   $v0, 4
    la   $a0, msg_distintos
    syscall

    j    Exit

Iguales:
    # Mostrar "Puntajes iguales"
    li   $v0, 4
    la   $a0, msg_iguales
    syscall

Exit:
    # Terminar el programa
    li   $v0, 10
    syscall
