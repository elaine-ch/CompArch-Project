module Top(
  input Clk, Reset,
  output logic Done);

wire[5:0] Jump, PC;
wire[2:0] Ra, Rb, Wd;
wire[2:0] Aluop;
wire[8:0] mach_code;
wire[7:0] DatA, DatB, Rslt, RdatA, RdatB, WdatR, WdatD, Rdat, Jptr ,Addr;	
wire Jen, Par, SCo, Zero, WenR, WenD, MemToReg;

assign  DatA = RdatA;
assign  DatB = RdatB; 

JLUT JL1(
  .Jptr,
  .Jump);

ProgCtr PC1(
  .Clk,
  .Reset,
  .Jen,
  .Jump,
  .PC);

InstROM IR1(
  .PC,
  .mach_code);

Ctrl C1(
  .mach_code,
  .Aluop,
  .Jptr,
  .Ra,
  .Rb,
  .Wd,
  .WenR,
  .WenD,
  .MemToReg, 
  .Jen, 
  .Done
);

RegFile RF1(
  .Clk,
  .Wen(WenR),
  .Ra,
  .Rb,
  .Wd,
  .Wdat(WdatR),
  .RdatA,
  .RdatB
);

ALU A1(
  .Aluop,
  .DatA,
  .DatB,
  .Rslt,
  .Zero,
  .Par,
  .SCo);

DatMem DM1(
  .in (WdatD),
  .Clk,
  .wr_en (WenD),
  .addr (Addr),
  .out (Rdat)
);

mux2x1 M1(
    .input0(Rdat),
    .input1(Rslt),
    .sel(MemToReg),
    .out(WdatR)
);

endmodule
