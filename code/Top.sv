module Top(
  input Clk, Reset,
  output logic Done);

wire[5:0] Jump, PC;
wire[2:0] Ra, Rb, Wd;
wire[2:0] Aluop;
wire[8:0] mach_code;
wire[7:0] DatA, DatB, Rslt, RdatA, RdatB, WdatR, WdatD, Rdat, Jptr,Addr;	
wire JEn, Par, SCo, Zero, WenR, WenD, Ldr, Str;

assign  DatA = RdatA;
assign  DatB = RdatB; 
assign  WdatR = Rslt; 

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
  .Ldr,
  .Str);

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
  .Clk,
  .Wen (WenD),
  .WDat(WdatD),
  .Addr,
  .Rdat);


endmodule
