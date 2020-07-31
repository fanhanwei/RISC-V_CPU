module MEM_WB_Reg (	clk,
							clr,
							rst_n,
							p1,
							p2,
							mem_data,
							alu_data,
							rd_mem_mem,
							memtoreg_wb,
							regwrite_wb,
							mem_data_W,
							alu_out,
							rd_wb
							);
							
input wire clk;
input wire clr;
input wire rst_n;
input wire p1;
input wire p2;
input wire[63:0] mem_data;
input wire[63:0] alu_data;
input wire[4:0] rd_mem_mem;

output wire memtoreg_wb;
output wire regwrite_wb;
output wire[63:0] mem_data_W;
output wire[63:0] alu_out;
output wire[4:0] rd_wb;

floprc1 D1(	.clk(clk),.rst_n(rst_n),.clear(clr),.d(p1),.q(memtoreg_wb));
floprc1 D2(	.clk(clk),.rst_n(rst_n),.clear(clr),.d(p2),.q(regwrite_wb));

floprc #(64) D5(	.clk(clk),.rst_n(rst_n),.clear(clr),.d(mem_data),.q(mem_data_W));
floprc #(64) D6(	.clk(clk),.rst_n(rst_n),.clear(clr),.d(alu_data),.q(alu_out));
floprc #(5) D7(	.clk(clk),.rst_n(rst_n),.clear(clr),.d(rd_mem_mem),.q(rd_wb));

endmodule
