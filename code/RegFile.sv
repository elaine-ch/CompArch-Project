module RegFile(
  input      Clk,	 // clock
             Wen,  // write enable
  input[2:0] Ra,   // read address pointer A
             Rb,   //                      B
			    Wd,	 // write address pointer
  input[7:0] Wdat, // write data in
  output Zero, 	 // checks that R6=0
  output[7:0]RdatA,// read data out A
             RdatB);// read data out B
				      
  logic[7:0] core[8]; // reg file itself (8*8 array)

  assign RdatA = core[Ra];
  assign RdatB = core[Rb];
  assign Zero = core[5] == 0;

  always_ff @(posedge Clk)
    if(Wen)
      core[Wd] <= Wdat;

endmodule
