module ProgCtr(
  input             Clk,
                    Reset,
						  Jen,
						  Zero, 
              StallCtr,
  input       [7:0] Jump,
  output logic[7:0] PC);

  logic[2:0] ct = 0;

  always_ff @(posedge Clk) begin
    if(StallCtr) begin
      if (ct % 4 == 0) begin
        if(Reset) PC <= 'b0;
        else if(Jen & Zero) PC <= Jump;
        else      PC <= PC + 6'd1;
      end
      ct++;
    end else begin
      ct = 0;
      if(Reset) PC <= 'b0;
      else if(Jen & Zero) PC <= Jump;
      else      PC <= PC + 6'd1;
    end
  end

endmodule
