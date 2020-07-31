module PC_add(	pc,
					imm,
					ZF,
					SF,
					CF,
					branch,
					func_op,
					jal,
					jalr,
					se,
					pc_result
					);
					
input wire[63:0] pc;
input wire[63:0] imm;
input wire[3:0] func_op;
input wire ZF;
input wire SF;
input wire CF;
input wire branch;
input wire jal;
input wire jalr;

output wire se;
output wire[63:0] pc_result;

reg b_se;

assign pc_result = pc + imm;
assign se = b_se | jal | jalr;

always @(*) 
begin 
	case(func_op[2:0])
		3'b000:b_se <= branch & ZF;//beq
		3'b001:b_se <= branch &(~ZF);//bne
		3'b100:b_se <= branch & SF;//blt
		3'b101:b_se <= branch &(~SF);//bge
		3'b110:b_se <= branch & CF;//bltu
		3'b111:b_se <= branch &(~CF);//bgeu
		default:b_se<= 1'b0;//pc=pc+4
	endcase
end

endmodule
