module rTypeOp_tb();
  bit       clk       , 
            reset = '1,
            req;
  wire      ack;			 // my dummy done flag
  logic[7:0] reg6, reg1;
			  
  Top f0(				 // my dummy DUT to generate right answer
    .Clk  (clk),
    .Reset(reset),
    .Done (ack));	         // 

  always begin               // clock 
    #5ns clk = '1;			 
	#5ns clk = '0;
  end

  initial begin				

    //ldr test with mach_code
    // 110001110
    // 011111111

    // f0.DM1.core[0] = 1;
    // f0.RF1.core[6] = 0;
    // f0.RF1.core[1] = 0;

    // reg6 = f0.RF1.core[6];
    // reg1 = f0.RF1.core[1];

    // #10ns reset = '0;
    // #10ns wait(ack);

    // if(f0.RF1.core[1] == 1) begin
    //     $display("%t success!", $time); 
    // end else begin
    //     $display("%t fail! reg6 = %d reg1 = %d mem0 = %d", $time, f0.RF1.core[6], f0.RF1.core[1], f0.DM1.core[0]);
    // end

    //mov test with mach_code
    // 111001110
    // 011111111

    // f0.RF1.core[1] = 3;
    // f0.RF1.core[6] = 0;

    // #10ns reset = '0;
    // #10ns wait(ack);

    // if(f0.RF1.core[6] == 3) begin
    //     $display("%t success!", $time); 
    // end else begin
    //     $display("%t fail! reg6 = %d reg1 = %d", $time, f0.RF1.core[6], f0.RF1.core[1]);
    // end

    //add test with mach_code
    // 110000110
    // 111001110
    // 110001110
    // 000100001
    // 101001111
    // 011111111
    
	f0.DM1.core[1] = 3;   // load operands into my memory
	f0.DM1.core[0] = 4;
    f0.RF1.core[6] = 0;
    f0.RF1.core[1] = 1;
    f0.RF1.core[7] = 0;

    #20ns reset = '0;
    #20ns wait(ack);

    if(f0.DM1.core[1] == 7) begin
        $display("%t success!", $time); 
    end else begin
        $display("%t fail! reg6 = %d reg0 = %d reg1 = %d reg7 = %d mem0 = %d mem1 = %d", $time, f0.RF1.core[6], f0.RF1.core[0], f0.RF1.core[1], f0.RF1.core[7], f0.DM1.core[0], f0.DM1.core[1]);
    end

    $stop;
end
endmodule