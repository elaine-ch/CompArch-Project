module JLUT(
  input[7:0] Jptr,
  output logic[7:0] Jump);

logic[7:0] Core[256];

initial 
	$readmemb("C:/Users/elain/Documents/useless/CSE-141L-2024/Programs/Program2/jlut.txt",Core);

always_comb Jump = Core[Jptr];

endmodule
