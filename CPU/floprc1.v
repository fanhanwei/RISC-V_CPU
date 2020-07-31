module floprc1 (	clk,
						rst_n,
						clear,
						d,
						q
						);

input clk,rst_n,clear;
input wire d;
output reg q;
						 				 
	always @(posedge clk,negedge rst_n) begin
		if(!rst_n) begin
			q <= 0;
		end else if (clear)begin
			q <= 0;
		end else begin 
			q <= d;
		end
	end
endmodule
