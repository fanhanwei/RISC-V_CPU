module PC(	clk,
				reset,
				pc,
				inst_addr,
				En
				);
				
	input wire clk;
	input wire reset;
	input wire En;
	input wire [63:0] pc;
	
	output reg [63:0] inst_addr;
	
	always @(posedge clk or negedge reset)
		 begin
			  if (!reset)
					begin
						 inst_addr <= 64'd0;
					end
				else if (En)
							begin
								inst_addr <= pc;
							end
						else
							begin
								inst_addr <= inst_addr;
							end
		 end
endmodule
			  