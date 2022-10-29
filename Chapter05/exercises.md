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
