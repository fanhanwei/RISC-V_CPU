module floprc #(parameter WIDTH = 63)(	clk,
													rst_n,
													clear,
													d,
													q
													);

input wire clk,rst_n,clear;
input wire[WIDTH-1:0] d;
output reg[WIDTH-1:0] q;													 
													 
	always @(posedge clk,negedge rst_n)
	begin
		if(!rst_n) 
			begin
				q <= 0;
			end 
		else if (clear)
				begin
					q <= 0;
				end 
			else
				begin 
					q <= d;
				end
	end
endmodule
