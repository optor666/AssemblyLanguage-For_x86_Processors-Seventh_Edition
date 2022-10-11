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
7. todo
8. todo
