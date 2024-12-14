module InstrRom_tb();
	logic[7:0] PC;
	logic[8:0] mach_code;

	logic clk;


	InstROM InstrROM (.PC(PC), .mach_code(mach_code));

	always begin               // clock 
		#1ns clk = '1;			 
		#1ns clk = '0;
	end

	initial begin				 // test sequence
		clk = 0;
		PC = 0;

		#10ns
		$display("%b", PC);
		PC++;
		#1ns
		$display("%b", PC);

		#10ns
		PC++;
		#1ns
		$display("%b", PC);

		#10ns
		PC++;
		#1ns
		$display("%b", PC);

		#10ns
		PC++;
		#1ns
		$display("%b", PC);

		#10ns
		$stop;
	end
endmodule
