`timescale 1ns/ 1ps

// Test bench
// Arithmetic Logic Unit

//
// INPUT: A, B
// op: 000, A ADD B
// op: 100, A_AND B
// ...
// Please refer to definitions.sv for support ops (make changes if necessary)
// OUTPUT A op B
// equal: is A == B?
// even: is the output even?

module ALU_tb;

// Define signals to interface with the ALU module
logic [ 7:0] INPUTA;  // data inputs
logic [ 7:0] INPUTB;
logic [ 2:0] op;      // ALU opcode, part of microcode
wire[ 7:0] OUT;
wire Zero;
wire Par;
logic SCo;

// Define a helper wire for comparison
logic [ 7:0] expected;

// Instatiate and connect the Unit Under Test
ALU uut(
  .DatA(INPUTA),
  .DatB(INPUTB),
  .Aluop(op),
  .Rslt(OUT),
  .Zero(Zero),
  .Par(Par),
  .SCo(SCo)
);


// The actual testbench logic
initial begin
  INPUTA = 1;
  INPUTB = 1;
  op= 'b000; // ADD
  test_alu_func; // void function call
  #5;

  INPUTA = 4;
  INPUTB = 1;
  op= 'b100; // AND
  test_alu_func; // void function call
  #5;

  INPUTA = 4;
  INPUTB = 1;
  op= 'b011; // SUB
  test_alu_func; // void function call
  #5;

  INPUTA = 4;
  INPUTB = 1;
  op= 'b101; // OR
  test_alu_func; // void function call
  #5;

  INPUTA = 3;
  INPUTB = 12;
  op= 'b1010000; // LSH
  test_alu_func; // void function call
  #5;

  INPUTA = 2;
  INPUTB = 8;
  op= 'b10; // RSH
  test_alu_func; // void function call
  #5;

  INPUTA = 4;
  INPUTB = 1;
  op= 'b11; // CMP
  test_alu_func; // void function call
  #5;

  INPUTA = 4;
  INPUTB = 4;
  op= 'b00; // CMP
  test_alu_func; // void function call
  #5;
end

task test_alu_func;
  case (op)
    0: expected = INPUTA & INPUTB;      // AND
    1: expected = INPUTA + INPUTB;      // ADD
    2: expected = INPUTA - INPUTB;      // SUB
    3: expected = INPUTA | INPUTB;      // OR
    4: {SCo, expected} = INPUTB << INPUTA; // LSH
    5: {expected, SCo} = INPUTB >> INPUTA;  // RSH
    6: begin
        expected[0] = (INPUTA != INPUTB) ? 1 : 0;
				expected[1] = (INPUTA > INPUTB) ? 1 : 0;
      end//CMP
  endcase
  #1;
  if(expected == OUT) begin
    $display("%t YAY!! inputs = %h %h, opcode = %b, Zero %b",$time, INPUTA,INPUTB,op, Zero);
  end else begin
    $display("%t FAIL! inputs = %h %h, opcode = %b, zero %b",$time, INPUTA,INPUTB,op, Zero);
  end
endtask

initial begin
  $dumpfile("alu.vcd");
  $dumpvars();
  $dumplimit(104857600); // 2**20*100 = 100 MB, plenty.
end

endmodule
