module Ctrl(
  input        [8:0] mach_code,
  output logic [7:0] Jptr,
  output logic [2:0] Aluop,
  output logic [2:0] Ra,
			            Rb,
			            Wd,
  output logic  WenR,
					 WenD,
					 MemToReg,
					 Jen, 
					 Done
);

  always_comb begin
	// R type instructions
	Aluop = mach_code[7:5];          // ALU
	Ra	   = mach_code[4:3];	         // operand reg A
	Rb    = mach_code[2:1];          // operand reg B
	Wd    = 3'b100 + mach_code[0];   // destination reg
	
	// B type instructions
	Jptr  = mach_code[5:0];    // jump pointer
	
	WenR  = 1'b1;   // reg file write enable
	MemToReg = 1'b0; 
	WenD = 1'b0; // data mem write enable
	Jen = 1'b0; // jump enable
	Done = 1'b0;
	
	case(mach_code)
		9'b011111111: Done = 1'b1; // Done
		9'b101??????: begin // Store
		  WenD = 1'b1;
		end
		9'b110??????: begin // Load
		MemToReg = 1'b1; // write to register from data_mem
		WenR = 1'b0; // Write reg disabled for load
		end
		9'b100??????: begin // branch
			WenR = 1'b0; // Write reg disabled for branch
			Jen = 1'b1;
		end
	endcase
//    case(mach_code)

//	endcase
  end

endmodule
