module JLUT(
  input[7:0] Jptr,
  output logic[5:0] Jump);

 //  always_comb case(Jptr)
	// 0: Jump = 5; 
	// 1: Jump = 3;
	// 2: Jump = 6;
	// 3: Jump = 8;
	// default: Jump = 0;
 //  endcase

logic[7:0] Core[64];

initial 
	$readmemb("jlut.txt",Core);

always_comb Jump = Core[Jptr];

endmodule
