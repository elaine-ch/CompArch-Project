module componentExtract_tb();
  bit   clk = '0, 
        reset='1,
        req;
  wire  ack0,					 // from my dummy DUT
        ack;					 // from your DUT
  bit[15:0] flt_in = '0;
  logic sign;
  logic signed[5:0] exp;		 // de-biased exponent in
  logic[10:0] mant;              // significand in
  real int_equiv;                // computed value of integer 
  real mant2;					 // real equiv. of mant.
  logic signed[15:0] int_out;			 // two's comp. result
  int  score0, score1, 
       count;
 			 
  Top f3(.Clk(clk),			 // your DUT goes here
    .Reset (reset),
    .Start (req  ),
    .Done  (ack) );

  always begin
    #5ns clk = 1;
	#5ns clk = 0;
  end

  initial begin
    #20ns reset = '0;
	flt_in = '0;
    disp;	                       // task call
	flt_in = 16'b0_01111_0000000000;
    disp;

    flt_in = 16'b0_10000_0000000000;
    disp;
    flt_in = 16'b0_10000_1000000000;
    disp;

    flt_in = 16'b0_10000_0001000000;
    disp;
    flt_in = 16'b0_10000_0001000000;
    disp;

	flt_in = 16'b0_10010_1100000000;
	disp;
	flt_in = 16'b0_10010_1110000000;
	disp;
	flt_in = 16'b0_11000_1100000000;
	disp;
	flt_in = 16'b0_11001_1100000000;
	disp;
	flt_in = 16'b0_11101_1110000000;
	disp;
	flt_in = 16'b0_11110_1110000000;
	disp;
	flt_in = 16'h8000;
    disp;	                       // task call
	flt_in = 16'b1_01111_0000000000;
    disp;

	flt_in = 16'b1_01111_0100000000;
    disp;

    flt_in = 16'b1_10000_0000000000;
    disp;
    flt_in = 16'b1_10000_1000000000;
    disp;

    flt_in = 16'b1_10000_0001000000;
    disp;
    flt_in = 16'b1_10000_0001000000;
    disp;

	flt_in = 16'b1_10010_1100000000;
	disp;
	flt_in = 16'b1_10010_1110000000;
	disp;
	flt_in = 16'b1_11000_1100000000;
	disp;
	flt_in = 16'b1_11001_1100000000;
	disp;
	flt_in = 16'b1_11101_1110000000;
	disp;
	flt_in = 16'b1_11110_1110000000;
	disp;
	#20ns $display("correct %d out of total %d",score0,count); 
		  $display("correct %d out of total %d",score1,count);
	$stop; 
  end
  task disp();
    #10ns req = '1;
    {f3.DM1.core[5],f3.DM1.core[4]} = flt_in;
    #10ns req = '0;
    sign      = flt_in[15];
    exp       = flt_in[14:10];  
    // mant[10]  = |flt_in[14:10];	         // restore hidden bit
    // mant[9:0] = flt_in[ 9: 0];	         // parse mantissa fraction
    mant2     = mant/1024.0;	         // equiv. floating point value of mant.
	wait(ack);
  //   if(exp>14) begin
  //     if(sign) int_out = -32768;         // max neg. trap        
  //     else     int_out =  32767;		 // max pos. trap
  //   end
  //   else begin
	// int_equiv = mant2 * 2**exp;
	// int_out   = sign? -int_equiv : int_equiv;
	// end
    #20ns $display("inserted mant: %b exp: %b sign: %b",mant, exp, sign);
          $display("original binary = %b_%b_%b",flt_in[15],flt_in[14:10],flt_in[9:0]);
    #20ns $display("my mant: %b exp: %b sign: %b",{f3.RF1.core[0],f3.RF1.core[1]},
        f3.RF1.core[3],f3.RF1.core[4]);      
    count++;
	if({f3.RF1.core[0],f3.RF1.core[1]} == mant && f3.RF1.core[3] == exp && f3.RF1.core[4] == sign) score0++;
	$display("ct = %d, score = %d",count,score0);
  endtask
endmodule