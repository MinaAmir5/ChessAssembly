showmain Macro message1,message2,message3
    pusha
    mov ax,0003h
    int 10h    
    
    mov ah,2h
    mov dl,10
    mov dh,5
    int 10h  
    
    mov ah,9h
    mov dx,offset message1
    int 21h
    
    mov ah,2h
    mov dl,10
    mov dh,7
    int 10h
    
    mov ah,9h
    mov dx,offset message2
    int 21h
    
    mov ah,2h
    mov dl,10
    mov dh,9
    int 10h
    
    mov ah,9h
    mov dx,offset message3
    int 21h
    popa
ENDM

printnotification MACRO message123
    mov ah,2h
    mov dl,2d
    mov dh,23d
    int 10h  
    
    mov ah,9h
    mov dx,offset message123
    int 21h
ENDM

printline MACRO
    pusha 
    local middle
    mov ah,2                    ;; print the line of the notify bar
    mov dl,0d
    mov dh,22d
    int 10h   
    mov cx,80    
    middle:         
    mov ah,2 
    mov dl,'-'
    int 21h
    loop middle:
    popa
ENDM    

.model small
.stack 64
.data

message1        db       'To Start Chatting Press F1','$'
message2        db       'To Start the game Press F2','$'
message3        db       'To End The Program Press ESC','$'
chatmessage     db       'Chat mode','$'
gamemode        db       'Gamemode','$'
waitchatmes     db       'There is a chat invitation. If you want to accept it click f1','$'
waitplaymes     db       'There is a game invitation. If you want to accept it click f2','$'   
dashes          db       '-','$'
end             db       'The Program has been ended','$'

.code
main proc far
    mov ax,@data
    mov ds,ax    
    mov ax,0003h                ;; clear the screen
    int 10h    
        
again:
    
    showmain message1,message2,message3
    printline    
    
    incorrect:
    mov ah,0h
    int 16h
    push ax
    pop ax
    
    cmp ah,01h                  ;; end program
    jz finish
    
    cmp ah,3bH                  ;; check chat
    jz Chat
    
    cmp ah,3ch                  ;; check game                                        
    jz play

    jnz incorrect               

    chat:
    printnotification waitchatmes    
    incorrect2:
    mov ah,0h
    int 16h
    cmp ah,3bh
    jnz incorrect2    
    mov ax,0003h
    int 10h
    mov ah,9
    mov dx, offset chatmessage
    int 21h
    printline
    waitchat:
    mov ah,0h
    int 16h  
    cmp ah,3dh
    jnz waitchat
    jz again
        
    play:
    printnotification waitplaymes
    incorrect1:
    mov ah,0h
    int 16h
    cmp ah,3ch
    jnz incorrect1
    mov ax,0003h
    int 10h
    mov ah,9
    mov dx, offset gamemode
    int 21h    
    printline
    waitplay:
    mov ah,0h
    int 16h  
    cmp ah,3dh
    jnz waitplay
    jz again

    
Finish:
HLT
main ENDP
end main         
 