# 过程
  过程，也称为子程序或函数。
## 堆栈
  运行时堆栈是内存数组，CPU 用 ESP（扩展堆栈指针，extended stack pointer）寄存器对其进行直接管理，该寄存器被称为堆栈指针寄存器（stack pointer register）。32 位模式下，ESP 寄存器存放的是堆栈中某个位置的 32 位偏移量。ESP 基本上不会直接被程序员控制，反之，它是用 CALL、RET、PUSH 和 POP 等指令间接进行修改。
### 指令
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
