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
