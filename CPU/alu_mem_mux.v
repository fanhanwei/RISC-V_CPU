module alu_mem_mux(	alu_data,
							mem_data,
							select_signal,
							outdata
							);
							
input wire[63:0] alu_data;
input wire[63:0] mem_data;
input wire select_signal;

output wire[63:0] outdata;

assign outdata = (select_signal)? mem_data : alu_data;
endmodule
