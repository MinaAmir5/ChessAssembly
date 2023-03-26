.model small
.stack 64
.data
        welcome    db "welcome to Game of Pawns",10,13,"Are you ready to Rook?",'$'
        Hello      db 10,13,"Please Enter Your UserName: ",'$'
        hello2     db 10,13,"Hello ",'$'
        validation db 10,13,"Invalid Username",'$'
        Username   db 30,?,30 dup('$')
        enter      db 10,13,'$'
.code
main proc far
                mov AX,@data
                mov DS,AX

                mov al,0
                mov ah,2
                mov dx,0A0Ah
                int 0Ah

                mov ah,9
                mov dx,offset welcome
                int 21h

        User:   mov ah,9
                mov dx,offset hello
                int 21h

                mov ah,0Ah
                mov dx,offset username
                int 21h

                mov BH,username+2
                CMP BH,41H
                JB  invalid
                cmp BH,7AH
                JA  Invalid
                CMP BH,5BH
                JB  VALID
                CMP BH,61H
                JB  INVALID

        VALID:  mov ah,9
                mov dx,offset hello2
                int 21h

                mov ah,9
                mov dx,offset username+2
                int 21h

                mov ah,9
                mov dx,offset enter
                int 21h

                mov ah,0
                mov dx,1
                mov al,0C3h
                int 14h

        Again:  mov AH,01
                INT 16H
                JZ  NEXT
                MOV AH,0
                INT 16H

                CMP AL,1BH
                JE  EXIT
                MOV AH,1
                MOV DX,01
                INT 14h

        NEXT:   MOV AH,03
                MOV DX,01
                INT 14h
                AND AH,01
                CMP AH,01
                JNE Again
                MOV AH,02
                MOV DX,01
                INT 14h
                MOV DL,AL
                MOV AH,02
                INT 21h
                JMP Again

        EXIT:   
                mov ah,4ch
                int 21h

        invalid:mov ah,9
                mov dx,offset validation
                int 21h
                jmp user
main endp
end main