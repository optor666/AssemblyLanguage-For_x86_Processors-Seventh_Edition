; 数组循环（AllPoints.asm）
INCLUDE Irvine32.inc
NumPoints = 3
.data
ALIGN WORD
AllPoints COORD NumPoints DUP(<0,0>)

.code
main PROC
 	mov edi,0
	mov ecx,NumPoints
	mov ax,1

L1: mov (COORD PTR AllPoints[edi]).X,ax
	mov (COORD PTR AllPoints[edi]).Y,ax
	add edi,TYPE COORD
	inc ax
	loop L1
	exit
main ENDP
END main
