module forward_muxB ( 	ex,
								mem,
								wb,
								se,
								rs2out
								);
								
input wire[63:0] ex;
input wire[63:0] mem;
input wire[63:0] wb;
input wire[1:0] se;

output reg[63:0] rs2out;

always @(*)
begin
	case(se)
		2'b10:rs2out <= mem;
		2'b01:rs2out <= wb;
		2'b00:rs2out <= ex;
	endcase
end

endmodule
