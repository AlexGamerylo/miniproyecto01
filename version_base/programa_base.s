.data
dato1:      .word 85    # puntaje jugador A
dato2:      .word 72    # puntaje jugador B
resultado1: .word 0     # diferencia jugadorA - jugadorB
resultado2: .word 0     # 1 si ambos tienen el mismo puntaje, 0 si no

.text
.globl main

main:
    # Cargar datos desde memoria hacia registros
    lw   $t0, dato1        # $t0 = puntajeA (85)
    lw   $t1, dato2        # $t1 = puntajeB (72)

    # Resta: diferencia jugadorA - jugadorB
    sub  $t2, $t0, $t1     # $t2 = 85 - 72 = 13

    # Comparacion: ambos jugadores obtuvieron el mismo puntaje?
    seq  $t3, $t0, $t1     # $t3 = 1 si son iguales, 0 si no (85 != 72 -> 0)

    # Guardar resultados en memoria
    sw   $t2, resultado1   # resultado1 = 13
    sw   $t3, resultado2   # resultado2 = 0

    li   $v0, 0
    jr   $ra
