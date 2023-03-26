
.model small
.stack 64
.data
message db 'Please Enter Your Name:','$'
username  dw  17h,?,15 dup('$')
message2 db 'Press Enter Key to continue','$'

.code
main proc far
    mov ax,@data
    mov DS,ax
    
    
    mov ah,2
    mov dl,5d
    mov dh,3d 
    int 10h
    
    mov ah,9
    mov dx,offset message
    int 21h 

    mov ah,2
    mov dl,5d
    mov dh,8d
    int 10h
    
    mov ah,9
    mov dx,offset message2
    int 21h
        
    mov ah,2
    mov dl,8d
    mov dh,4d
    int 10h
    
    mov ah,0ah;
    mov dx,offset username
    int 21h
        
    ;;depug usage
    mov ah,2
    mov dl,10d
    mov dh,9d
    int 10h
    
    mov ah,9
    mov dx,offset username+2
    int 21h
                  
main ENDP
end main
           