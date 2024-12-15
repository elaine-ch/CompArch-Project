module ALU(
  input Ldcen,
  input [2:0] Aluop,
  input [4:0] LdcVal, 
  input [7:0] DatA, DatB,
  output logic[7:0] Rslt);

always_comb begin
	Rslt = 8'b0;
	if (Ldcen) begin
		Rslt = {LdcVal[4],3'b000,LdcVal[3:0]};
	end
	else begin
		case(Aluop)
			3'b000: Rslt = DatA & DatB; // bitwise AND
			3'b001: Rslt = DatA + DatB; // add
			3'b010: Rslt = DatA - DatB; // sub (A-B)
			3'b011: Rslt = DatA | DatB; // bitwise OR
			3'b100: Rslt = DatB <<DatA; // left shift
			3'b101: Rslt = DatB >>DatA; // right shift
			3'b110: begin                     // compare
						Rslt[1] = (DatA != DatB) ? 1 : 0; // 1 for !=, 00 for ==
						Rslt[0] = (DatA > DatB) ? 1 : 0;  // 1 for >, 0 for <
						end
			3'b111: Rslt = DatA; // mov;
		endcase
	end
end

endmodule
