.386
DATA SEGMENT USE16
N equ 0AH;
MENU DB 0AH,0DH,09H,09H,'student grade system $'
win1 DB 0AH,0DH,09H,09H,'please choose 1 or 2 $'
win2 DB 0AH,0DH,09H,09H,'1.input score $'
win3 DB 0AH,0DH,09H,09H,'2.Search $'
win4 DB 0AH,0DH,09H,09H,'Press e to quit $'
win5 DB 0AH,0DH,'please enter ID: $'
win6 DB 0AH,0DH,'score: $'
win7 DB 0AH,0DH,'rank: $'
win8 DB 0AH,0DH,'Exit(e) or Continue(c) $'
win9 DB 0AH,0DH,'ID: $'
win10 DB 0AH,0DH,'score: $'
win11 DB 0AH,0DH,'rank：$'
win12 DB 0AH,0DH,'Not Found! $'



BUF DB 10
    DB 0
	DB 10(0)
BUF2 DB 10
     DB 0
	 DB 10(0)
BUF3 DB 10
     DB 0
	 DB 10(0)
BUF4 DB 10
     DB 0
	 DB 10(0)
	 


ACLEN DB 1
	 
STUDENT STRUC
        ID db 6 dup('$')
		score db 6 dup('$')
		rank db 6 dup('$')
STUDENT ENDS
STUDENTS STUDENT N dup(<>)

DATA ENDS

STACK SEGMENT USE16
      DB 200 DUP(0)
STACK ENDS

CODE SEGMENT USE16
     ASSUME CS:CODE,DS:DATA,SS:STACK 
	 

MOVSTRING MACRO destin,source,length
push ax
push cx
push si
push di
mov  ax,ds
mov  es,ax
mov  cl,length
mov  ch,0
lea si,source   
lea di,destin 
cld      
rep movsb   
pop  di
pop  si
pop  cx
pop  ax
ENDM

compare macro destin,source,length
      push cx
      push ds
      push es
      push di
      push si
	  lea si,destin
      lea di,source
      mov cl,length
      mov ch,
	  repz cmpsb  
	  je  PRINT
	  jne NOTFOUND

      pop  si
      pop  di
      pop  es
      pop  ds
      pop cx
endm





mov ax,DATA
mov ds,ax
;显示主窗口页面
HOME:lea dx,MENU
     mov ah,9
     int 21h
     lea dx,win1
	 mov ah,9
	 int 21h
	 lea dx,win2
     mov ah,9
	 int 21h
     lea dx,win3
     mov ah,9
	 int 21h
	 lea dx,win4
	 mov ah,9
	 int 21h
;调用一号功能获得输入
	mov ah,1
	int 21h
	
	cmp al,65h
	je EXIT

    ;cmp al,32h
	;je OUTPUT1

	
	cmp al,31h
    call INPUT
	
	
	
;OUTPUT1:call OUTPUT
EXIT: mov ah,4ch
      int 21h



;输入
INPUT PROC
push cx
push dx
push bx
push ax
xor cx,cx
mov cx,N
lea bx,STUDENTS

LOOPINPUT:lea dx,win5
     mov ah,9
     int 21h
     lea dx,BUF
     mov ah,10
     int 21h
	 MOVSTRING [bx].ID,BUF,ACLEN
     
     lea dx,win6 
     mov ah,9
     int 21h
     lea dx,BUF2
     mov ah,10
     int 21h
	 MOVSTRING [bx].score,BUF2,ACLEN

     lea dx,win7
     mov ah,9
     int 21h
     lea dx,BUF3
     mov ah,10 
     int 21h
	 MOVSTRING [bx].rank,BUF3,ACLEN
	 
	 lea dx,win8
	 mov ah,9
	 int 21h
	
	mov ah,1
	int 21h
	
	cmp al,65h
	je EXIT
	
	dec cx
	cmp cx,0
	jne LOOPINPUT
	pop ax
	pop bx
	pop dx
	pop cx
	 

ret
INPUT ENDP

OUTPUT PROC
    push dx
	push cx
	push bx
	
	lea dx,win9
	mov ah,9
	int 21h
	
	lea dx,BUF4
	mov ah,10
	int 21h
	        
			
			
LOOPCHECK:	
            mov bx,offset STUDENTS
            mov cx,N
 	        mov AX,N
            sub AX,cx
            imul ax,16
            add bx,ax
   compare [bx].ID,BUF4,length
            loop LOOPCHECK
	
PRINT:
      lea dx,win10
      mov ah,9
	  int 21h
	  lea dx,[bx].score
	  mov ah,9
	  int 21h
	  lea dx,win11
	  mov ah,9
	  int 21h
	  lea dx,[bx].rank
	  mov ah,9
	  int 21h
	  	

NOTFOUND:lea dx,win12
         mov ah,9
		 int 21h
		 
ret
OUTPUT ENDP




CODE ENDS 
END
 
