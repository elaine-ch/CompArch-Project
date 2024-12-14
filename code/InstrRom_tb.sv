module InstrRom_tb();
	logic[7:0] pc;
	logic[8:0] mach_code;


	InstROM InstrROM (.PC(pc), .mach_code(mach_code));


	initial begin				 // test sequence
		pc = 0;

		#10ns
		$display("%b", mach_code);
		pc++;
		#1ns
		$display("%b", mach_code);

		#10ns
		pc++;
		#1ns
		$display("%b", mach_code);

		#10ns
		pc++;
		#1ns
		$display("%b", mach_code);

		#10ns
		pc++;
		#1ns
		$display("%b", mach_code);

		#10ns
		$stop;
	end
endmodule
