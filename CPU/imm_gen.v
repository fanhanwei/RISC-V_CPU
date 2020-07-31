module imm_gen(	inst,
						imm_data,
						);
						
input wire[31:0] inst;
output wire[63:0] imm_data;

wire[6:0] opcode = inst[6:0];
wire I,B,S,J,U;

reg[4:0] type;
assign {I,B,S,J,U} = type;

always @(*) 
begin
	case (opcode)
		7'b0000011:type <= 5'b10000;//I-type(load)
		7'b1100111:type <= 5'b10000;//I-type(JALR)
		7'b0010011:type <= 5'b10000;//I-type
		7'b1100011:type <= 5'b01000;//B-type
		7'b0100011:type <= 5'b00100;//S-type
		7'b1101111:type <= 5'b00010;//JAL
		7'b0110111:type <= 5'b00001;//U-type(lui)
		7'b0010111:type <= 5'b00001;//U-type(auipc)
		default:   type <= 5'b00000;//R-type
	endcase
end

assign imm_data[63:32] = (inst[31])? 32'hFFFFFFFF : 32'h00000000;
assign imm_data[31] = (inst[31])? 1'b1 : 1'b0;
assign imm_data[30:20] = (U)? inst[30:20] : {inst[31],inst[31],inst[31],inst[31],inst[31],inst[31],inst[31],inst[31],inst[31],inst[31],inst[31]};
assign imm_data[19:12] = (U|J)? inst[19:12] : {inst[31],inst[31],inst[31],inst[31],inst[31],inst[31],inst[31],inst[31]};
assign imm_data[10:5] = (U|(I&(inst[14:12]==3'b101)))? 6'b000000 : inst[30:25];

reg imm_data11;
reg[3:0] imm_data41;
reg imm_data0;

always @(*) 
begin 
	case (type)
		5'b10000:imm_data11 <= inst[31];//I
		5'b00100:imm_data11 <= inst[31];//S
		5'b01000:imm_data11 <= inst[7];//B
		5'b00001:imm_data11 <= 1'b0;//U
		5'b00010:imm_data11 <= inst[20];//J
		default: imm_data11 <= 1'b0;
	endcase
end

always @(*) 
begin 
	case (type)
		5'b10000:imm_data41 = inst[24:21];//I
		5'b00100:imm_data41 = inst[11:8];//S
		5'b01000:imm_data41 = inst[11:8];//B
		5'b00001:imm_data41 = 4'h0;//U
		5'b00010:imm_data41 = inst[24:21];//J
		default: imm_data41 = 4'h0;
	endcase
end

always @(*) 
begin 
	case (type)
		5'b10000:imm_data0 = inst[20];//I
		5'b00100:imm_data0 = inst[7];//S
		5'b01000:imm_data0 = 1'b0;//B
		5'b00001:imm_data0 = 1'b0;//U
		5'b00010:imm_data0 = 1'b0;//J
		default: imm_data0 = 1'b0;
	endcase
end

assign imm_data[11] = imm_data11;
assign imm_data[4:1] = imm_data41;
assign imm_data[0] = imm_data0;

endmodule


