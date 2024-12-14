module JLUT_tb ();
  logic [7:0] key;
  wire [7:0] value;

  logic clk;

  JLUT DUT (.Jptr(key), .Jump(value));

  initial begin
    clk = 0;
    
    #10ns
    key = 0;
    #1ns
    $fdisplay("key: %d, value: %b", key, value);

    #10ns
    key = 1;
    #1ns
    $fdisplay("key: %d, value: %b", key, value);

    #10ns
    $stop;
  end

  always begin
    #1ns
    clk = ~clk;
  end

endmodule // JLUT_tb
