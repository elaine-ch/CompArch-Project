// Test bench
// Program Counter (Instruction Fetch)

module ProgCtr_tb;

`timescale 1ns/ 1ps

// Define signals to interface with UUT
bit Reset;
bit Start;
bit Clk;
bit BranchEn;
bit [9:0] TargetOrOffset;
logic [9:0] NextInstructionIndex;

// Instatiate and connect the Unit Under Test
ProgCtr uut (
  .Reset(Reset),
  .Clk(Clk),
  .Jen(BranchEn),
  .Jump(TargetOrOffset),
  .PC(NextInstructionIndex)
);

integer ClockCounter = 0;
always @(posedge Clk)
  ClockCounter <= ClockCounter + 1;

// The actual testbench logic
//
// In this testbench, let's look at 'manual clocking'
initial begin
  // Time 0 values
  $display("Initialize Testbench.");
  Reset = '1;
  Start = '0;
  Clk = '0;
  BranchEn = '0;
  TargetOrOffset = '0;

  // Advance to simulation time 1, latch values
  #1 Clk = '1;

  // Advance to simulation time 2, check results, prepare next values
  #1 Clk = '0;
  $display("Checking Reset behavior");
  $display("Expected: 0\n %d", NextInstructionIndex);
  assert (NextInstructionIndex == 'd0);
  Reset = '0;

  // Advance to simulation time 3, latch values
  #1 Clk = '1;

  // Advance to simulation time 4, check results, prepare next values
  #1 Clk = '0;
  $display("Checking that nothing happens before Start");
  $display("Expected: 1\n %d", NextInstructionIndex);
  assert (NextInstructionIndex == 'd1);
  Start = '1;

  // Advance to simulation time 5, latch values
  #1 Clk = '1;

  // Advance to simulation time 6, check results, prepare next values
  #1 Clk = '0;
  $display("Checking that nothing happened during Start");
  $display("Expected: 2\n %d", NextInstructionIndex);
  assert (NextInstructionIndex == 'd2);
  Start = '0;

  // Advance to simulation time 7, latch values
  #1 Clk = '1;

  // Advance to simulation time 8, check outputs, prepare next values
  #1 Clk = '0;
  $display("Checking that first Start went to first program");
  $display("Expected: 3\n %d", NextInstructionIndex);
  assert (NextInstructionIndex == 'd003);
  // No change in inputs

  // Advance to simulation time 9, latch values
  #1 Clk = '1;

  // Advance to simulation time 10, check outputs, prepare next values
  #1 Clk = '0;
  $display("Checking that PC advanced by 1");
  $display("Expected: 4\n %d", NextInstructionIndex);
  assert (NextInstructionIndex == 'd004);
  BranchEn = '1;
  TargetOrOffset = 'd10;

  // Latch, check, setup next test
  #1 Clk = '1;
  #1 Clk = '0;
  $display("Checking that branch went to target");
  $display("Expected: 10\n %d", NextInstructionIndex);
  assert (NextInstructionIndex == 'd10);
  BranchEn = '0;
  TargetOrOffset = 'd5;

  // Latch, check, setup next test
  #1 Clk = '1;
  #1 Clk = '0;
  $display("Checking that branch with no enable did not jump");
  $display("Expected: 11\n %d", NextInstructionIndex);
  assert (NextInstructionIndex == 'd11);
  BranchEn = '1;
  TargetOrOffset = 'd5;

  // Latch, check, setup next test
  #1 Clk = '1;
  #1 Clk = '0;
  $display("Checking that relative branch with ALU flag did jump");
  $display("Expected: 5\n %d", NextInstructionIndex);
  assert (NextInstructionIndex == 'd5);

  $display("All checks passed.");
end

initial begin
  $dumpfile("ProgCtr.vcd");
  $dumpvars();
  $dumplimit(104857600); // 2**20*100 = 100 MB, plenty.
end

endmodule
