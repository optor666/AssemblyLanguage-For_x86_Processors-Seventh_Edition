; 链接库测试 #3 (TestLib3.asm)
; 计算嵌套循环的执行时间
include Irvine32.inc

.data
OUTER_LOOP_COUNT = 3
startTime DWORD ?
msg1 byte "Please wait...",0dh,0ah,0
msg2 byte "Elapsed milliseconds: ",0

.code
main PROC
	mov edx,OFFSET msg1
	call WriteString
	; 保存开始时间
	call GetMSeconds
	mov startTime,eax
	; 开始外层循环
	mov ecx,OUTER_LOOP_COUNT
L1: call innerLoop
	loop L1
	; 计算执行时间
	call GetMSeconds
	sub eax,startTime
	; 显示执行时间
	mov edx,OFFSET msg2
	call WriteString
	call WriteDec
	call Crlf

	exit
main ENDP

innerLoop PROC
	push ecx
	
	mov ecx,0FFFFFFFh
L1: mul eax
	mul eax
	mul eax
	loop L1
	
	pop ecx
	ret
innerLoop ENDP
END main
