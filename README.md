Computer Organization 2 Course Project 
------------------------------------------

<Block_name>

<Inputs>

<Output>

<Description>
----------------------------------------------------------------------------------------------------------
<ALU>

<A_left operand(32bit),B_right operand(32bit),ALU_OP>

<result(32bit),Zero(1bit)>

<
•An ALU (arithmetic-logical unit) is a combinational circuit capable of computing a variety of arithmetic and logical functions.
•operations needed for MIPS instructions(excecuted by ALU) : Arithmetic: add, add / Load/Store: lw, sw / Logic: sll, and, andi, or, ori, nor / Control flow: beq, jal, jr / Comparison: slt .

•general strategy of block implementation:
1)different circuits combined by multiplexer; multiplexer select becomes function select for ALU
2)inverting B input for subtraction
>
----------------------------------------------------------------------------------------------------

<Sign Extend>

<16bits wire>

<32bits wire>

< extend the MSBs of output(16bit) with the value of MSB of the input
eg. input (1)011 1011 1110  --> output 1111 1111 1111 1111 1011 1011 1110
eg. input (0)011 1011 1110  --> output 0000 0000 0000 0000 0011 1011 1110
>
--------------------------------------------------------------------------------------------------------







