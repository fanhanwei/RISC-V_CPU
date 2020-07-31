module alu_opr2_mux(r2,imm,alu_scr,opr2);

input wire[63:0] r2;
input wire[63:0] imm;
input wire alu_scr;

output wire[63:0] opr2;

assign opr2 = (alu_scr)? imm : r2;
endmodule
