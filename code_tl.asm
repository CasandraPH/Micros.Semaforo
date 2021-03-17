#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)     
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program
;variables para el contador:
i equ 0x30
j equ 0x31
k equ 0x32
m equ 0x33
;inicio del programa: 
START
    MOVLW 0x07 ;Apagar comparadores
    MOVWF CMCON
    BCF STATUS, RP1 ;Cambiar al banco 1
    BSF STATUS, RP0 
    MOVLW b'00000000' ;Establecer puerto B como salida (los 8 bits del puerto)
    MOVWF TRISB
    BCF STATUS, RP0 ;Regresar al banco 0
    NOP
    
inicio:  
    bsf PORTB,5     ;enciende rojo s1 
    bsf PORTB,0	    ;enciende verde s2
    bcf PORTB,1
    BCF PORTB,2
    BCF PORTB,3
    BCF PORTB,4
    call tiempo1 ;llamar a la rutina de tiempo
    call tiempo1
    call tiempo1
    call tiempo1
    call tiempo1
    bcf PORTB,0	    ;apaga verde s2
    bsf PORTB,1	    ;enciende amarillo s2
    call tiempo1
    bcf PORTB,5	    ;apaga rojo s1
    bcf PORTB,1	    ;apaga amarillo s2
    bsf PORTB,3	    ;enciende verde s1
    bsf PORTB,2	    ;enciende rojo s2
    call tiempo1
    call tiempo1
    call tiempo1
    call tiempo1
    call tiempo1
    bcf PORTB,3	    ;apaga verde s1
    bsf PORTB,4	    ;enciende amarillo s1
    call tiempo1
    bcf PORTB,2	    ;apaga rojo s2
    bcf PORTB,4	    ;apaga amarillo s1  
    goto inicio  ;regresar y repetir
  
;rutina de tiempo
tiempo1:  
    movlw   d'7'
    movwf   m
mloop:
    decfsz  m,f
    goto mloop  
    movlw d'108' ;establecer valor de la variable i
    movwf i
iloop:
    nop	      ;NOPs de relleno (ajuste de tiempo)
    nop
    nop
    nop
    nop	
    movlw d'50' ;establecer valor de la variable j  (50)
    movwf j
jloop:	
    nop         ;NOPs de relleno (ajuste de tiempo) (5 400)
    movlw d'60' ;establecer valor de la variable k   
    movwf k
kloop:	
    decfsz k,f  
    goto kloop
    decfsz j,f
    goto jloop
    decfsz i,f
    goto iloop
    return	;salir de la rutina de tiempo y regresar al 
		;valor de contador de programa
    END