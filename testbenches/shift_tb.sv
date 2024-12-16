module shift_tb();
  bit clk, reset = '1, req = '1;
  wire ack;
  logic[7:0] reg6, reg1;
			  
  Top f0(
    .Clk (clk),
    .Reset(reset),
    .Start(req),
    .Done (ack));

  always begin
    #5ns clk = '1;			 
	  #5ns clk = '0;
  end

  initial begin				

    //shift test with mach_code
    //exp in r2, mantissa in r0
    //ldc 01010
    //mov r6, r3
    //sub r3, r2
    //rst r2, r0
    //don

    // 110000110
    // 111001110
    // 110001110
    // 000100001
    // 101001111
    // 011111111
    
    f0.RF1.core[2] = 8;
    f0.RF1.core[0] = 'b11111111;

    #20ns reset = '0;
    req = '0;
    #20ns wait(ack);

    if(f0.RF1.core[0] == 'b00111111) begin
      $display("%t success!", $time); 
    end else begin
      $display("%t fail! reg6 = %d reg0 = %d reg2 = %d ", $time, f0.RF1.core[6], f0.RF1.core[0], f0.RF1.core[2], f0.RF1.core[3]);
    end

    $stop;
end
endmodule