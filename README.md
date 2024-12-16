# CSE-141L Project

To run the assembler: copy and paste assembly code into file labeled assembly1.txt in same folder as Java file.
Run Java file. Outputted machine code will be in mach_code1.txt.

Note: the assembler will leave beq instructions and jump labels in the machine code. Those have to be added to the JLUT and the labels removed and beq instructions converted by hand.

To run the testbenches, replace the machine code and JLUT paths in InstROM.sv and JLUT.sv respectively.

Program 1 is working, program 2 is giving some incorrect outputs. Program 3 is giving entirely incorrect outputs.
For Program 1 specifically, certain values have to be preloaded into the register file. We have modified the int2flt testbench to do this.