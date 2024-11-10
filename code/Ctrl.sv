module Ctrl(
  input        [8:0] mach_code,
  output logic [7:0] Jptr,
  output logic [2:0] Aluop,
  output logic [2:0] Ra,
			            Rb,
			            Wd,
  output logic  WenR,
					 WenD,
					 Ldr,
					 Str, 
					 Done
);

//  always_comb begin
//	Aluop = {1'b0, mach_code[1:0]};// ALU
//	Jptr  = mach_code[3:2];		// jump pointer
//	Ra	  = mach_code[5:4];		// reg file addr A
//	Rb    = 2'b0;		      
//	Wd    = mach_code[5:4];
//	WenR  = mach_code[6];		// reg file write enable
//	WenD  = !mach_code[6];		// data mem write enable
//	Ldr   =	mach_code[7];		// load
  always_comb begin
	// R type instructions
	Aluop = mach_code[7:5]; // ALU
	Ra	   = mach_code[4:3];	// operand reg A
	Rb    = mach_code[2:1]; // operand reg B
	// Rd    = mach_code[0];   // destination reg
	
	// B type instructions
	Jptr  = mach_code[5:0];    // jump pointer
	
	WenR  = mach_code[6];		// reg file write enable
	WenD  = !mach_code[6];		// data mem write enable
	Ldr   = mach_code[7];		// load
	Str = 1'b0;
	Done = 1'b0;
	
	case(mach_code)
		9'b011111111: Done = 1'b1;
		9'b110??????: Str = 1'b1;
	endcase
//    case(mach_code)

//	endcase
  end

endmodule
