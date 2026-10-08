# ============================================================
# Comparacion de puntajes - Grupo 7 (version final)
# Integrantes: Allan Becerra y Jeremy Llerena
# Simulador: mipsy web
# ============================================================

.data
dato1:      .word 85    # puntaje jugador A
dato2:      .word 72    # puntaje jugador B
resultado1: .word 0     # diferencia jugadorA - jugadorB
resultado2: .word 0     # 1 si ambos tienen el mismo puntaje, 0 si no

msg_dif:    .asciiz "Diferencia de puntajes (A - B): "
msg_igual:  .asciiz "Mismo puntaje (1 = si, 0 = no): "
msg_empate: .asciiz "Resultado: los jugadores empataron.\n"
msg_distin: .asciiz "Resultado: los jugadores tienen puntajes diferentes.\n"

.text
.globl main

main:
    # ---------- 1. Cargar datos desde memoria hacia registros ----------
    lw   $t0, dato1        # $t0 = puntajeA (85)
    lw   $t1, dato2        # $t1 = puntajeB (72)

    # ---------- 2. Resta: diferencia jugadorA - jugadorB ----------
    sub  $t2, $t0, $t1     # $t2 = 85 - 72 = 13

    # ---------- 3. Comparacion: mismo puntaje? ----------
    seq  $t3, $t0, $t1     # $t3 = 1 si son iguales, 0 si no (85 != 72 -> 0)

    # ---------- 4. Guardar resultados en memoria ----------
    sw   $t2, resultado1   # resultado1 = 13
    sw   $t3, resultado2   # resultado2 = 0

    # ---------- 5. Mostrar resultados por pantalla ----------
    li   $v0, 4            # syscall 4: imprimir texto
    la   $a0, msg_dif
    syscall
    li   $v0, 1            # syscall 1: imprimir entero
    move $a0, $t2          # diferencia (13)
    syscall
    li   $v0, 11           # syscall 11: imprimir caracter
    li   $a0, '\n'         # salto de linea
    syscall

    li   $v0, 4
    la   $a0, msg_igual
    syscall
    li   $v0, 1
    move $a0, $t3          # resultado de la comparacion (0)
    syscall
    li   $v0, 11
    li   $a0, '\n'
    syscall

    # ---------- 6. Control de flujo con beq ----------
    beq  $t3, $zero, diferentes   # si $t3 = 0, los puntajes no son iguales

    li   $v0, 4            # $t3 = 1: empate
    la   $a0, msg_empate
    syscall
    j    fin

diferentes:
    li   $v0, 4            # $t3 = 0: puntajes diferentes
    la   $a0, msg_distin
    syscall

fin:
    # ---------- 7. Terminar el programa ----------
    li   $v0, 0
    jr   $ra
