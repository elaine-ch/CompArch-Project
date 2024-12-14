module ProgCtr(
  input             Clk,
                    Reset,
					Jen,
  input       [7:0] Jump,
  output logic[7:0] PC);


  always_ff @(posedge Clk)
    if(Reset) PC <= 'b0;
	else if(Jen) PC <= Jump;
	else      PC <= PC + 6'd1;

endmodule