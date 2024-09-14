# 10.1
## 10.1.8
问题 1-9 参考如下结构：
 ``` asm
 MyStruct STRUCT
  field1 WORD ?
  field2 DWORD 20 DUP(?)
MyStruct ENDS
```

1. 用默认值声明变量 MyStruct。
``` asm
myStruct MyStruct <>
```
2. 声明变量 MyStruct，将第一个字段初始化为 0。
``` asm
myStruct MyStruct <0>
```
3. 声明变量 MyStruct，将第二个字段初始化为全零数组。
``` asm
myStruct MyStruct <,20 DUP(0)>
```
4. 一数组包含 20 个 MyStruct 对象，将该数组声明为变量。
``` asm
myStructs MyStruct 20 DUP(<>)
```
5. 对上一题的 MyStruct 数组，把第一个数组元素的 field1 送入 AX。
``` asm
mov edi,0
mov ax, (MyStruct PTR myStructs[edi]).field1
```
6. 对上一题的 MyStruct 数组，用 ESI 索引第 3 个数组元素，并将 AX 送入 field1。提示：使用 PTR 运算符。
``` asm
mov esi,2
mov (MyStruct PTR myStructs[esi]).field1,ax
```
7. 表达式 TYPE MyStruct 的返回值是多少？答：6
8. 表达式 SIZEOF MyStruct 的返回值是多少？答：6
9. 编写一个表达式，返回 MyStruct 中 field2 的字节数。
``` asm
mov eax,TYPE MyStruct.field2
``` 

# 10.2
## 10.2.7
1. （真/假）：当一个宏被调用时，CALL 和 RET 指令将自动插入到汇编程序中。答：假
2. （真/假）：宏展开由汇编器的预处理程序控制。答：真
3. 与不使用参数的宏相比，使用参数的宏有哪些主要优势？答：功能更强、扩展性更强
4. （真/假）：只要宏定义在代码段中，它就既能出现在宏调用语句之前，也能出现在宏调用语句之后。答：假
5. （真/假）：对一个长过程而言，若用包含这个过程代码的宏来代替它，则多次调用该宏通常就会增加程序的编译代码量。答：真
6. （真/假）：宏不能包含数据定义。答：假

# 10.3
## 10.3.9
1. IFB 伪指令的作用是什么？答：IFB <argument>，若 argument 为空则允许汇编。实参名必须用尖括号（<>）括起来。
2. IFIDN 伪指令的作用是什么？答：IFIDN <arg1>,<arg2>，若两个实参相等（相同）则允许汇编。采用区分大小写的比较。
3. 哪条伪指令能停止所有后续的宏展开？答：EXITM，该伪指令立即退出宏，阻止所有后续宏语句的展开。
4. IFIDNI 与 IFIDN 有什么不同？答：IFIDN <arg1>,<arg2>，若两个实参相等（相同）则允许汇编。采用区分大小写的比较。IFIDNI 采用不区分大小写的比较。
5. IFDEF 伪指令的作用是什么？答：IFDEF name，若 name 已定义则允许汇编。

# 10.4
## 10.4.6
1. 简要说明 WHILE 伪指令；答案：WHILE 伪指令重复一个语句块，直到特定的常量表达式为真。
2. 简要说明 REPEAT 伪指令；答案：REPEAT 伪指令将一个语句块重复固定次数。
3. 简要说明 FOR 伪指令；答案：FOR 伪指令通过迭代用逗号分隔的符号列表来重复一个语句块。
4. 简要说明 FORC 伪指令；答案：FORC 伪指令通过迭代字符串来重复一个语句块。
5. 哪条伪指令最适合生成字符查找表？答案：FORC。
6. 写出由下述宏生成的语句：
``` asm
FOR val,<100,20,30>
 BYTE 0,0,0,val
ENDM
```
答案：
``` asm
BYTE 0,0,0,100
BYTE 0,0,0,20
BYTE 0,0,0,30
```

7. 设已定义如下宏 mRepeat:
``` asm
mRepeat MACRO char,count
 LOCAL L1
 mov cx,count
L1: mov ah,2
 mov dl,char
 int 21h
 loop L1
ENDM
```
当按照下列语句（a，b 和 c）进行 mRepeat 宏展开时，请写出预处理程序生成的代码：
``` asm
mRepeat 'X',50 ; a
```
答案：
``` asn

``` asm
mRepeat AL,20 ; b
```
答案：
``` asm
mRepeat byteVal,countVal ; c
```
答案：

8. 挑战：在链表示例程序（10.4.5 节）中，如果 REPEAT 循环的代码如下，那么程序运行结果如何？
``` asm
REPEAT TotalNodeCount
  Counter = Counter + 1
  ListNode <Counter, ($ + SIZEOF ListNode)>
ENDM
```
答案：第二个节点的 next 指针指向自己，形成环。

# 10.7
## 10.7.1
1. STRUCT 伪指令的用途是什么？答案：定义结构。
2. 假设定义了如下结构：
``` asm
RentalInvoice STRUCT
 invoiceNum BYTE 5 DUP(' ')
 dailyPrice WORD ?
  daysRented WORD ?
RentalInvoice ENDS
```
则下列声明是否有效：
a. rentals RentalInvoice<>

b. RentalInvoice rentals <>

c. march RentalInvoice <'12345',10,0>

d. RentalInvoice <,10,0>

e. current RentalInvoice <,15,0,0>

答案：a 有效、b 无效、c 有效、d 无效、e 无效

3. （真/假）：宏不能包含数据定义。答：假。
4. LOCAL 伪指令的用途是什么？答：宏定义中常常包含了标号，并会在其代码中对这些标号进行自引用。为了避免标号重命名带来的问题，可以对一个宏定义内的标号使用 LOCAL 伪指令。若标号被标记为 LOCAL，那么每次进行宏展开时，预处理程序就把标号名转换为唯一的标识符。
5. 哪条伪指令能在控制台上显示汇编时消息？答：ECHO。
6. 哪条伪指令标志条件语句块的结束？答：ENDIF。
7. 列出所有能在常量布尔表达式中使用的关系运算符。答：
8. 宏定义中的 & 运算符有什么作用？答：替换运算符 & 解析对宏参数名的有歧义的引用。
9. 宏定义中的 ! 运算符有什么作用？答：构造文字字符 ! 的目的与文字文本运算符的几乎完全一致：强制预处理程序把预先定义的运算符当作普通的字符。
10. 宏定义中的 % 运算符有什么作用？答：展开运算符 % 展开文本宏并将常量表达式转换为文本形式。

## 10.7.2
1. 创建包含两个字段的结构 SampleStruct: field1 为一个 16 位 WORD，field2 为含有 20 个 32 位 DWORD 的数组。不需定义字段初始值。答：
``` asm
field1 WORD ?
field2 DWORD 20 DUP(?)
```
2. 编写一条语句检索结构 SYSTEMTIME 的 wHour 字段。答：
``` asm
mov ax, [YourSystemTimeVariable].wHour
```
3. 使用如下 Triangle 结构，声明一个结构变量并将其三个顶点分别初始化为 (0, 0)、(5, 0) 和 (7, 6)：
``` asm
Triangle STRUCT
 Vertex1 COORD <>
 Vertex2 COORD <>
 Vertex3 COORD <>
Triangle ENDS
```
答：
``` asm
triangle Triangle <<0,0>, <5,0> <7,6>>
```
4. 声明一个 Triangle 结构的数组，并编写一个循环，用随机坐标对每个三角形的 Vertex1 进行初始化，坐标范围为 (0...10, 0...10)。
``` asm
INCLUDE Irvine32.inc

Triangle STRUCT
	Vertex1 COORD <>
	Vertex2 COORD <>
	Vertex3 COORD <>
Triangle ENDS

.data
triangleArray Triangle 3 DUP({})
coordMin DWORD 0
coordMax DWORD 10

prompt BYTE "第 ",0
vertexPrompt BYTE " 个顶点坐标为：(",0
comma BYTE ", ",0
prompt2 BYTE ")", 0

.code
main PROC
	mov ecx, LENGTHOF triangleArray
	mov esi, OFFSET triangleArray

	call Randomize

initLoop:
	mov eax, coordMax
	inc eax
	call RandomRange
	mov [esi].Triangle.Vertex1.X, ax

	mov eax, coordMax
	inc eax
	call RandomRange
	mov[esi].Triangle.Vertex1.Y, ax

	add esi, SIZEOF Triangle
	loop initLoop

	mov ecx, LENGTHOF triangleArray
	mov esi, OFFSET triangleArray

outputLoop:
	mov edx, offset prompt
	call WriteString
	mov eax, LENGTHOF triangleArray
	sub eax, ecx
	inc eax
	call WriteDec
	mov edx, offset vertexPrompt
	call WriteString

	mov ax, [esi].Triangle.Vertex1.X
	call WriteDec
	mov edx, offset comma
	call WriteString
	
	mov ax, [esi].Triangle.Vertex1.Y
	call WriteDec

	mov edx, offset prompt2
	call WriteString
	call Crlf

	add esi, SIZEOF Triangle
	loop outputLoop

	exit
main ENDP
END main
```
5. 编写宏 mPrintChar，在屏幕上显示一个字符。宏应有两个参数：第一个指定显示的字符，第二个指定字符重复的次数。示例调用如下：
``` asm
mPrintChar 'X', 20
```
答：
``` asm
INCLUDE Irvine32.inc

mPrintChar MACRO charToPrint:REQ, count:REQ
	LOCAL loopLabel

	mov ecx, count
	mov al, charToPrint
loopLabel:
	call WriteChar
	loop loopLabel
ENDM

.data
charToPrint BYTE 'A'
repeatTimes DWORD 3

.code
main PROC
	mPrintChar charToPrint, repeatTimes

	exit
main ENDP
END main
```
6. 编写宏 mGenRandom，在 0 到 n-1 之间随机生成一个整数，n 为宏的唯一参数。答：
``` asm
INCLUDE Irvine32.inc

mGenRandom MACRO n:REQ
	mov eax, n
	call RandomRange
ENDM

.data

.code
main PROC
	mov ecx, 100
L1:
	mGenRandom 10
	call WriteDec
	call Crlf
	loop L1

	exit
main ENDP
END main
```
7. 编写宏 mPromptInteger，显示提示并接收用户输入的一个整数。向该宏传递一个字符串文本和一个双字变量名。示例调用如下：
``` asm
.data
minVal DWORD ?
.code
mPromptInteger "Enter the minimum value", minVal
```
答：
``` asm
INCLUDE Irvine32.inc

mPromptInteger MACRO prompt:REQ, intVariable:REQ
LOCAL promptText
.data
promptText BYTE prompt,0

.code
	mov edx, OFFSET promptText
	call WriteString
	mov ebx, OFFSET intVariable
	call ReadInt
	mov [ebx], eax
ENDM

.data
minVal DWORD ?

.code
main PROC
	mPromptInteger "Enter the minimum value: ", minVal
	mov eax, minVal
	call WriteInt
	call Crlf
	exit
main ENDP
END main
```
8. 编写宏 mWriteAt，定位光标并在控制台窗口显示一个字符串文本。建议：调用本书宏库中的 mGoto 和 mWrite。答：
``` asm
INCLUDE Irvine32.inc
INCLUDE Macros.inc

mWriteAt MACRO row:REQ, col:REQ, text:REQ
	mGotoxy row,col
	mWrite text
ENDM

.data

.code
main PROC
	mWriteAt 3, 3, "Hello, World!"
	mWriteAt 6, 6, "你好，世界！"
	exit
main ENDP
END main
```
9. 用如下语句调用 10.2.5 节的宏 mWriteString，请写出其生成的展开代码：
``` asm
mWriteString namePrompt
```
``` asm
push edx
mov  edx,OFFSET namePrompt
call WriteString
pop  edx
```
10. 用如下语句调用 10.2.5 节的宏 mReadString，请写出其生成的展开代码：
``` asm
mReadString customerName
```
``` asm
push ecx
push edx
mov  edx,OFFSET customerName
mov  ecx,SIZEOF customerName
call ReadString
pop  edx
pop ecx
```
11. 编写宏 mDumpMemx，接收一个参数和一个变量名。该宏必须调用本书链接库的宏 mDumpMem，并向其传递变量的偏移量，存储对象的数量和对象的大小。演示对宏 mDumpMemx 的调用。
``` asm
INCLUDE Irvine32.inc
INCLUDE Macros.inc

myDump MACRO varName : REQ, useLabel
	call Crlf
	IFNB <useLabel>
		mWrite "Variable name: &varName"
	ELSE
		mWrite " "
	ENDIF
	mDumpMem OFFSET varName, LENGTHOF varName, TYPE varName
ENDM

.data
diskSize DWORD 123456H

.code
main PROC
	
	myDump diskSize, T

exit
main ENDP
END main
```
12. 举例说明有默认实参初始值的宏形参。
``` asm
INCLUDE Irvine32.inc
INCLUDE Macros.inc

myPrintNumber MACRO number:=<100>
	call Crlf
	mov eax, number
	call WriteInt
ENDM

.data

.code
main PROC
	
	myPrintNumber 200
	myPrintNumber

exit
main ENDP
END main
```
13. 编写一个简短的例子来使用 IF、ELSE 和 ENDIF 伪指令。
``` asm
INCLUDE Irvine32.inc
INCLUDE Macros.inc

; ------------------------------------------
mGotoxyConst MACRO X:REQ, Y:REQ
;
; 将光标位置设置在 X 列 Y 行。
; 要求 X 和 Y 的坐标为常量表达式
; 其范围为 0 <= X < 80, 0 <= Y < 25
; ------------------------------------------
	LOCAL ERRS
	ERRS = 0
	IF (X LT 0) OR (X GT 79)
		ECHO Warning: First argument to mGotoxy (X) is out of range.
		ECHO *******************************************************
		ERRS = 1
	ENDIF
	IF(Y LT 0) OR(Y GT 24)
		ECHO Warning : Second argument to mGotoxy (Y) is out of range.
		ECHO * ******************************************************
		ERRS = ERRS + 1
	ENDIF
	IF ERRS GT 0
		EXITM
	ENDIF
	push edx
	mov dh,Y
	mov dl,X
	call Gotoxy
	pop edx
ENDM

.data
prompt BYTE "Enter your name: ",0

.code

main PROC
	mGotoxyConst 8, 2
	mov edx, OFFSET prompt
	call WriteString
exit
main ENDP
END main
```
