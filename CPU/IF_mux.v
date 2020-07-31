module IF_mux(	pc_old,
					b_j_dest,
					select,
					pc_new
					);
					
		input wire [63:0] pc_old;
		input wire [63:0] b_j_dest;
		input wire select;
		output wire[63:0] pc_new;
		
		assign pc_new = (select)? b_j_dest : (pc_old+64'd4);
endmodule
