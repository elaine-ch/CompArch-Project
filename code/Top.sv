module Top(
  input Clk, Reset, Start
  output logic Done);

wire[7:0] Jump, PC;
wire[2:0] Ra, Rb, Wd;
wire[2:0] Aluop;
wire[4:0] LdcVal;
wire[8:0] mach_code;
wire[7:0] DatA, DatB, Rslt, RdatA, RdatB, WdatR, Rdat, Jptr;	
wire Jen, Zero, WenR, WenD, RenD, MemToReg, Ldcen, StallCtr;

assign  DatA = RdatA;
assign  DatB = RdatB; 

JLUT JL1(
  .Jptr,
  .Jump);

ProgCtr PC1(
  .Clk,
  .Reset,
  .Jen,
  .Zero,
  .Jump,
  .Start,
  .StallCtr,
  .PC);

InstROM IR1(
  .PC,
  .mach_code);

Ctrl C1(
  .mach_code,
  .Aluop,
  .Jptr,
  .LdcVal,
  .Ra,
  .Rb,
  .Wd,
  .WenR,
  .WenD,
  .RenD, 
  .MemToReg, 
  .Jen, 
  .Ldcen, 
  .Done, 
  .Start,
  .stall(StallCtr)
);

RegFile RF1(
  .Clk,
  .Wen(WenR),
  .Ra,
  .Rb,
  .Wd,
  .Wdat(WdatR),
  .Zero,
  .RdatA,
  .RdatB
);

ALU A1(
  .Aluop,
  .DatA,
  .DatB,
  .Ldcen,
  .LdcVal,
  .Rslt);

DatMem DM1(
  .in (RdatB),
  .Clk,
  .wr_en (WenD),
  .RenD, 
  .addr (RdatA),
  .out (Rdat)
);

// load data_mem to reg
mux2x1 M1(
    .input0(Rdat),
    .input1(Rslt),
    .sel(MemToReg),
    .out(WdatR),
    .clk(Clk)
);

endmodule
