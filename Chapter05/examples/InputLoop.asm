; 库测试 #1：整数 I/O（InputLoop.asm）
; 测试 Clrscr, Crlf, DumpMem, ReadInt, SetTextColor,
;      WaitMsg, WriteBin, WriteHex 和 WriteString 过程。
include Irvine32.inc

.data
COUNT = 4
BlueTextOnGray = blue + (lightGray * 16)
DefaultColor = lightGray + (black * 16)
arrayD SDWORD 12345678h,1A4B2000h,3434h,7AB9h
prompt BYTE "Enter a 32-bit signed integer: ",0

.code
main PROC
	; 选择浅灰色背景蓝色文本
	mov eax,BlueTextOnGray
	call SetTextColor
	call Clrscr
	; 用 DumpMem 显示数组
	mov esi,OFFSET arrayD
	mov ebx,TYPE arrayD
	mov ecx,LENGTHOF arrayD
	call DumpMem
	; 请求用户输入一组有符号整数
	call Crlf
	mov ecx,COUNT
L1: mov edx,OFFSET prompt
	call WriteString
	call ReadInt
	call Crlf
	call WriteInt
	call Crlf
	call WriteHex
	call Crlf
	call WriteBin
	call Crlf
	call Crlf
	loop L1
	; 返回控制台窗口的默认颜色
	call WaitMsg
	mov eax,DefaultColor
	call SetTextColor
	call Clrscr

	exit
main ENDP
END main
