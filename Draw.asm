.MODEL      LARGE
.STACK  64
.DATA

boardWidth      equ     200d
boardHeight     equ     200d

FILENAME        DB      'Grey.bin', 0
FILEHANDLE      DW      ?

IMAGEDATA       DB      boardWidth*boardHeight DUP(0)

.CODE

MAIN        PROC      FAR
MOV AX, @DATA
MOV DS, AX

CALL OpenFile
CALL ReadData

MOV AH, 0H
MOV AL, 13H
INT 10H

MOV CX, 0H
MOV DX, 0H
MOV AH, 0CH
MOV BX, OFFSET IMAGEDATA

DRAWROW:    MOV AL, [BX]
            INT 10H
            INC CX
            INC BX
            CMP CX, boardWidth
JNZ DRAWROW

MOV CX, 0H
INC DX
CMP DX, boardHeight

JNZ DRAWROW

CALL CloseFile


MAIN ENDP

OpenFile        PROC
    MOV AH, 3DH
    MOV AL, 0 ; READ ONLY
    LEA DX, FILENAME
    INT 21H

    MOV  [FILEHANDLE], AX
    RET

OpenFile ENDP

ReadData        PROC
    MOV AH, 3FH
    MOV BX, [FILEHANDLE]
    MOV CX, boardWidth*boardHeight 
    LEA DX, IMAGEDATA
    INT 21H
    RET

ReadData    ENDP

CloseFile       PROC
    MOV AH, 3EH
    MOV BX, [FILEHANDLE]
    INT 21H
    RET
CloseFile ENDP

END MAIN