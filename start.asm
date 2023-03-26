

.model small
.stack 64
.data

message1   db   'To Start Chatting Press F1','$'
message2   db   'To Start the game Press F2','$'
message3   db   'To End The Program Press ESC','$'

.code
main proc far
    mov ax,@data
    mov ds,ax
    
    
    mov ax,0600h
    mov bh,07H
    mov cx,0
    mov dx,184FH
    int 10h

    mov ah,2H
    mov bh,0h
    mov dx,0h
    int 10h

    mov ah,2h
    mov dl,10H
    mov dh,5H
    int 10h  
    
    mov ah,9h
    mov dx,offset message1
    int 21h
    
    mov ah,2h
    mov dl,10H
    mov dh,7H
    int 10h
    
    mov ah,9h
    mov dx,offset message2
    int 21h
    
    mov ah,2h
    mov dl,30H
    mov dh,9H
    int 10h
    
    mov ah,9h
    mov dx,offset message3
    int 21h
    
    mov ah,0h
    int 16h
    
    
    HLT

main ENDP
end main         

    ;;this part can be written as macro since it will be used many times