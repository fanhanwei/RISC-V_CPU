module ALU_Control ( aluop,
							func_op,
							lui,
							op
							);
							
input wire[1:0] aluop;
input wire[3:0] func_op;
input lui;
reg[3:0] opR;
reg[3:0] opI;
output reg[3:0] op;

always @(*) 
begin 
	case(func_op)
		4'b0111:opR <= 4'b0000;//and
		4'b0110:opR <= 4'b0001;//or
		4'b0000:opR <= 4'b0010;//add
		4'b0001:opR <= 4'b0011;//sll
		4'b0010:opR <= 4'b0100;//slt
		4'b0011:opR <= 4'b0101;//sltu
		4'b1000:opR <= 4'b0110;//sub
		4'b0100:opR <= 4'b0111;//xor
		4'b0101:opR <= 4'b1000;//srl
		4'b1101:opR <= 4'b1001;//sra
		default:opR <= 4'b0010;
	endcase
end

always @(*) 
begin 
	case(func_op)
		4'bx111:opI <= 4'b0000;//andi
		4'bx110:opI <= 4'b0001;//ori
		4'bx000:opI <= 4'b0010;//addi
		4'bx010:opI <= 4'b0100;//slti
		4'bx011:opI <= 4'b0101;//sltiu
		4'bx100:opI <= 4'b0111;//xori
		4'b0001:opI <= 4'b0011;//slli
		4'b0101:opI <= 4'b1000;//srli
		4'b1101:opI <= 4'b1001;//srai
		default:opI <= 4'b0010;
	endcase	
end


always @(*)
begin
	if({lui,aluop} == 3'b000)
		begin
			op <= 4'b0010;
		end
		
	if(aluop == 2'b01)
		begin
			op <= 4'b0110;
		end
		
	if(aluop == 2'b10)
		begin
			op <= opR;
		end
		
	if(aluop == 2'b11)
		begin
			op <= opI;
		end
	if({lui,aluop} == 3'b100)
		begin
			op <= 4'b1010;
		end
end
endmodule
