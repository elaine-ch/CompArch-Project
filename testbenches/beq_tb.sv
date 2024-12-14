module simpleAdder_tb();
  bit       clk       , 
            reset = '1,
            req;
  wire      ack;			 
			  
  Top f0(				 
    .Clk  (clk),
    .Reset(reset),
    .Done (ack));	         

  always begin               
    #5ns clk = '1;			 
	#5ns clk = '0;
  end

  initial begin				
    //beq test with mach_code
    // 111000101
    // 100000000
    // 000101001
    // 000101001
    // 011111111
    
    f0.RF1.core[0] = 0;
    f0.RF1.core[1] = 1;

    #20ns reset = '0;
    #20ns wait(ack);

    if(f0.DM1.core[1] == 1) begin
        $display("%t success!", $time); 
    end else begin
        $display("%t fail! reg5 = %d reg0 = %d reg1 = %d", $time, f0.RF1.core[5], f0.RF1.core[0], f0.RF1.core[1]);
    end

    $stop;
end
endmodule