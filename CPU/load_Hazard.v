module load_Hazard(		ID_EX_Memread,
								ID_EX_RegRd,
								IF_ID_RegRs1,
								IF_ID_RegRs2,
								MemWrite,
								Jal,
								I,
								stall
								);
								
input wire ID_EX_Memread;
input wire MemWrite;
input wire Jal;
input wire I;
input wire[4:0] ID_EX_RegRd;
input wire[4:0] IF_ID_RegRs1;
input wire[4:0] IF_ID_RegRs2;

output reg stall;
								
always @(*)
begin
	if(ID_EX_Memread&(~Jal)&&(ID_EX_RegRd != 5'd0)&
		((ID_EX_RegRd == IF_ID_RegRs1)|
			((ID_EX_RegRd == IF_ID_RegRs2)&(~MemWrite)&(~I))))
		begin
			stall <= 1'b1;
		end
	else
		begin
			stall <= 1'b0;
		end
end

endmodule
