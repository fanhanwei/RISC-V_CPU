module forward_muxA ( 	ex,
								mem,
								wb,
								se,
								rs1out
								);
								
input wire[63:0] ex;
input wire[63:0] mem;
input wire[63:0] wb;
input wire[1:0] se;

output reg[63:0] rs1out;

always @(*)
begin
	case(se)
		2'b10:rs1out <= mem;
		2'b01:rs1out <= wb;
		2'b00:rs1out <= ex;
	endcase
end

endmodule
