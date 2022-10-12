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
INCLUDE Irvine32.inc

PrintArray PROTO,
	prompt:PTR BYTE,
	pArray:PTR DWORD,
	Count:DWORD

BubbleSort PROTO,
	pArray:PTR DWORD, ;// 数组指针
	Count:DWORD		  ;// 数组大小

.data
myArray DWORD -25,-24,-23,-8,2,-5,1,4,3,-6,9,10,-11
promptBefore BYTE "排序前：",0
promptAfter BYTE "排序后：",0

.code
main PROC
	INVOKE PrintArray, ADDR promptBefore, ADDR myArray, LENGTHOF myArray
	INVOKE BubbleSort, ADDR myArray, LENGTHOF myArray
	INVOKE PrintArray, ADDR promptAfter, ADDR myArray, LENGTHOF myArray
	exit
main ENDP

PrintArray PROC,
	prompt:PTR BYTE,
	pArray:PTR DWORD,
	Count:DWORD
	
	mov edx,prompt
	call WriteString
	call Crlf
		
	mov ecx,Count
	mov esi,pArray
L1: mov eax,[esi]
	call WriteInt
	mov al,' '
	call WriteChar
	add esi,TYPE DWORD
	loop L1

	call Crlf	
	ret
PrintArray ENDP

;//---------------------------------------------
;// BubbleSort
;// 使用冒泡算法，将一个 32 位有符号整数数组按升序进行排列。
;// 接收：数组指针，数组大小
;// 返回：无
;//---------------------------------------------
BubbleSort PROC USES eax ebx ecx esi,
	pArray:PTR DWORD,			;// 数组指针
	Count:DWORD					;// 数组大小

	mov ecx,Count
	dec ecx

L1: push ecx
	mov esi,pArray
	mov ebx,0
L2: mov eax,[esi]
	cmp [esi+4],eax
	jg L3
	xchg eax,[esi+4]
	mov [esi],eax
	mov ebx,1
L3: add esi,4
	loop L2
	pop ecx
	cmp ebx,0
	je L4
	loop L1

L4: ret
BubbleSort ENDP

END main
```
9. 对半查找：重新编写本章给出的对半查找过程，用寄存器来表示 mid、first 和 last。添加注释说明寄存器的用法。
BinarySearch.inc
```
; BinarySearch.inc - prototypes for procedures used in
; the BubbleSort / BinarySearch program.

; Search for an integer in an array of 32-bit signed
; integers.
BinarySearch PROTO,
	pArray:PTR DWORD,		; pointer to array
	searchVal:DWORD		; search value

; Fill an array with 32-bit signed random integers
FillArray PROTO,
	pArray:PTR DWORD,		; pointer to array
	Count:DWORD,		; number of elements
	LowerRange:SDWORD,		; lower range
	UpperRange:SDWORD		; upper range

; Write a 32-bit signed integer array to standard output
PrintArray PROTO,
	pArray:PTR DWORD,
	Count:DWORD

; Sort the array in ascending order
BubbleSort PROTO,
	pArray:PTR DWORD,
	Count:DWORD
```
BinarySearch.asm
```
TITLE  Binary Search Procedure            (BinarySearch.asm)

;// Binary Search procedure

INCLUDE Irvine32.inc

.code
;//-------------------------------------------------------------
BinarySearch PROC USES ebx edx esi edi,
	pArray:PTR DWORD,		;// pointer to array
	searchVal:DWORD			;// search value
;//
;// Search an array of signed integers for a single value.
;// Receives: Pointer to array, array size, search value.
;//				EAX: first index
;//				ECX: last index
;// Returns: If a match is found, EAX = the array position of the
;// matching element;// otherwise, EAX = -1.
;//-------------------------------------------------------------
	
	mov	 edi,searchVal		;// EDI = searchVal
	mov	 ebx,pArray			;// EBX points to the array

L1: ;// while first <= last
	cmp	 eax,ecx
	jg	 L5					;// exit search

;// mid = (last + first) / 2
	mov edx,eax
	add	 eax,ecx
	shr	 eax,1
	push eax

;// EDX = values[mid]
	mov	 esi,eax
	shl	 esi,2				;// scale mid value by 4
	mov eax, edx
	mov	 edx,[ebx+esi]		;// EDX = values[mid]

;// if ( EDX < searchval(EDI) )
;//	first = mid + 1;//
	cmp	 edx,edi
	jge	 L2
	pop eax
	inc	 eax
	jmp	 L4

;// else if( EDX > searchVal(EDI) )
;//	last = mid - 1;//
L2:	pop ecx
	cmp	 edx,edi
	jle	 L3
	dec	 ecx;	// last = mid - 1
	jmp	 L4

;// else return mid
L3:	mov	 eax,ecx  				;// value found
	jmp	 L9						;// return (mid)

L4:	jmp	 L1						;// continue the loop

L5:	mov	 eax,-1					;// search failed
L9:	ret
BinarySearch ENDP
END
```
BubbleSort.asm
```
TITLE  BubbleSort Procedure                  (BubbleSort.asm)

; Sort an array of signed integers, using the Bubble
; sort algorithm. The main program is in BinarySearchTest.asm.

INCLUDE Irvine32.inc

.code
;----------------------------------------------------------
BubbleSort PROC USES eax ecx esi,
	pArray:PTR DWORD,		; pointer to array
	Count:DWORD			; array size
;
; Sort an array of 32-bit signed integers in ascending order
; using the bubble sort algorithm.
; Receives: pointer to array, array size
; Returns: nothing
;-----------------------------------------------------------

	mov ecx,Count
	dec ecx			; decrement count by 1

L1:	push ecx			; save outer loop count
	mov	esi,pArray	; point to first value

L2:	mov	eax,[esi]		; get array value
	cmp	[esi+4],eax	; compare a pair of values
	jge	L3			; if [esi] <= [edi], don't exch
	xchg eax,[esi+4]	; exchange the pair
	mov	[esi],eax

L3:	add	esi,4		; move both pointers forward
	loop	L2			; inner loop

	pop	ecx			; retrieve outer loop count
	loop L1			; else repeat outer loop

L4:	ret
BubbleSort ENDP

END
```
FillArray.asm
```
TITLE FillArray Procedure                 (FillArray.asm)

INCLUDE Irvine32.inc

.code
;------------------------------------------------------------
FillArray PROC USES eax edi ecx edx,
	pArray:PTR DWORD,		  ; pointer to array
	Count:DWORD,		       ; number of elements
	LowerRange:SDWORD,		  ; lower range
	UpperRange:SDWORD		  ; upper range
;
; Fills an array with a random sequence of 32-bit signed
; integers between LowerRange and (UpperRange - 1).
; Returns: nothing
;-----------------------------------------------------------
	mov	edi,pArray	           ; EDI points to the array
	mov	ecx,Count	                ; loop counter
	mov	edx,UpperRange
	sub	edx,LowerRange	           ; EDX = absolute range (0..n)
	cld                            ; clear direction flag

L1:	mov	eax,edx	                ; get absolute range
	call	RandomRange
	add	eax,LowerRange	           ; bias the result
	stosd		                ; store EAX into [edi]
	loop	L1

	ret
FillArray ENDP

END
```
PrintArray.asm
```
TITLE PrintArray Procedure                  (PrintArray.asm)

INCLUDE Irvine32.inc

.code
;//-----------------------------------------------------------
PrintArray PROC USES eax ecx edx esi,
	pArray:PTR DWORD,		;// pointer to array
	Count:DWORD			;// number of elements
;//
;// Writes an array of 32-bit signed decimal integers to
;// standard output, separated by commas
;// Receives: pointer to array, array size
;// Returns: nothing
;//-----------------------------------------------------------
.data
comma BYTE ", ",0
.code
	mov	esi,pArray
	mov	ecx,Count
	cld				;// direction = forward

L1:	lodsd			;// load [ESI] into EAX
	call	WriteInt		;// send to output
	mov	edx,OFFSET comma
	call	Writestring	;// display comma
	loop	L1

	call	Crlf
	ret
PrintArray ENDP

END
```
BinarySearchTest.asm
```
TITLE Bubble Sort and Binary Search       BinarySearchTest.asm)

;// Bubble sort an array of signed integers, and perform
;// a binary search.
;// Main module, calls Bsearch.asm, Bsort.asm, FillArry.asm

INCLUDE Irvine32.inc
INCLUDE BinarySearch.inc		;// procedure prototypes

AskForInputANumber PROTO,
	prompt:PTR BYTE

LOWVAL = -5000			;// minimum value
HIGHVAL = +5000		;// maximum value
ARRAY_SIZE = 50		;// size of the array

.data
array DWORD ARRAY_SIZE DUP(?)
askForSearchValPrompt BYTE "Enter a signed decimal integer to find in the array: ", 0
askForFirstIndexPrompt BYTE "Enter first index: ",0
askForLastIndexPrompt BYTE "Enter last index: ",0

.code
main PROC
	call Randomize

	;// Fill an array with random signed integers
	INVOKE FillArray, ADDR array, ARRAY_SIZE, LOWVAL, HIGHVAL

	;// Display the array
	INVOKE PrintArray, ADDR array, ARRAY_SIZE
	call	WaitMsg
	call Crlf

	;// Perform a bubble sort and redisplay the array
	INVOKE BubbleSort, ADDR array, ARRAY_SIZE
	INVOKE PrintArray, ADDR array, ARRAY_SIZE

	;// Demonstrate a binary search
	INVOKE AskForInputANumber, ADDR askForSearchValPrompt
	mov edi,eax
	INVOKE AskForInputANumber, ADDR askForFirstIndexPrompt
	mov ebx,eax
	INVOKE AskForInputANumber, ADDR askForLastIndexPrompt
	mov ecx,eax
	mov eax,ebx
	INVOKE BinarySearch, ADDR array, edi
	call	ShowResults

	exit
main ENDP

;//--------------------------------------------------------
AskForInputANumber PROC,
	prompt:PTR BYTE
	
	call Crlf
	mov edx,prompt
	call WriteString
	call ReadInt
	ret
AskForInputANumber ENDP

;//--------------------------------------------------------
ShowResults PROC
;//
;// Display the resulting value from the binary search.
;// Receives: EAX = position number to be displayed
;// Returns: nothing
;//--------------------------------------------------------
.data
msg1 BYTE "The value was not found.",0
msg2 BYTE "The value was found at position ",0
.code
.IF eax == -1
	mov	edx,OFFSET msg1
	call	WriteString
.ELSE
	mov	edx,OFFSET msg2
	call	WriteString
	call	WriteDec
.ENDIF
	call	Crlf
	call	Crlf
	ret
ShowResults ENDP

END main
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
INCLUDE Irvine32.inc

Str_length PROTO,
	pString:PTR BYTE	;// pointer to string

GenerateMatrix PROTO,
	vowelsPtr:PTR BYTE,
	nonVowelsPtr : PTR BYTE,
	rowCount : DWORD,
	colCount : DWORD

GetRandomChar PROTO,
	pString : PTR BYTE,
	count : DWORD

.data
rows=4
cols=4
vowels BYTE "AEIOU",0
nonVowels BYTE "BCDFGHJKLMNPQRSTVWXYZ",0

.code
main PROC
	call Randomize

	mov ecx,5
L1: INVOKE GenerateMatrix, ADDR vowels, ADDR nonVowels, rows, cols
	call Crlf
	loop L1

	exit
main ENDP

GenerateMatrix PROC USES eax ebx ecx edx,
	vowelsPtr:PTR BYTE,
	nonVowelsPtr:PTR BYTE,
	rowCount:DWORD,
	colCount:DWORD

	INVOKE Str_length, vowelsPtr
	mov ebx,eax
	INVOKE Str_length, nonVowelsPtr
	mov edx,eax

	mov ecx,rowCount
L1: push ecx
	mov ecx,colCount
L2: mov eax,10
	call RandomRange
	cmp eax,5
	jb L3
	INVOKE GetRandomChar, vowelsPtr, ebx
	jmp L4
L3:
	INVOKE GetRandomChar, nonVowelsPtr, edx
L4:
	call WriteChar
	mov al,' '
	call WriteChar
	loop L2
	call Crlf
	pop ecx
	loop L1
	
	ret
GenerateMatrix ENDP

GetRandomChar PROC,
	pString:PTR BYTE,
	count:DWORD

	mov eax,count
	call RandomRange
	add eax,pString
	mov al,[eax]
	ret
GetRandomChar ENDP

END main
```
11. 字母矩阵/按元音分组：本程序以上一道编程练习生成的字母矩阵为基础。生成一个 4 x 4 的字母矩阵，其中每个字母都有 50% 的概率为元音字母。遍历矩阵的每一行，每一列，和每个对角线，并产生字母组。当一组四个字母中只有两个元音字母时，显示该字母组。比如，假设生成矩阵如下所示：
P O A Z
A E A U
G K A E
I A G D
则程序应显示的四字母组为 POAZ、GKAE、IAGD、PAGI、ZUED、PEAD 和 ZAKI。各组内字母的顺序并不重要。
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
