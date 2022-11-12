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
