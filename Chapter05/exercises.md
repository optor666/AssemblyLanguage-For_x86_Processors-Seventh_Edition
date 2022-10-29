# 5.1
## 5.1.3
1. 哪个寄存器（32 位模式中）管理堆栈？答：ESP。
2. 运行时堆栈与堆栈抽象数据类型有什么不同？答：运行时堆栈工作在系统层，处理子程序调用；堆栈抽象数据类型实现基于后进先出操作的算法。
3. 为什么堆栈被称为 LIFO 结构？答：后进先出。
4. 当一个 32 位数值压入堆栈时，ESP 发生了什么变化？答：ESP 的值先减 4，然后把 32 位数值存入 ESP 值指向的内存单元。
5. （真/假）：过程中的局部变量是在堆栈中新建的。答：真。
6. （真/假）：PUSH 指令不能用立即数作操作数。答：假
# 5.2
## 5.2.7
1. （真/假）：PROC 伪指令标识过程的开始，ENDP 伪指令标识过程的结束。答：真。
2. （真/假）：可以在现有过程中定义一个过程。答：假，MASM 不允许定义嵌套过程。
3. 如果在过程中省略 RET 指令会发生什么情况？答：会从代码段按顺序继续取指令执行。
4. 在建议的过程说明中，如何使用名称 Receives 和 Returns？答：Receives、Returns 分别标识输入参数和输出参数。
5. （真/假）：CALL 指令把自身指令的偏移量压入堆栈。答：假，应该是把自身指令的下一条指令的偏移量压入堆栈。
6. （真/假）：CALL 指令把紧跟其后的指令的偏移量压入堆栈。答：真。
# 5.3
## 5.3.2
1. （真/假）：链接库由汇编语言源代码组成。答：假，机器语言代码组成。
2. 在一个外部链接库中，用 PROTO 伪指令声明过程 MyProc。答：对。
3. 编写 CALL 语句调用外部链接库中的过程 MyProc。答：call MyProc
4. 本书支持的 32 位链接库的名称是什么？答：Irvine32.lib。
5. kernel32.dll 是什么类型的文件？答：动态链接库。
# 5.4
## 5.4.5
1. 链接库中的哪个过程在指定范围内生成随机整数？答：RandomRange。
2. 链接库中的哪个过程显示”Press [Enter] to continue...“ 并等待用户按下 Enter 键？答：WaitMsg。
3. 编写语句使程序暂停 700 毫秒。
``` asm
mov eax,700
call Dealy
```
4. 链接库中的哪个过程以十进制形式向控制台窗口输入无符号整数？答：WriteDec。
5. 链接库中的哪个过程将光标定位到控制台窗口的指定位置？答：Gotoxy。
6. 编写使用 Irvine32 链接库时所需的 INCLUDE 伪指令。答：include Irvine32.inc。
7. Irvine32.inc 文件中包含哪些类型的语句？答：include 语句、子过程原型声明语句、常量定义语句。
8. DumpMem 过程需要哪些输入参数？答：ESI 中存放内存区域首地址、ECX 中存放单元个数、EBX 中存放单元大小。
9. ReadString 过程需要哪些输入参数？答：EDX 中存放缓冲区偏移量、ECX 中存放能键入最大字符数加 1；EAX 中存放实际键入字符数。
10. DumpRegs 过程显示哪些处理器状态标志位？答：进位标志位、符号标志位、零标志位、溢出标志位、辅助标志位和奇偶标志位。
11. 挑战：编写语句提示用户输入标识号，并向字节数组输入一串数字。
``` asm
include Irvine32.inc

.data
LEN = 10
nums DWORD LEN DUP(?)
prompt BYTE "Enter a 32-bit unsigned integer: ",0

.code
main PROC
	mov esi,OFFSET nums
	mov ecx,LEN
	mov ebx,type nums
	call DumpMem

	L1: mov edx,OFFSET prompt
	call WriteString
	call ReadDec
	; // call Crlf
	mov [esi],eax
	add esi,type nums
	loop L1

	mov esi, OFFSET nums
	mov ecx, LEN
	mov ebx, type nums
	call DumpMem
		 
	call WaitMsg
main ENDP
END main
```
# 5.8
## 5.8.1
1. 哪条指令将全部的 32 位通用寄存器压入堆栈？答：PUSHAD。
2. 哪条指令将 32 位 EFLAGS 寄存器压入堆栈？答：PUSHFD。
3. 哪条指令将堆栈内容弹出到 EFLAGS 寄存器？答：POPFD。
4. 挑战：另一种汇编器（称为 NASM）允许 PUSH 指令列出多个指定寄存器。为什么这种方法可能会比 MASM 中的 PUSHAD 指令要好？下面是一个 NASM 示例：
``` asm
PUSH EAX EBX ECX
```
答：程序员使用更加方便。
5. 挑战：假设没有 PUSH 指令，另外编写两条指令来完成与 push eax 同样的操作。答：
``` asm
mov [ESP - 4],eax
sub esp,4
```
6. （真/假）：RET 指令将栈顶内容弹出到指令指针寄存器。答：真。
7. （真/假）：Microsoft 汇编器不允许过程嵌套调用，除非在过程定义中使用了 NESTED 运算符。答：假。
8. （真/假）：在保护模式下，每个过程调用最少使用 4 个字节的堆栈空间。答：对，用于保存返回地址。
9. （真/假）：向过程传递 32 位参数时，不能使用 ESI 和 EDI 寄存器。答：假，没听说过不能啊。
10. （真/假）：ArraySum 过程（5.2.5 节）接收一个指向任何一个双字数组的指针。答：真。
11. （真/假）：USERS 运算符能让程序员列出所有在过程中会被修改的寄存器。答：真。
12. （真/假）：USER 运算符只能产生 PUSH 指令，因为程序员必须自己编写代码完成 POP 指令功能。答：假。
13. （真/假）：用 USES 伪指令列出寄存器时，必须用逗号分割寄存器名。答：假，空格可以。
14. 修改 ArraySum 过程（5.2.5 节）中的哪些语句，使之能计算 16 位字数组的累计和？编写这个版本的 ArraySum 并进行测试。
``` asm

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
array WORD 100h, 200h, 300h, 400h, 500h
theSum DWORD ?

.code
main PROC
	mov esi, OFFSET array
	mov ecx, LENGTHOF array
	call ArraySum
	mov theSum, eax

	INVOKE ExitProcess, 0
main ENDP

; //--------------------------------------
; // ArraySum
; // 计算 16 位整数之和。
; // 接收：ESI=数组偏移量
; //      ECX=数组元素的个数
; // 返回：EAX=数组元素之和
; //--------------------------------------
ArraySum PROC USES esi ecx ebx
	mov eax,0

	L1: movsx ebx,WORD PTR [esi]
	add eax,ebx
	add esi,TYPE WORD
	loop L1

	ret
ArraySum ENDP

END main
```
15. 执行下列指令后，EAX 的最后数值是多少？答：5。
``` asm
push 5
push 6
pop eax
pop eax
```
16. 运行如下示例代码时，下面哪个对执行情况的陈述是正确的？答：b
``` asm
main PROC
    push 10
    push 20
    call Ex2Sub
    pop eax
    INVOKE ExitProcess,0
main ENDP
Ex2Sub PROC
    pop eax
    ret
Ex2Sub ENDP
```
a. 到第 6 行代码，EAX 等于 10

b. 到第 10 行代码，程序将因运行时错误而暂停

c. 到第 6 行代码，EAX 将等于 20

d. 到第 11 行代码，程序将因运行时错误而暂停

17. 运行如下示例代码时，下面哪个对执行情况的陈述时正确的？答：d
``` asm
main PROC
    mov eax,30
    push eax
    push 40
    call Ex3Sub
    INVOKE ExitProcess,0
main ENDP
Ex3Sub PROC
    pusha
    mov eax,80
    popa
    ret
Ex3Sub ENDP
```
a. 到第 6 行代码，EAX 等于 40

b. 到第 6  行代码，程序将因运行时错误而暂停

c. 到第 6 行代码，EAX 将等于 30

d. 到第 13 行代码，程序将因运行时错误而暂停

18. 运行如下示例代码时，下面哪个对执行情况的陈述是正确的？答：a
``` asm
main PROC
    mov eax,40
    push offset Here
    jmp Ex4Sub
    Here: 
    mov eax,30
    INVOKE ExitProcess,0
main ENDP

Ex4Sub PROC
    ret
Ex4Sub ENDP
```
a. 到第 7 行代码，EAX 将等于 30

b. 到第 4 行代码，程序将因运行时错误而暂停

c. 到第 6 行代码，EAX 将等于 30

d. 到第 11 行代码，程序将因运行时错误而暂停

19. 运行如下示例代码时，下面哪个对执行情况的陈述是正确的？答：都不正确。
``` asm
main PROC
    mov edx,0
    mov eax,40
    push eax
    call Ex5Sub
    INVOKE ExitProcess,0
main ENDP
 
Ex5Sub PROC
    pop eax ; 返回地址
    pop edx ; 40
    push eax ; 返回地址
    ret
Ex5Sub ENDP
```
a. 到第 6 行代码，EAX 将等于 40

b. 到第 13 行代码，程序将因运行时错误而暂停

c. 到第 6 行代码，EAX 将等于 0

d. 到第 11 行代码，程序将因运行时错误而暂停

20. 执行下述代码时，哪些数值将被写入数组？答：10、20、30、40。
``` asm
.data
array DWORD 4 DUP(0)
.code
main PROC
    mov eax,10
    mov esi,0
    call proc_1
    add esi,4
    add eax,10
    mov array[esi],eax ; 10,20,30,0
    INVOKE ExitProcess,0
main ENDP
 
proc_1 PROC
    call proc_2 ; 10,20,0,0
    add esi,4
    add eax,10
    mov array[esi],eax
    ret
proc_1 ENDP
 
proc_2 PROC
    call proc_3 ; 10,0,0,0
    add esi,4 
    add eax,10
    mov array[esi],eax
    ret
proc_2 ENDP
 
proc_3 PROC
    mov array[esi],eax
    ret
proc_3 ENDP
```
## 5.8.2
1. 编写一组语句，使用 PUSH 和 POP 指令来交换 EAX 和 EBX 寄存器（或 64 位的 RAX 和 RBX）中的值。
``` asm
 .386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
array DWORD 4 DUP(0)
.code
main PROC
	mov eax,10
	mov ebx,20
	push eax
	push ebx
	pop eax
	pop ebx
	INVOKE ExitProcess, 0
main ENDP

END main
```
2. 假设需要一个子程序的返回地址在内存中比当前堆栈中的返回地址高 3 个字节。编写一组指令放在该子程序 RET 指令之前，以完成这个任务。
``` asm
sub esp,3
```
3. 高级语言的函数通常在堆栈中的返回地址下，立刻声明局部变量。在汇编语言子程序开端编写一条指令来保留两个双字变量的空间。然后，对这两个局部变量分别赋值 1000h 和 2000h。
``` asm
.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
array DWORD 4 DUP(0)
.code
main PROC
	call func
	INVOKE ExitProcess, 0
main ENDP

func PROC
	push ebp
	mov ebp,esp
	sub esp,(type dword) * 2
	mov dword ptr [ebp - type dword],1000h
	mov dword ptr [ebp - (type dword) * 2], 2000h

	add esp,(type dword) * 2
	pop ebp
	ret
func ENDP

END main
```
4. 编写一组语句，用变址寻址方式将双字数组中的元素复制到同一数组中其前面的一个位置上。
``` asm
.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
array DWORD 1000h,2000h,3000h,4000h,5000h
.code
main PROC
	mov edi,0
	mov esi,type dword
	mov ecx,lengthof array - 1

	L1: mov eax,array[esi]
	mov array[edi],eax
	add edi,type dword
	add esi,type dword
	loop L1

	INVOKE ExitProcess,0
main ENDP

END main
```
5. 编写一组语句显示子程序的返回地址。注意，不论如何修改堆栈，都不能阻止子程序返回到调用程序。
``` asm
include Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
array DWORD 1000h,2000h,3000h,4000h,5000h
.code
main PROC
	call func
	L1: mov eax,offset L1
	call WriteHex
	call Crlf
	INVOKE ExitProcess,0
main ENDP

func PROC
	pop eax
	push eax
	call WriteHex 
	call Crlf
	ret
func ENDP

END main
```
# 5.9
1. 用循环结构，编写程序用四种颜色显示同一字符串。调用本书链接库的 SetTextColor 过程。可以选择任意颜色，但你会发现改变前景色是最简单的。
``` asm
include Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
hello byte "hello, world",0
backgroundcolor = black
frontendcolors dword red,blue,green,yellow,white

.code
main PROC
	mov ecx,lengthof frontendcolors
	mov esi,0
	L1: mov eax,(backgroundcolor * 16) + frontendcolors[esi]
	call SetTextColor
	mov edx, offset hello
	call WriteString
	call Crlf
	add esi,type frontendcolors
	loop L1
	INVOKE ExitProcess,0
main ENDP

func PROC
	pop eax
	push eax
	call WriteHex 
	call Crlf
	ret
func ENDP

END main
```
2. 假设给定的 3 个数据项分别代表一个表、一个字符数组以及一个链接索引数组的起始变址。编写程序遍历链接，并按正确顺序定位字符。将被定位的每个字符都复制到一个新数组中。假设使用如下示例数据，且各数组都从 0 开始变址：
``` asm
start = 1
chars: H A C E B D F G
links: 0 4 5 6 2 3 7 0
```
复制到输出数组的数值（依次）为 A、B、C、D、E、F、G、H。字符数组声明为 BYTE 类型，为了使问题更加有趣，将链表数组声明为 DWORD 类型。
``` asm
include Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
start = 1
chars byte "HACEBDFG"
links byte 0,4,5,6,2,3,7,0
output byte (lengthof chars + 1) dup(0)

.code
main PROC
	mov ecx,lengthof links
	mov esi,start
	mov edi,0

	L1: mov al,chars[esi]
	mov output[edi],al
	add edi,type output
	movzx esi,links[esi]
	loop L1

	mov edx,offset output
	call WriteString
	INVOKE ExitProcess,0
main ENDP

func PROC
	pop eax
	push eax
	call WriteHex 
	call Crlf
	ret
func ENDP

END main
```
3. 编写程序：清屏，将鼠标定位到屏幕中心附近，提示用户输入两个整数，两数相加，并显示和数。
``` asm
include Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
rows byte 0
cols byte 0
prompt byte 'Please input a number: ',0
val1 sdword ?
val2 sdword ?

.code
main PROC
	call Clrscr
	call GetMaxXY ; al 行数、dl 列数

	mov bl,2

	movzx eax,al
	div bl
	mov rows,al
	
	movzx eax, dl
	div bl
	mov cols,al
	
	mov dh,rows
	mov dl,cols
	call Gotoxy

	mov edx,offset prompt
	call WriteString

	call ReadInt
	mov val1,eax

	mov edx, offset prompt
	call WriteString

	call ReadInt
	mov val2, eax

	mov eax,0
	add eax,val1
	add eax,val2
	call WriteInt
	call Crlf


	INVOKE ExitProcess,0
main ENDP

END main
```
4. 以前一题编写的程序为起点，在新程序中，用循环结构将上述同样的步骤重复 3 次。每次循环迭代后清屏。
``` asm
include Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
rows byte 0
cols byte 0
prompt byte 'Please input a number: ',0
val1 sdword ?
val2 sdword ?

.code
main PROC
	mov ecx,3
	L1: call sum
	loop L1
	INVOKE ExitProcess,0
main ENDP

sum PROC
	call Clrscr
	call GetMaxXY; al 行数、dl 列数

	mov bl, 2

	movzx eax, al
	div bl
	mov rows, al

	movzx eax, dl
	div bl
	mov cols, al

	mov dh, rows
	mov dl, cols
	call Gotoxy

	mov edx, offset prompt
	call WriteString

	call ReadInt
	mov val1, eax

	mov edx, offset prompt
	call WriteString

	call ReadInt
	mov val2, eax

	mov eax, 0
	add eax, val1
	add eax, val2
	call WriteInt
	call Crlf
	call WaitMsg
	ret
sum ENDP

END main
```
5. BetterRandomRange 过程
``` asm
include Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data

.code
main PROC
	mov ecx,50

	L1: mov ebx,-300
	mov eax,100
	call BetterRandomRange
	loop L1
	call WaitMsg
	INVOKE ExitProcess,0
main ENDP

BetterRandomRange PROC
	mov edx,eax
	sub edx,ebx
	mov eax,edx
	call RandomRange
	add eax,ebx
	call WriteInt
	call Crlf
	ret
BetterRandomRange ENDP

END main
```
6. 随机字符串
``` asm
include Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
L = 10
string byte L + 1 dup(0)

.code
main PROC
	mov ecx,20

	L1: mov eax,L
	call RandomString
	mov edx,offset string
	call WriteString
	call Crlf
	loop L1
	call WaitMsg
	INVOKE ExitProcess,0
main ENDP

RandomString PROC uses ecx
	mov ecx,eax
	mov eax,26
	mov esi,0

	L1: mov eax,26
	call RandomRange
	add eax,'A'
	mov string[esi],al
	inc esi
	loop L1

	ret
RandomString ENDP

END main
```
7. 随机屏幕位置
``` asm
include Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
rows byte ?
cols byte ?
character byte 'B'

.code
main PROC
	mov ecx,10

	call GetMaxXY
	mov rows,al
	mov cols,dl

	mov bl, 1

	L1: 
	movzx eax,cols
	call RandomRange
	inc eax

	mov dh,bl
	mov dl,al
	call Gotoxy

	mov al,character
	call WriteChar

	inc bl
 	mov eax,1000
	call Delay
	loop L1

	call Crlf
	call WaitMsg
	INVOKE ExitProcess,0
main ENDP

END main
```
8. 颜色矩阵
``` asm
include Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
	hello byte "hello, world",0
	defaultColor byte ?

.code
main PROC
	call GetTextColor
	mov defaultColor,al

	mov ecx, 16

	mov esi,ecx 
	dec esi

	L1: push ecx
	mov ecx,16
	mov edi,ecx
	dec edi

	L2: mov eax,edi
	shl eax,4
	add eax,esi
	call SetTextColor
	mov edx,offset hello
	call WriteString
	call Crlf
	dec edi
	mov eax,1000
	call Delay
	loop L2

	pop ecx
	dec esi
	loop L1

	movsx eax,defaultColor
	call SetTextColor
	call WaitMsg
	INVOKE ExitProcess, 0
main ENDP

END main
```
9. 递归过程
``` asm
include Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
	hello byte ". hello, world",0
	defaultColor byte ?

.code
main PROC
	mov ecx,10
	call recursion
	
	call WaitMsg
	INVOKE ExitProcess, 0
main ENDP

recursion PROC
	L1:
	mov eax,ecx
	call WriteInt
	mov edx, offset hello
	call WriteString
	call Crlf

	loop L1

	ret
recursion ENDP

END main
```
10. 斐波那契数列生成器
``` asm
include Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
	LEN = 47
	data dword LEN dup(0)

.code
main PROC
	call Fibonacci
	
	call WaitMsg
	INVOKE ExitProcess, 0
main ENDP

Fibonacci PROC
	mov ecx,LEN - 2
	mov esi,0
	mov data[esi],1
	add esi,type data
	mov data[esi],1

	add esi,type data
	mov edi,esi
	mov esi,0
	mov ebx,esi
	add ebx,type data

	L1:
	mov eax,data[esi]
	add eax,data[ebx]
	mov data[edi],eax
	add esi,type data
	add ebx,type data
	add edi,type data

	loop L1

	ret
Fibonacci ENDP

END main
```
11. 找出 K 倍数
``` asm
include Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
	N = 20
	K = 2
	data byte N dup(0)

.code
main PROC
	call MutiK
	
	call WaitMsg
	INVOKE ExitProcess, 0
main ENDP

MutiK PROC 
	mov edx,0
	mov eax,N
	mov ecx,K
	div cx

	mov ecx,eax
	mov esi,0
	
	L1:
	add esi,K
	mov data[esi],1
	loop L1

	ret
MutiK ENDP

END main
```
