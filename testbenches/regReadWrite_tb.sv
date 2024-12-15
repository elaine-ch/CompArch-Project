module regReadWrite_tb ();

//tb_module.top_level_module.variable_in_module[]

logic clk, Wen;
logic[7:0] Wdat, RdatA, RdatB;
logic[2:0] Ra, Rb, Wd; 

RegFile registers(
  .Clk(clk),
  .Wen(Wen),
  .Ra(Ra),
  .Rb(Rb),
  .Wd(Wd),
  .Wdat(Wdat),
  .RdatA(RdatA),
  .RdatB(RdatB)
);

initial begin

  // Initialize reg file values
  regReadWrite_tb.registers.core[0] = 1;
  regReadWrite_tb.registers.core[1] = 31;
  regReadWrite_tb.registers.core[2] = 96;
  regReadWrite_tb.registers.core[3] = 0;
  regReadWrite_tb.registers.core[4] = 0;
  regReadWrite_tb.registers.core[5] = 0;
  regReadWrite_tb.registers.core[6] = 0;
  regReadWrite_tb.registers.core[7] = 5;
  
  Wen = 0;
  Ra = 2;
  Rb = 5;

  #10ns
  if(RdatA == 96 && RdatB == 0) begin
    $display("%t YAY!! read: inputs = %d %d, outputs = %d %d, expected = 96 0",$time, Ra, Rb, RdatA, RdatB);
  end else begin
    $display("%t FAIL! read: inputs = %d %d, outputs = %d %d, expected = 96 0",$time, Ra, Rb, RdatA, RdatB);
  end

  Wen = 1;
  Wd = 6;
  Wdat = 10;
  #10ns
  if(registers.core[6] == 10) begin
    $display("%t YAY!! write: write %d to reg %d, output = %d, expected = %d",$time, Wdat, Wd, registers.core[6], Wdat);
  end else begin
    $display("%t FAIL! write: write %d to reg %d, output = %d, expected = %d",$time, Wdat, Wd, registers.core[6], Wdat);
  end

  Wen = 0; 
  Ra = 6;

  #10ns 
  if(RdatA == 10) begin
    $display("%t YAY!! read: inputs = %d, outputs = %d, expected = 10",$time, Ra, RdatA);
  end else begin
    $display("%t FAIL! read: inputs = %d, outputs = %d, expected = 10",$time, Ra, RdatA);
  end
 
  #10ns $stop;			   
end

// digital system clock generator
always begin   // clock period = 10 Verilog time units
  #5ns  clk = 1;
  #5ns  clk = 0;
end
      
endmodule