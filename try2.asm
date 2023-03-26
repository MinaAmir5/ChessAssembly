
extern Drawboard:far
public Filename
.model large
.stack 64
.data
;Filename db 'bbk.bin', 0h;
DIRECTORY       DB      'D:\Pieces',0h
filehandle dw ?
chessData db  625d dup(?);
Filename        db      'chess.bin', 0h;

.code
main PROC far
mov ax , @data ;
mov ds , ax ;

mov ah,0;
mov al,13h;
int 10h;

call Drawboard
;--------------------------input BBB------------------------------------
mov ax,'bb'
mov Filename,al 
mov Filename+1,ah
mov ax,'b.'
mov Filename+2,ah
mov Filename+3,al 
mov ax,'bi'
mov Filename+4,ah
mov Filename+5,al
mov ah,'n'
mov Filename+6,ah
mov ah,0         
mov Filename+7,ah


;--------------------------------------------------------------
call DrawPiece


;--------------------------input BBk------------------------------------

mov ax,'bb'
mov Filename,al 
mov Filename+1,ah
mov ax,'k.'
mov Filename+2,ah
mov Filename+3,al 
;--------------------------------------------------------------
mov dh, 10
	mov dl, 25
	mov bh, 0
	mov ah, 2
	int 10h
call DrawPiece

mov ah , 4ch ;
int 21h;
hlt
main ENDP
;--------------------------end main------------------------------------

;--------------------------open file------------------------------------
OpenFile proc
mov ah , 3dh ;
mov al ,0h ;
LEA dx,Filename ;
int 21h ;   
mov [filehandle], ax;

RET ;
OpenFile ENDP ;

;--------------------------read dtat------------------------------------
ReadData proc
mov ah , 3fh ;
mov bx , [filehandle];
mov cx , 625d;
LEA dx ,chessData;
int 21h;
;mov ah , 3fh;
RET;
ReadData ENDP;

;--------------------------close file------------------------------------
closeFile proc;
mov ah , 3eh;
mov bx , [filehandle];
int 21h;
RET ;
closeFile ENDP;


;--------------------------Draw piece------------------------------------
DrawPiece proc far


MOV AH, 3BH
MOV DX, OFFSET DIRECTORY
INT 21H

call OpenFile;
call ReadData;

LEA bx , chessData
mov cx , 30h ;
mov dx , 0h ;
mov ah ,0ch ;


drawingloop :
mov al ,[Bx] ;
int 10h;
inc cx;
inc bx;
cmp cx , 49h;
JNE drawingloop ;
mov cx , 30H ;
inc dx ;
cmp dx, 19h;
JNE drawingloop;

mov ah , 0h ;
int 16h ;

call closeFile ;


ret
DrawPiece ENDP





End main

