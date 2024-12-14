module InstrRom_tb();
	logic[7:0] PC;
	logic[8:0] mach_code;
	logic[8:0] Core[256];

	logic clk;


	InstROM InstrROM (.PC(PC), .mach_code(mach_code));

	always begin               // clock 
		#1ns clk = '1;			 
		#1ns clk = '0;
	end

	initial begin				 // test sequence
		clk = 0;
		PC = 0;
		
		$readmemb("C:\Users\elain\Documents\useless\CSE-141L-2024\code\mach_code.txt", Core);

		#10ns
		$display("%d", Core[0]);
		PC++;
		#1ns
		$display("%d", Core[1]);

		#10ns
		PC++;
		#1ns
		$display("%d", Core[2]);

		#10ns
		PC++;
		#1ns
		$display("%d", Core[3]);

		#10ns
		PC++;
		#1ns
		$display("%d", Core[4]);

		#10ns
		$stop;
	end
endmodule
