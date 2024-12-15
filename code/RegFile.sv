module RegFile(
  input Clk,	Wen, 
  input[2:0] Ra, Rb, Wd,	 //read and write addr
  input[7:0] Wdat, //data to write in
  output Zero, //checks that R6=0
  output[7:0]RdatA, RdatB); //dataout
				      
  logic[7:0] core[8]; //reg file itself (8*8 array)

  assign RdatA = core[Ra];
  assign RdatB = core[Rb];
  assign Zero = core[5] == 0;

  always_ff @(posedge Clk)
    if(Wen) core[Wd] <= Wdat;

endmodule
