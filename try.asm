public Drawboard
extern Filename:byte
.model Small
.stack 64
.data



DIRECTORY       DB      'D:\Pieces',0h
;Pieces          DB   
filehandle dw ?
chessData db  9C40h dup(?);
.code
Drawboard PROC far
mov ax , @data ;
mov ds , ax ;

MOV AH, 3BH
MOV DX, OFFSET DIRECTORY
INT 21H

call OpenFile;
call ReadData;

LEA bx , chessData
mov cx , 30h ;
mov dx , 0c8h ;
mov ah ,0ch ;


drawingloop :
mov al ,[Bx] ;
int 10h;
inc cx;
inc bx;
cmp cx , 0f8h;
JNE drawingloop ;
mov cx , 30H ;
dec dx ;
cmp dx, 0h;
JNE drawingloop;

mov ah , 0h ;
int 16h ;

call closeFile ;
;mov ah , 0h ;
;mov al , 3h ;
;int 10h ;




ret
Drawboard ENDP

OpenFile proc
mov ah , 3dh ;
mov al ,0h ;
LEA dx,Filename ;
int 21h ;   
mov [filehandle], ax;

RET ;
OpenFile ENDP ;

ReadData proc
mov ah , 3fh ;
mov bx , [filehandle];
mov cx , 9C40h;
LEA dx ,chessData;
int 21h;
;mov ah , 3fh;
RET;
ReadData ENDP;


closeFile proc;
mov ah , 3eh;
mov bx , [filehandle];
int 21h;
RET ;
closeFile ENDP;
End 

