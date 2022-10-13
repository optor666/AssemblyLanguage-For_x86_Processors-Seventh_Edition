; 字符串翻转	(RevStr.asm)
; 编译链接命令：ml .\RevStr.asm /link /SUBSYSTEM:CONSOLE /link /LIBPATH C:\Irvine\Kernel32.Lib /DEBUG
.386
.model flat,stdcall

.stack 4096

ExitProcess PROTO,dwExitCode:DWORD

.data
aName BYTE "Abraham Lincoln",0
nameSize = ($ - aName) - 1

.code
main PROC
; 将名字压入堆栈
	mov ecx,nameSize
	mov esi,0

L1: movzx eax,aName[esi]	; 获取字符
	push eax
	inc esi
	loop L1
; 将名字按逆序弹出堆栈，并存入 aName 数组
	mov ecx,nameSize
	mov esi,0

L2: pop eax	; 获取字符
	mov aName[esi],al	; 存入字符串
	inc esi
	loop L2

	INVOKE ExitProcess,0
main ENDP
END main
