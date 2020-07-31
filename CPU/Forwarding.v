module Forwarding(	EX_MEM_RegWrite,
							EX_MEM_RegRd,
							MEM_WB_RegWrite,
							MEM_WB_RegRd,
							ID_EX_RegRs1,
							ID_EX_RegRs2,
							MEM_WB_MEMtoReg,
							EX_MEM_RegRs2,
							ForwardA,
							ForwardB,
							Forward_M2M
							);
							
input wire EX_MEM_RegWrite;
input wire[4:0] EX_MEM_RegRd;

input wire MEM_WB_RegWrite;
input wire[4:0] MEM_WB_RegRd;

input wire[4:0] ID_EX_RegRs1;
input wire[4:0] ID_EX_RegRs2;

input wire MEM_WB_MEMtoReg;
input wire[4:0] EX_MEM_RegRs2;

output reg[1:0] ForwardA;
output reg[1:0] ForwardB;
output reg Forward_M2M;

always @(*)
begin
	if(EX_MEM_RegWrite & (EX_MEM_RegRd != 5'd0) & (EX_MEM_RegRd == ID_EX_RegRs1)) 
		begin
			ForwardA <= 2'b10;
		end
	else if (MEM_WB_RegWrite & (MEM_WB_RegRd != 5'd0) & (MEM_WB_RegRd == ID_EX_RegRs1))
				begin
					ForwardA <= 2'b01;
				end
			else 
				begin
					ForwardA <= 2'b00;
				end
end

always @(*)
begin
	if(EX_MEM_RegWrite & (EX_MEM_RegRd != 5'd0) & (EX_MEM_RegRd == ID_EX_RegRs2)) 
		begin
			ForwardB <= 2'b10;
		end
	else if (MEM_WB_RegWrite & (MEM_WB_RegRd != 5'd0) & (MEM_WB_RegRd == ID_EX_RegRs2))
				begin
					ForwardB <= 2'b01;
				end
			else 
				begin
					ForwardB <= 2'b00;
				end
end
							
always @(*)
begin
	if(MEM_WB_MEMtoReg & (MEM_WB_RegRd != 5'd0) & (MEM_WB_RegRd == EX_MEM_RegRs2))
		begin
			Forward_M2M <= 1'b1;
		end
	else
		begin
			Forward_M2M <= 1'b0;
		end
end
				
endmodule

		
		