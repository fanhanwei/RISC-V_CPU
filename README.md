# RISC-V_CPU
 5-staged pipeline RISC-V CPU by Verilog
 
Welcome to my homepage.

This is my first step into computer architecture -- a CPU based on RISC-V instruction set realized by Verilog.

It is a Havard architecture CPU. The instruction memory is realized by IP provided by QuartusII.
Set the file program.mif as the resource of the instruction memory, then you can put your machine codes in it.
The memory can store only 64 instructions due to the limitation of IP.

It only supports 32-bit instruction. 
The oprands are 64-bit. 
Only support integer operation now.
All instructions in RV32I Base Instruction Set are runnable.

I appreciate if you can provide me with some suggestions!
