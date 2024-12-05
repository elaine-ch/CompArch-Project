module Ctrl(
  input        [8:0] mach_code,
  output logic [7:0] Jptr,
  output logic [2:0] Aluop,
  output logic [2:0] Ra,
			            Rb,
			            Wd,
  output logic  WenR,
					 WenD,
					 RenD, 
					 MemToReg,
					 Jen, 
					 Done
);

  always_comb begin
	// R type instructions
	Aluop = mach_code[7:5];          // ALU
	Ra	   = mach_code[4:3];	         // operand reg A
	Rb    = mach_code[2:0];          // operand reg B
	Wd    = mach_code[2:0];   			// destination reg for R instructions
	
	// B type instructions
	Jptr  = mach_code[5:0];    // jump pointer
	
	WenR  = 1'b1;   // reg file write enable
	MemToReg = 1'b0; 
	WenD = 1'b0; // data mem write enable
	RenD = 1'b0; // read from data_mem
	Jen = 1'b0; // jump enable
	Done = 1'b0;
	
	case(mach_code)
		9'b011111111: begin
			Done = 1'b1; // Done
			WenR = 1'b0; // disable reg write
		end
		9'b100??????: begin // branch
			WenR = 1'b0; // Write reg disabled for branch
			Jen = 1'b1;
		end
		9'b110??????: begin // Load
		  MemToReg = 1'b1; // write to register from data_mem
		  RenD = 1'b1;
		  Wd = mach_code[5:3];
		  Ra = 3'b110; // read addr from reg 6
		end
		9'b101??????: begin // Store
		  WenD = 1'b1;
		  WenR = 1'b0; // Write reg disabled for store
		  Ra = 3'b111; // read addr from reg 7
		  Rb = mach_code[5:3];
		end
		9'b111??????: begin // move
		  Ra = mach_code[5:3]; // register to be moved
		  Wd = mach_code[2:0]; // destination register
		end
	endcase
	
  end

endmodule
