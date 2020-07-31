`timescale 1 ns / 1 ns
module CPU_tb;
reg Clk;
reg rst_n;

wire [63:0] pc_if;
wire [31:0] inst_if;
wire [63:0] pc_id;
wire [31:0] inst_id;
wire [63:0] alu_outdata;
wire [63:0] mem_out_data;
CPU_risc_v test(
						.clk(Clk),
						.reset_n(rst_n),
						.pc_fetch(pc_if),
						.inst_fetch(inst_if),
						.pc_decode(pc_id),
						.inst_decode(inst_id),
						.alu_outdata(alu_outdata),
						.mem_out_data(mem_out_data)
					);
initial begin
Clk=1;rst_n=0;
#20;
rst_n=1;
Clk=1;
forever #20 Clk=~Clk;
end
endmodule
