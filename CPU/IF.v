module IF( 	clk,
				reset_n,
				b_j_Result,
				pc_src,
				inst,
				stall,
				pc_current
				);
				
input wire clk;
input wire reset_n;
input wire stall;
input wire pc_src;
input wire[63:0] b_j_Result;

output wire[31:0] inst;
output wire[63:0] pc_current;

wire [63:0] inst_addr;
wire [63:0] pc;

assign pc_current = (inst_addr);

IF_mux IF_mux(	.pc_old(inst_addr),
					.b_j_dest(b_j_Result),
					.select(pc_src),
					.pc_new(pc)
					);
			
			
PC PC(	.clk(clk),
			.reset(reset_n),
			.En(!stall),
			.pc(pc),
			.inst_addr(inst_addr)
			);
	
inst_mem inst_mem(	.address(inst_addr[7:2]),
							.clock(~clk),
							.q(inst)
							);
					
endmodule
