; 链接库测试 #2 TestLib2.asm
; 测试 Irvine32 链接库的过程。
include Irvine32.inc

TAB = 9

.code
main PROC
	call Randomize 
	call Rand1
	call Rand2
	exit
main ENDP

Rand1 PROC
	; 生成 10 个伪随机数
	mov ecx,10
L1: call Random32
	call WriteDec
	mov al,TAB
	call WriteChar
	loop L1

	call Crlf
	ret
Rand1 ENDP

Rand2 PROC
	; 在 -50 到 +49 之间生成 10 个伪随机整数
	mov ecx,10
L1: mov eax,100
	call RandomRange
	sub eax,50
	call WriteInt
	mov al,TAB
	call WriteChar
	loop L1

	call Crlf
	ret
Rand2 ENDP
END main
