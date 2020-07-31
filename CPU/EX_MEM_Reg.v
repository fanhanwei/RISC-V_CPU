module EX_MEM_Reg (	clk,
							clr,
							rst_n,
							p1,
							p2,
							p3,
							p4,
							alu_result_ex,
							writedata_ex,
							rd_ex_ex,
							RegRs2_ex,
							memtoreg_mem,
							memread_mem,
							memwrite_mem,
							regwrite_mem,
							alu_result_mem,
							writedata_mem,
							rd_mem,
							RegRs2_mem
							);

input wire clk;
input wire clr;
input wire rst_n;
input wire p1;
input wire p2;
input wire p3;
input wire p4;
input wire[63:0] alu_result_ex;
input wire[63:0] writedata_ex;
input wire[4:0] rd_ex_ex;
input wire[4:0] RegRs2_ex;

output wire memtoreg_mem;
output wire memread_mem;
output wire memwrite_mem;
output wire regwrite_mem;
output wire[63:0] alu_result_mem;
output wire[63:0] writedata_mem;
output wire[4:0] rd_mem;
output wire[4:0] RegRs2_mem;

floprc1 D1(	.clk(clk),.rst_n(rst_n),.clear(clr),.d(p1),.q(memtoreg_mem));
floprc1 D2(	.clk(clk),.rst_n(rst_n),.clear(clr),.d(p2),.q(memread_mem));
floprc1 D3(	.clk(clk),.rst_n(rst_n),.clear(clr),.d(p3),.q(memwrite_mem));
floprc1 D4(	.clk(clk),.rst_n(rst_n),.clear(clr),.d(p4),.q(regwrite_mem));
floprc #(64) D5(	.clk(clk),.rst_n(rst_n),.clear(clr),.d(alu_result_ex),.q(alu_result_mem));
floprc #(64) D6(	.clk(clk),.rst_n(rst_n),.clear(clr),.d(writedata_ex),.q(writedata_mem));
floprc #(5) D7(	.clk(clk),.rst_n(rst_n),.clear(clr),.d(rd_ex_ex),.q(rd_mem));
floprc #(5) D10(	.clk(clk),.rst_n(rst_n),.clear(clr),.d(RegRs2_ex),.q(RegRs2_mem));
endmodule
