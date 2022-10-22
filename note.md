# 堆栈
  运行时堆栈是内存数组，CPU 用 ESP（扩展堆栈指针，extended stack pointer）寄存器对其进行直接管理，该寄存器被称为堆栈指针寄存器（stack pointer register）。32 位模式下，ESP 寄存器存放的是堆栈中某个位置的 32 位偏移量。ESP 基本上不会直接被程序员控制，反之，它是用 CALL、RET、PUSH 和 POP 等指令间接进行修改。
## 指令
<table>
    <tr>
        <th>指令</th><th>格式</th>
    </tr>
    <tr>
        <td rowspan="3">PUSH</td><td>PUSH reg/mem16 (操作数是 16 位的，ESP 减 2)</td>
    </tr>
    <tr>
        <td>PUSH reg/mem32 (操作数是 32 位的，ESP 减 4)</td>
    </tr>
    <tr>
        <td>PUSH imm32</td>
    </tr>
    <tr>
        <td rowspan="2">POP</td><td>POP reg/mem16 (操作数是 16 位的，ESP 加 2)</td>
    </tr>
    <tr>
        <td>POP reg/mem32 (操作数是 32 位的，ESP 加 4)</td>
    </tr>
    <tr>
        <td>PUSHFD</td><td>PUSHFD (把 32 位 EFLAGS 寄存器内容压入堆栈)</td>
    </tr>
    <tr>
        <td>POPFD</td><td>POPFD (把栈顶单元内容弹出到 EFLAGS 寄存器)</td>
    </tr>
    <tr>
        <td>PUSHAD</td><td>PUSHAD (按照 EAX、ECX、EDX、EBX、ESP（执行 PUSHAD 之前的值）、EBP、ESI 和 EDI 的顺序，将所有 32 位通用寄存器压入堆栈）</td>
    </tr>
    <tr>
        <td>POPAD</td><td>POPAD (按照相反顺序将同样的寄存器弹出堆栈)</td>
    </tr>
    <tr>
        <td>PUSHA</td><td>PUSHA (按照 AX、CX、DX、BX、SP（执行 PUSHA 之前的值）、BP、SI 和 DI 的顺序，将所有 16 位通用寄存器压入堆栈）</td>
    </tr>
    <tr>
        <td>POPA</td><td>POPA (按照相反顺序将同样的寄存器弹出堆栈)</td>
    </tr>
</table>

## 示例
1. 基于堆栈实现字符串翻转：[Chapter05/examples/RevStr.asm](https://github.com/optor666/AssemblyLanguage-For_x86_Processors-Seventh_Edition/blob/master/Chapter05/examples/RevStr.asm)

# 过程
  过程，也称为子程序或函数。基于堆栈和指令指针寄存器（即 EIP 寄存器；16 位模式下是 IP寄存器），汇编语言通过 CALL、RET 两条指令实现过程。CALL 指令调用一个过程，将返回地址（其下一条指令的地址）压入堆栈，并把被调用过程的地址复制到指令指针寄存器；RET 指令从堆栈中把返回地址弹出到指令指针寄存器。
## 定义过程
1. 使用伪指令 PROC、ENDP 定义过程；
2. USES 运算符与 PROC 伪指令一起使用，可以列出在过程返回时需要恢复的寄存器，由汇编器自动在过程开始和结尾位置插入相应的 PUSH、POP 指令。可参考：[TestArraySum.asm](https://github.com/optor666/AssemblyLanguage-For_x86_Processors-Seventh_Edition/blob/master/Chapter05/examples/TestArraySum.asm) 和 [TestArraySum2.asm](https://github.com/optor666/AssemblyLanguage-For_x86_Processors-Seventh_Edition/blob/master/Chapter05/examples/TestArraySum2.asm)；
## 调用过程
1. 使用指令 CALL、RET 调用过程；
## 示例
1. 使用基本的 CALL、RET 指令来调用过程，使用寄存器来传递输入、输出参数：[TestArraySum.asm](https://github.com/optor666/AssemblyLanguage-For_x86_Processors-Seventh_Edition/blob/master/Chapter05/examples/TestArraySum.asm)
2. todo
# 指令
1. 堆栈相关：PUSH POP PUSHFD POPFD PUSHAD POPAD PUSHA POPA
2. 过程相关：CALL RET
# 伪指令
1. 过程相关：PROC ENDP
