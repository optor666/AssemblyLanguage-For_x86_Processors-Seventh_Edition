# 9.10
1. todo
2. todo
3. todo
4. todo
5. todo
6. 构建频率表：编写过程 Get_frequencies 构建一个字符频率表。需向过程输入字符串指针，以及一个数组指针，该数组包含 256 个双字，并已初始化为全 0。每个数组位置都由其对应字符的 ASCII 码进行索引。过程返回时，数组中的每一项包含的是对应字符在串中出现的次数。例如，
```
.data
target BYTE "AAEBDCFBBC",0
freqTable DWORD 256 DUP(0)
.code
INVOKE Get_frequencies, ADDR target, ADDR freqTable
```
```
INCLUDE Irvine32.inc

Print_freqTable PROTO,
source:PTR DWORD

Get_frequencies PROTO,
source:PTR BYTE,
target:PTR DWORD

Str_length PROTO,
pString:PTR BYTE         ;// pointer to string

.data
targetStr BYTE "AAEBDCFBBC", 0
freqTable DWORD 1,2,3,4,100,220,250 DUP(0)
promptBefore BYTE "处理前：", 0
promptAfter BYTE "处理后：", 0

.code
main PROC
  call Clrscr

  mov edx, OFFSET promptBefore
  call WriteString
  call Crlf
  INVOKE Print_freqTable, ADDR freqTable

  INVOKE Get_frequencies, ADDR targetStr, ADDR freqTable

  mov edx, OFFSET promptAfter
  call WriteString
  call Crlf
  INVOKE Print_freqTable, ADDR freqTable

  exit
main ENDP

Print_freqTable PROC USES eax ecx esi,
source: PTR DWORD

  mov ecx, 16
  mov esi, source
  L1: push ecx
  mov ecx, 16
  L2: mov eax, [esi]
  call WriteDec
  mov al, ' '
  call WriteChar
  add esi, TYPE DWORD
  loop L2
  call Crlf
  pop ecx
  loop L1

  ret
Print_freqTable ENDP

Get_frequencies PROC USES eax ebx ecx esi edi,
source:PTR BYTE,
target:PTR DWORD

  INVOKE Str_length, source
  mov ecx, eax
  mov esi, source
  mov bl, 4
  L1:
  mov eax, 0
  mov al, [esi]
  mul bl
  mov edi, target
  inc DWORD PTR[edi+eax]
  add esi, TYPE BYTE
  loop L1

  ret
Get_frequencies ENDP

END main
```
7. 厄拉多塞过滤算法：厄拉多塞（Eratosthenes）过滤算法，由同名的希腊数学家发明，提供了在给定范围内快速查找所有质数的方法。该算法创建一个字节数组，并按如下方式在“被标记”位置上插入 1：从位置 2（2是质数）开始，则数组中所有 2 的倍数的位置都插入 1。接着，对下一个质数 3，用同样的方法处理 3 的倍数。查找 3 之后的质数，该数为 5，再对所有 5 的倍数的位置进行标记。持续这种操作直到找出质数的全部倍数。那么，剩下数组中没有被标记的位置就表示其数为质数。编写程序，创建一个含有65 000 个元素的数组，并显示 2 到 65 000 之间的所有质数。要求，再未初始化数据段中声明该数组（参见 3.4.1 节），且使用 STOSB 把 0 填充到数组中。
```
INCLUDE Irvine32.inc

Eratosthenes PROTO,
table: PTR BYTE,
count: DWORD


Print_primeNumber PROTO,
table: PTR BYTE,
count: DWORD

.data
theCount = 65000
theTable BYTE theCount DUP(?)

.code
	main PROC
	call Clrscr
	
	INVOKE Eratosthenes,ADDR theTable,theCount
	INVOKE Print_primeNumber,ADDR theTable,theCount

	exit
main ENDP

Eratosthenes PROC USES eax ebx ecx edx esi edi,
	table: PTR BYTE,
	count : DWORD
	
	mov al, 0
	mov edi, table
	mov ecx, count
	cld
	rep stosb

	mov edi, table
	mov esi, 2
L1:
	mov ebx, 2
L2:
	mov eax, esi
	mul ebx
	cmp eax, Count
	ja L3
	mov BYTE PTR[edi + eax - 1], 1
	inc ebx
	jmp L2
L3:
	inc esi
	cmp esi, Count
	ja L4
	cmp BYTE PTR[edi + esi - 1], 1
	je L3
	jmp L1
L4:
	ret
Eratosthenes ENDP

Print_primeNumber PROC USES eax edi,
	table: PTR BYTE,
	count: DWORD

	mov edi,table
	mov eax,2
L1:
	cmp eax,count
	ja L3
	cmp BYTE PTR[edi + eax - 1],0
	jne L2
	call WriteDec
	call Crlf
L2:
	inc eax
	jmp L1
L3:
	ret
Print_primeNumber ENDP

END main
```
8. 冒泡排序：向 9.5.1 节的 BubbleSort 过程添加一个变量，进行内循环时，只要有一对数值交换就将其置 1。若在某次遍历过程中发现没有数值交换，就在过程正常结束之前，利用该变量提前退出。（该变量通常称为交换标志（exchange flag）。）
```
```
9. 对半查找：重新编写本章给出的对半查找过程，用寄存器来表示 mid、first 和 last。添加注释说明寄存器的用法。
```
```
10. 字母矩阵：编写过程生成一个 4 x 4 的矩阵，矩阵元素为随机选择的大写字母。选择字母时，必须保证被选字母是元音的概率为 50%。编写测试程序，用循环调用该过程 5 次，并在控制台窗口显示所有矩阵。前三次矩阵的示例输出如下所示：
D W A L
S I V W
U I O L
L A I I
R X S V
N U U O
O R Q O
A U U T
P O A Z
A E A U
G K A E
I A G D
```
```
11. 字母矩阵/按元音分组：
```
```
12. 数组行求和：
```
```
13. 裁剪前导字符：
```
```
14. 去除一组字符：
```
```
