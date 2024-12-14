//not sure if synthesizable- probably not

module regReadWright_tb;

// To DUT Inputs
  bit Reset;		      // 1: initialize; 0: run
  bit Clk				  // single systemwide clock

// From DUT Outputs
  wire Done;		      // done/finished flag

// Instantiate the Device Under Test (DUT)
  Top DUT (
	.Reset       (Reset), 
	.Clk         (Clk)  , 
	.Done        (Done)
	);
  logic [7:0] match_ct[6], match;
  logic [7:0] mymem[256]; // fake memory in testbench

  logic [3:0] waldo;	  // our 4-bit pattern
  logic [7:0] jaldo;	  // series of random 8-bit values
  
  int cycle_ct;           // clock cycle counter
initial begin
  Reset = 1'b1;		      // initialize PC; freeze everything temporarily

// Initialize DUT's data memory
// edit index limit for size other than 256 elements
  #10ns for(int i=0; i<256; i++) begin
    DUT.data.my_memory[i] = 8'h0;	     // clear data_mem
    mymem[i] = 8'b0;
  end  
  DUT.registers.registers_arr[0] = 1;
  DUT.registers.registers_arr[1] = 31;
  DUT.registers.registers_arr[2] = 96;
  DUT.registers.registers_arr[3] = 0;
  DUT.registers.registers_arr[4] = 0;
  DUT.registers.registers_arr[5] = 0;
  DUT.registers.registers_arr[6] = 0;
  DUT.registers.registers_arr[7] = 5;
// "Waldo" in pattern seek/match problem
  waldo = 4'b1111;//$random;
  DUT.data.my_memory[9][3:0] = waldo;
  mymem[9][3:0] = waldo;
  #10ns $display("our pattern is  %b",mymem[9][3:0]);
// load 64 random unsigned bytes into data_memory
  for(int j=32; j<96; j++) begin
    jaldo = $random;
    mymem[j] = jaldo;
    DUT.data.my_memory[j] = jaldo;  // 
	#10ns;// $displayb(mymem[j]);
  end
// students may also pre_load desired constants into any 
//  part of data_mem 
// initialize match counter/historgrammer
  for(int k=1; k<6; k++)
    match_ct[k] = 8'b0;
// Initialize DUT's register file
//  for(int j=0; j<16; j++)
//    DUT.reg_file1.registers[j] = 8'b0;    // default -- clear it
// students may pre-load desired constants into the reg_file
//   as shown above for my_memory[1:4]
    
// launch program in DUT
  #10ns start = 0;
// Wait for done flag, then display results
  #10ns wait (halt);
  #10ns for(int l=32; l<96; l++) begin
		  match=
		    (mymem[l][7:4]==waldo) + 
		    (mymem[l][6:3]==waldo) + 
		    (mymem[l][5:2]==waldo) + 
		    (mymem[l][4:1]==waldo) + 
		    (mymem[l][3:0]==waldo)  ;
//          $display("match ",match);
		  case(match)
		    1: match_ct[1]=match_ct[1]+1;
			2: match_ct[2]=match_ct[2]+1;
			3: match_ct[3]=match_ct[3]+1;
			4: match_ct[4]=match_ct[4]+1;
			5: match_ct[5]=match_ct[5]+1;
		  endcase	 
		end
// testbench's histogram
    	$display("testbench histogram: ",match_ct[1],,match_ct[2],,match_ct[3],,match_ct[4],,match_ct[5]);
// DUT's histogram
        $display("DUT       histogram: ",DUT.data.my_memory[10],,
				 DUT.data.my_memory[11],,
				 DUT.data.my_memory[12],,
				 DUT.data.my_memory[13],,
				 DUT.data.my_memory[14]);
        $display("cycle count = %d",cycle_ct);
//        $display("instruction = %d %t",DUT.PC,$time);
  #10ns $stop;			   
end

// digital system clock generator
always begin   // clock period = 10 Verilog time units
  #5ns  CLK = 1;
  #5ns  CLK = 0;
end

// clock cycle counter
always @(posedge CLK)
  if(!start && !halt)
    cycle_ct <= cycle_ct + 32'b1;
      
endmodule