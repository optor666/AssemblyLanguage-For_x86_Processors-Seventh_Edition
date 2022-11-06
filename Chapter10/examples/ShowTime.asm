;// 结构 (ShowTime.asm)
INCLUDE Irvine32.inc
.data
sysTime SYSTEMTIME <>
XYPos COORD <10,5>
consoleHandle DWORD ?
colonStr BYTE ":",0

.code
main PROC
;// 获取 Win32 控制台的标准输出句柄
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleHandle,eax
;// 设置光标位置并获取系统时间
	INVOKE SetConsoleCursorPosition, consoleHandle, XYPos
	INVOKE GetLocalTime, ADDR sysTime
;// 显示系统时间（小时：分钟：秒）
	movzx eax,sysTime.wHour
	call WriteDec
	mov edx,OFFSET colonStr
	call WriteString
	movzx eax,sysTime.wMinute
	call WriteDec
	call WriteString
	movzx eax,sysTime.wSecond
	call WriteDec
	call Crlf
	call WaitMsg
	exit
main ENDP
END main
