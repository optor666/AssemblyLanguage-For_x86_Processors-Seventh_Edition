;// 过程封装器宏 （Wraps.asm）
;// 本程序演示宏作为库过程的封装器。
;// 内容：mGotoxy、mWrite、mWriteString、mReadString 和 mDumpMem
INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data
array DWORD 1,2,3,4,5,6,7,8
firstName BYTE 31 DUP(?)
lastName BYTE 31 DUP(?)

.code
main PROC
	mGotoxy 0,0
	mWrite <"Sample Macro Program",0dh,0ah>
;// 输入用户名。
	mGotoxy 0,5
	mWrite "Please enter your first name: "
	mReadString firstName
	call Crlf

	mWrite "Please enter your last name: "
	mReadString lastName
	call Crlf
;// 显示用户名。
	mWrite "Your name is "
	mWriteString firstName
	mWriteSpace
	mWriteString lastName
	call Crlf
;// 显示整数数组
	mDumpMem OFFSET array, LENGTHOF array, TYPE array
	exit
main ENDP
END main
