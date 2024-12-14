module simpleAdder_tb();
  bit       clk       , 
            reset = '1,
            req;
  wire      ack,			 // my dummy done flag
			  
  Top f0(				 // my dummy DUT to generate right answer
    .clk  (clk),
    .reset(reset),
    .done (ack));	         // 

  always begin               // clock 
    #5ns clk = '1;			 
	#5ns clk = '0;
  end

  initial begin				 // test sequence
    
	f0.DM1.core[1] = 3;   // load operands into my memory
	f0.DM1.core[0] = 4;
    f0.RF1.core[6] = 0;
    f0.RF1.core[1] = 1;
    f0.RF7.core[7] = 0;

    #20ns reset = '0;
    #20ns wait(ack);

    if(f0.DM1.core[0] == 7) begin
        $display("%t success!", $time); 
    end else begin
        $display("%t fail! reg6 = %d reg0 = %d reg1 = %d reg7 = %d mem0 = %d mem1 = %d", f0.RF1.core[6], f0.RF1.core[0], f0.RF1.core[1], f0.RF1.core[7], f0.DM1.core[0], f0.DM1.core[1]);
    end
    $stop;
    end
endmodule