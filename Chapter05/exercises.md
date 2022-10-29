# 5.1
## 5.1.3
1. 哪个寄存器（32 位模式中）管理堆栈？答：ESP。
2. 运行时堆栈与堆栈抽象数据类型有什么不同？答：运行时堆栈工作在系统层，处理子程序调用；堆栈抽象数据类型实现基于后进先出操作的算法。
3. 为什么堆栈被称为 LIFO 结构？答：后进先出。
4. 当一个 32 位数值压入堆栈时，ESP 发生了什么变化？答：ESP 的值先减 4，然后把 32 位数值存入 ESP 值指向的内存单元。
5. （真/假）：过程中的局部变量是在堆栈中新建的。答：真。
6. （真/假）：PUSH 指令不能用立即数作操作数。答：假
## 5.2.7
1. （真/假）：PROC 伪指令标识过程的开始，ENDP 伪指令标识过程的结束。答：真。
2. （真/假）：可以在现有过程中定义一个过程。答：假，MASM 不允许定义嵌套过程。
3. 如果在过程中省略 RET 指令会发生什么情况？答：会从代码段按顺序继续取指令执行。
4. 在建议的过程说明中，如何使用名称 Receives 和 Returns？答：Receives、Returns 分别标识输入参数和输出参数。
5. （真/假）：CALL 指令把自身指令的偏移量压入堆栈。答：假，应该是把自身指令的下一条指令的偏移量压入堆栈。
6. （真/假）：CALL 指令把紧跟其后的指令的偏移量压入堆栈。答：真。
## 5.3.2
1. （真/假）：链接库由汇编语言源代码组成。答：假，机器语言代码组成。
2. 在一个外部链接库中，用 PROTO 伪指令声明过程 MyProc。答：对。
3. 编写 CALL 语句调用外部链接库中的过程 MyProc。答：call MyProc
4. 本书支持的 32 位链接库的名称是什么？答：Irvine32.lib。
5. kernel32.dll 是什么类型的文件？答：动态链接库。
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
