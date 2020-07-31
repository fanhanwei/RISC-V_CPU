module ID_EX_Reg (	  clk,
							  clr,
							  reset_n,
							  memtoreg,
							  memread,
							  memwrite,
							  branch,
							  alusrc,
							  regwrite,
							  aluop,
							  read_data1,
							  read_data2,
							  imm_data,
							  func_op,
							  pc_id,
							  rd,
							  rs1,
							  rs2,
							  lui_id,
							  auipc_id,
							  jal_id,
							  jalr_id,
							  q1,
							  q2,
							  q3,
							  q4,
							  q5,
							  q6,
							  q7,
							  q8,
							  q9,
							  q10,
							  q11,
							  q12,
							  q13,
							  q14,
							  q15,
							  q16,
							  q17,
							  q18,
							  q19
							  );
							  
input wire clk;
input wire clr;
input wire reset_n;
input wire memtoreg;
input wire memread;
input wire memwrite;
input wire branch;
input wire alusrc;
input wire regwrite;
input wire[1:0] aluop;
input wire[63:0] read_data1;
input wire[63:0] read_data2;
input wire[63:0] imm_data;
input wire[63:0] pc_id;
input wire[3:0] func_op;
input wire[4:0] rd;
input wire[4:0] rs1;
input wire[4:0] rs2;
input wire lui_id;
input wire auipc_id;
input wire jal_id;
input wire jalr_id;

output wire q1;
output wire q2;
output wire q3;
output wire q4;
output wire q5;
output wire q6;
output wire[1:0] q7;
output wire[63:0] q8;
output wire[63:0] q9;
output wire[63:0] q10;
output wire[3:0] q11;
output wire[4:0] q12;
output wire[63:0] q13;
output wire[4:0] q14;
output wire[4:0] q15;
output wire q16;
output wire q17;
output wire q18;
output wire q19;

floprc1 D1(	.clk(clk),.rst_n(reset_n),.clear(clr),.d(memtoreg),.q(q1));
floprc1 D2(	.clk(clk),.rst_n(reset_n),.clear(clr),.d(memread),.q(q2));
floprc1 D3(	.clk(clk),.rst_n(reset_n),.clear(clr),.d(memwrite),.q(q3));
floprc1 D4(	.clk(clk),.rst_n(reset_n),.clear(clr),.d(branch),.q(q4));
floprc1 D5(	.clk(clk),.rst_n(reset_n),.clear(clr),.d(alusrc),.q(q5));
floprc1 D6(	.clk(clk),.rst_n(reset_n),.clear(clr),.d(regwrite),.q(q6));
floprc1 D16( .clk(clk),.rst_n(reset_n),.clear(clr),.d(lui_id),.q(q16));
floprc1 D17( .clk(clk),.rst_n(reset_n),.clear(clr),.d(auipc_id),.q(q17));
floprc1 D18( .clk(clk),.rst_n(reset_n),.clear(clr),.d(jal_id),.q(q18));
floprc1 D19( .clk(clk),.rst_n(reset_n),.clear(clr),.d(jalr_id),.q(q19));

floprc #(2) D7(	.clk(clk),.rst_n(reset_n),.clear(clr),.d(aluop),.q(q7));
floprc #(64) D8(	.clk(clk),.rst_n(reset_n),.clear(clr),.d(read_data1),.q(q8));
floprc #(64) D9(	.clk(clk),.rst_n(reset_n),.clear(clr),.d(read_data2),.q(q9));
floprc #(64) D10(	.clk(clk),.rst_n(reset_n),.clear(clr),.d(imm_data),.q(q10));
floprc #(4) D11(	.clk(clk),.rst_n(reset_n),.clear(clr),.d(func_op),.q(q11));
floprc #(5) D12(	.clk(clk),.rst_n(reset_n),.clear(clr),.d(rd),.q(q12));
floprc #(64) D13(	.clk(clk),.rst_n(reset_n),.clear(clr),.d(pc_id),.q(q13));
floprc #(5) D14(	.clk(clk),.rst_n(reset_n),.clear(clr),.d(rs1),.q(q14));
floprc #(5) D15(	.clk(clk),.rst_n(reset_n),.clear(clr),.d(rs2),.q(q15));

endmodule

