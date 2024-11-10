module mux2x1 #(parameter WIDTH=8)(
  input logic [WIDTH-1:0] input0,
  input logic [WIDTH-1:0] input1,
  input logic sel,
  output logic [WIDTH-1:0] out
);

  always @(sel or input0) begin
    if(sel)
      out = input1;
    else
      out = input0;
  end
endmodule
