module JLUT(
  input[7:0] Jptr,
  output logic[5:0] Jump);

logic[7:0] Core[64];

initial 
	$readmemb("jlut.txt",Core);

always_comb Jump = Core[Jptr];

endmodule
