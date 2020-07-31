module IF_ID_Reg(	clk,
						clr,
						rst_n,
						en,
						inst_new,
						pc_new,
						inst_old,
						pc_old
						);
						
input wire clk;
input wire clr;
input wire rst_n;
input wire en;
input wire[31:0] inst_new;
input wire[63:0] pc_new;

output reg[31:0] inst_old;
output reg[63:0] pc_old;

always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			inst_old <= 32'd0;
			pc_old <= 64'd0;
		end
	else if(clr)
				begin
					inst_old <= 32'd0;
					pc_old <= 64'd0;
				end
			else if(en)
						begin
							inst_old <= inst_new;
							pc_old <= pc_new;
						end
				  else
				  		begin
							inst_old <= inst_old;
							pc_old <= pc_old;
						end
end

endmodule

	
	
		