module Control ( opcode,
					  memtoreg,
					  memread,
					  memwrite,
					  branch,
					  alusrc,
					  regwrite,
					  aluop,
					  lui,
					  auipc,
					  jal,
					  jalr
					  );
					  
input wire[6:0] opcode;

output wire memtoreg;
output wire memread;
output wire memwrite;
output wire branch;
output wire alusrc;
output wire regwrite;
output wire[1:0] aluop;

output wire lui;
output wire auipc;
output wire jal;
output wire jalr;

reg[11:0] controls;
assign {regwrite,memtoreg,alusrc,memread,memwrite,branch,aluop,lui,auipc,jal,jalr} = controls;

always @(*) 
begin
	case (opcode)
		7'b0110011:controls <= 12'b10000010_0000;//R-type
		7'b0000011:controls <= 12'b11110000_0000;//LW
		7'b0100011:controls <= 12'b00101000_0000;//SW
		7'b1100011:controls <= 12'b00000101_0000;//B-type
		7'b0010011:controls <= 12'b10100011_0000;//I-type
		
		7'b0110111:controls <= 12'b10100000_1000;//lui
		7'b0010111:controls <= 12'b10100000_0100;//auipc		
		7'b1101111:controls <= 12'b10100000_0010;//JAL
		7'b1100111:controls <= 12'b10100000_0001;//JALR
		
		default:  controls <= 12'b00000000_0000;//illegal op
	endcase
end
endmodule
