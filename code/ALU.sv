module ALU(
  input [2:0] Aluop,
  input [7:0] DatA,
              DatB,
  output logic[7:0] Rslt,
  output logic      Zero,
                    Par,
			        SCo);

always_comb begin
  Rslt = 8'b0;
  SCo  = 1'b0;
  case(Aluop)
   3'b000: {SCo,Rslt} = DatA + DatB;   // add
   3'b001: {SCo,Rslt} = DatA<<DatB;   // left shift
   3'b010: Rslt       = DatA & DatB;   // bitwise AND
   3'b011: Rslt       = DatA | DatB;   // bitwise OR
   3'b100: {SCo,Rslt} = DatA - DatB;  // sub (A-B)
   3'b101: {Rslt,SCo} = DatA>>DatB;	// right shift
   3'b110: begin
             Rslt[0] = (DatA != DatB) ? 1 : 0;
             Rslt[1] = (DatA > DatB) ? 1 : 0;
           end
  endcase
end

  assign Zero = !Rslt;
  assign Par  = ^Rslt;

endmodule
