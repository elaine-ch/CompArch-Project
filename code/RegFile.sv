module RegFile(
  input[7:0] dat_in,
  input clk,
  input wr_en,           
  input[pw:0] wr_addr, rd_addrA, rd_addrB,
  output logic[7:0] datA_out, datB_out);

  logic[7:0] core[8];

  assign datA_out = core[rd_addrA];
  assign datB_out = core[rd_addrB];

  always_ff @(posedge clk)
    if(wr_en)				   
      core[wr_addr] <= dat_in; 

endmodule
