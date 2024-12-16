module InstROM(
  input[7:0] PC,
  output logic[8:0] mach_code);

  logic[8:0] Core[256];

  initial 
	$readmemb("C:/Users/elain/Documents/useless/CSE-141L-2024/Programs/Program2/mach_code.txt", Core);
  // $readmemb("C:/Users/elain/Documents/useless/CSE-141L-2024/testbenches/mach_code.txt", Core);

  always_comb mach_code = Core[PC];

endmodule