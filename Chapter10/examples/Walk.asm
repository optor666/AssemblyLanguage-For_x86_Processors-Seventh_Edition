;// 醉汉行走 （Walk.asm）
;// 醉汉行走程序。教授的起点坐标位 （25，25），并在周围徘徊。
INCLUDE Irvine32.inc
WalkMax = 50
StartX = 25
StartY = 25

DrunkardWalk STRUCT
	path COORD WalkMax DUP(<0,0>)
	pathsUsed WORD 0
DrunkardWalk ENDS

DisplayPosition PROTO currX:WORD, currY:WORD

.data
aWalk DrunkardWalk <>

.code
main PROC
	mov esi,OFFSET aWalk
	call TakeDrunkenWalk
	exit
main ENDP

;//-------------------------------------------------
TakeDrunkenWalk PROC
	LOCAL currX:WORD, currY:WORD
;//
;// 向随机方向走（北、南、东、西）
;// 接收：ESI 为 DrunkardWalk 结构的指针
;// 返回：结构初始化为随机数
;//-------------------------------------------------
	pushad
;// 用 OFFSET 运算符获取 path---COORD 对象数组---的地址，并将其复制到 EDI。
	mov edi,esi
	add edi,OFFSET DrunkardWalk.path
	mov ecx,WalkMax
	mov currX,StartX
	mov currY,StartY

Again:
	;// 把当前位置插入数组
	mov ax,currX
	mov (COORD PTR[edi]).X,ax
	mov ax,currY
	mov (COORD PTR[edi]).Y,ax
	
	INVOKE DisplayPosition, currX, currY
	mov eax,4
	call RandomRange

	.IF eax == 0
		dec currY
	.ELSEIF eax == 1
		inc currY
	.ELSEIF eax == 2
		dec currX
	.ELSE
		inc currX
	.ENDIF

	add edi,TYPE COORD
	loop Again

Finish:
	mov (DrunkardWalk PTR [esi]).pathsUsed, WalkMax
	popad
	ret
TakeDrunkenWalk ENDP

;//----------------------------------------------------
DisplayPosition PROC currX:WORD, currY:WORD
;// 显示当前 X 和 Y 的位置
;//----------------------------------------------------
.data
commaStr BYTE ",",0
.code
	pushad
	movzx eax,currX
	call WriteDec
	mov edx,OFFSET commaStr
	call WriteString
	movzx eax,currY
	call WriteDec
	call Crlf
	popad	
	ret
DisplayPosition ENDP
END main 
