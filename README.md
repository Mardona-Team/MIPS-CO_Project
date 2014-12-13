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

Block Name :
-	Data Memory

Inputs:
-	Address
-	Write data

Outputs:
-	Read result
Description :
The memory unit is a state element, it’s just a large single-dimensional array with the address acting as the index to that array starting at 0.
The purpose of the Memory access phase is to store operands into memory or load operands from memory. So, for all instructions except loads and stores, the MA simply passes on the value from the ALU on to the WB stage .
For loads and stores, the MA needs to send the effective address calculated by the ALU to memory .For loads, the memory will then respond by sending the requested data back . For stores, we need to send the data to be stored along with the effective address , and the memory will respond by updating itself.
The controls on the data memory are memory write and memory read .
The data memory is connected to a MUX where its selection line define whether the output will be data loaded from the memory or the data calculated from the ALU . The decision is taken upon the control signal sent from the control unit to memory to register control line.
ALU-control = (0010) add for address calculation for both LW ans SW .
-	sw : Mem-Read=0, Mem-Write=1,Reg-Write=0
-	lw : Mem-Read=1, Mem-Write=0,Reg-Write=1

Clock input (CLK)
–  The CLK input is a factor ONLY during write operation.
–  During read operation, behaves as a combinational logic block.

Block Name:
-	Program Counter
	
Inputs:

The program counter receives one and only one of the following inputs for each clock cycle:
-	PC + 4
-	PC + 4 + (offset*4) from a branch instruction
-	Label from a jump and link instruction 
-	Address saved in $ra register from jr instruction 

Outputs:

-	The address of the next instruction which is logically true according to the program sequence.

Description:
The Program Counter (PC) is a register structure that contains the address pointer value of the current instruction. Each cycle, the value at the pointer is read into the instruction decoder and the program counter is updated to point to the next instruction.
The program counter circuit is composed of two kinds of registers, a down counter, an up counter, a selector, and a logic circuit. The two kinds of registers hold a pre-jump PC value and a post-jump PC value of a jump that is prescribed by a program. The down counter holds the number of repetitions of a repeat sequence that is prescribed by the program. The up counter holds a PC value that is counted up for each clock pulse. The selector selects, as a PC value to be output next, the post-jump PC value or the value that is held by the up counter. The logic circuit refers to the output value of the program counter and the output values of the registers and the down counter, and generates a signal that instructs the selector what PC value should be selected as the next output value.



--------------------------------------------------------------------------------------------------------------------

<ADDER>
<inputs>
32-bit address from PC
Input  ‘4’
Internal input cin;

<outputs>
Sum,carry

<Description>
Full Adder’s function is to add 4 to the address coming from PC unit and use the result as an input to the instruction memory to move to the next instruction.

------------------------------------------------------------------------------------------------------------


<Register File>

<Inputs>
     ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
               output port 'ReadRegister1'.        
 ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
                output port 'ReadRegister2'.
WriteRegister: 5-Bit address to select a register to be written through 32-Bit
                input port 'WriteRegister'.
 WriteData: 32-Bit write input port.
WriteEnable: 1-Bit control input signal.

<Output>

ReadData1: 32-Bit registered output. 
 ReadData2: 32-Bit registered output.

<Description> 

'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
 registers simultaneously. The two 32-bit data sets are available on ports 
 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
 registered outputs (output of register file is written into these registers 
 at the falling edge of the clock). You can view it as if outputs of registers
 specified by ReadRegister1 and ReadRegister2 are written into output 
 registers ReadData1 and ReadData2 at the falling edge of the clock. 

 'WriteEnable' signal is high during the rising edge of the clock if the input 
 data is to be written into the register file. The contents of the register 
 specified by address 'WriteRegister' in the register file are modified at the 
 rising edge of the clock if 'WriteEnable' signal is high. The D-flip flops in 
 the register file are positive-edge (rising-edge) triggered. (You have to use 
 this information to generate the write-clock properly.) 





