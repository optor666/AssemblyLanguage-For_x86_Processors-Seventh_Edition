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
# 寄存器

| 英文名 | 中文名 | 用途 |
| - | - | - |
| EAX | | |
| EBX | | |
| ECX | | |
| EDX | | |
| ESI | | |
| EDI | | |
| ESP | | |
| EBP | | |
| EIP | | |
| EFL(EFLAGS) | 进位、符号、零、溢出、辅助进位、奇偶 标志位 | |

# 指令
1. 堆栈相关：PUSH POP PUSHFD POPFD PUSHAD POPAD PUSHA POPA
2. 过程相关：CALL RET
# 伪指令
1. 获取某个全局变量内存位置：OFFSET arrayD
2. 获取某个类型或某个变量类型字节数：TYPE SDWORD 或 TYPE arrayD
3. 获取数组长度：LENGTHOF arrayD
4. 过程相关：PROC ENDP
# 标号
1. 带有单个冒号的代码标号只在包含它的过程中可见；带有两个冒号（::）的标号则是全局标号；
# 随书链接库
1. kernel32.lib 文件是 Microsoft Windows 平台软件开发工具（Software Development Kit）的一部分，它包含了 kernel32.dll 文件中系统函数的链接信息；
2. kernel32.dll 文件是 MS-Windows 的一个基本组成部分，被称为动态链接库（dynamic link library）。它含有的可执行函数实现基于字符的输入输出；它在系统上的位置："C:\Windows\System32\kernel32.dll"
3. Irvine32 是作者自己开发的一个基于 Windows 系统给初学者提供简单的输入输出接口的链接库；（可以猜测：Irvine32 链接库封装了 Windows 系统的系统调用）

| 过程名称 | 过程作用 |
| - | -|
| Clrf | 换行 |
| Clrscr | 清屏 |
| Delay | 暂停 eax 毫秒数 |
| DumpMem | dump 内存区域（esi 内存起始位置、ebx 输出单元字节数、ecx 输出单元个数）|
| DumpRegs | 用十六进制显示 10 个寄存器内容以及 6 个标志位内容 |
| GetMaxXY | 获取控制台窗口大小（AX 缓冲区行数、DX 缓冲区列表） |
| GetMseconds | 获取从午夜开始经过的毫秒数，并用 eax 返回该值 |
| Gotoxy | 将光标定位到控制台指定位置（DH 行数、DL 列表） |
| Randomize | 初始化随机数种子 |
| Random32 | 生成 32 位随机数（eax） |
| RandomRange | 生成 [0, eax) 范围随机数（eax） |
| ReadDec | 输入无符号整数（eax） |
| ReadInt | 输入有符号整数，正号可省略（eax 输入值） |
| ReadString | 输入字符串（EDX 保存输入缓冲区起始位置、ECX 用户可以输入字符个数加 1、EAX 用户键入字符数） |
| SetTextColor | 设置前景色、背景色（可以参考 Irvine32.inc 中颜色定义以及[示例1](https://github.com/optor666/AssemblyLanguage-For_x86_Processors-Seventh_Edition/blob/master/Chapter05/examples/InputLoop.asm) |
| Str_length | edx 以空字节结尾的字符串偏移量、eax 字符串长度 |
| WaitMsg | 等待任意输入 |
| WriteBin | 输出 eax 二进制 |
| WriteChar | 输出 al 字符（若为不可见字符，则可直接使用其 ASCII 码值，可参考[示例1](https://github.com/optor666/AssemblyLanguage-For_x86_Processors-Seventh_Edition/blob/master/Chapter05/examples/TestLib2.asm)
| WriteDec | 输出 eax 无符号十进制 |
| WriteHex | 输出 eax 十六进制 |
| WriteInt | 输出 eax 有符号十进制 |
| WriteString | 输出字符串（edx 字符串起始内存位置）|

# x64 调用规范
Microsoft 在 64 位程序中使用统一模式来传递并调用过程，称为 Microsoft x64 调用规范。该规范由 C/C++ 编译器和 Windows 应用编程接口（API）使用。程序员只有在调用 Windows API 的函数或用 C/C++ 编写的函数时，才会使用这个调用规范，调用 Irvine64 链接库中的子程序时，不需使用 Microsoft x64 调用规范。该规范一些基本特征如下：
1. CALL 指令将 RSP（堆栈指针）寄存器减 8，因为地址是 64 位的；
2. 前四个参数依序存入 RCX、RDX、R8 和 R9 寄存器，并传递给过程。如果只有一个参数，则将其放入 RCX。如果还有第二个参数，则将其放入 RDX，以此类推。其他参数，按照从左到右的顺序压入堆栈；
3. 调用者的责任还包括在运行时分配至少 32 字节的影子空间（shadow space），这样，被调用的过程就可以选择将寄存器参数保存在这个区域中；
4. 在调用子程序时，堆栈指针（RSP）必须进行 16 字节边界对齐（16 的倍数）。CALL 指令把 8 字节的返回值压入堆栈，因此，除了已经减去的影子空间的 32 之外，调用程序还必须从堆栈指针中减去 8；

# Microsoft Visual Studio Community 2019
## 版本信息
1. Microsoft Visual Studio Community 2019 版本 16.11.8
## 使用技巧
1. 查看 MASM 高级运算符和伪指令生成的隐藏机器指令：断点调试某个汇编程序 - 鼠标右键 - 转到反汇编
2. 设置汇编程序启动时的参数：菜单栏 - 项目 - Project 属性 - 配置属性 - 调试 - 命令参数
3. 查看 Visual Studio 汇编、链接使用的命令：菜单栏-工具-选项-项目和解决方案-生成并运行-MSBuild 项目生成输出详细程度（V）-详细
