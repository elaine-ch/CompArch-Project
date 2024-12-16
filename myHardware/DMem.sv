module DatMem (
  input[7:0] in,
  input Clk,
  input wr_en,
  input RenD,
  input[7:0] addr,
  output logic[7:0] out);

  logic[7:0] core[256];

  // store
  always_ff @(posedge Clk) begin
    if(wr_en) core[addr] <= in; 
    if(RenD) out <= core[addr];
	end

endmodule