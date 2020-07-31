module CPU_risc_v(	clk,
							reset_n,
							pc_fetch,
							pc_decode,
							inst_fetch,
							inst_decode,
							alu_outdata,
							mem_out_data
						);
						
input wire clk;
input wire reset_n;

output wire[63:0] pc_fetch;
output wire[63:0] pc_decode;
output wire[31:0] inst_fetch;
output wire[31:0] inst_decode;
output wire[63:0] alu_outdata;
output wire[63:0] mem_out_data;

wire wen_regfile;
wire clr;
wire stall;
wire stall_load;

/************ IF stage variables ****************/
wire [31:0] inst_if;
wire [31:0] inst_id;
wire [63:0] pc_if;
wire [63:0] pc_id;
wire [63:0] pc_dest_itm;
wire [63:0] b_j_Result;
wire branch_pc_src;
wire [63:0] writeback_data;

/******************* ID stage variables ************/
wire[4:0] rs1_id;
wire[4:0] rs2_id;
wire[4:0] rd_id;
wire[6:0] opcode_id;
wire[3:0] func_op_id;

wire[63:0] imm_id;
wire I_id;
wire J_id;

wire[4:0] rd_final;
wire[63:0] oprand1;
wire[63:0] oprand2;


wire memread;
wire memwrite;
wire regwrite;

wire memtoreg_id;
wire memread_id;
wire memwrite_id;
wire branch_id;
wire alusrc_id;
wire regwrite_id;
wire[1:0] aluop_id;

wire lui_id;
wire lui_ex;
wire auipc_id;
wire auipc_ex;
wire jal_id;
wire jal_ex;
wire jalr_id;
wire jalr_ex;

/******************* EX stage Variables ***************/					
wire[63:0] r1_ex;
wire[63:0] r2_ex;	
wire[63:0] imm_ex;
wire[63:0] pc_ex;
wire[4:0] rd_ex;
wire[6:0] func_op_ex;
wire[1:0] aluop_ex;
wire alusrc_ex;
wire j_stall;
wire [63:0] b_Result;
wire [63:0] pc_j;

									
wire[3:0] alu_oprator;	
wire[63:0] alu_oprand1;	
wire[63:0] alu_oprand1_itm;
wire[63:0] alu_oprand2;	
wire[63:0] alu_oprand2_itm;	
wire alu_ZF;		
wire alu_SF;
wire alu_CF;

wire[63:0] alu_F;
wire[63:0] alu_result_ex;


wire[63:0] alu_result_mem;
wire[63:0] writedata_mem;
wire memread_mem;
wire memwrite_mem;
						
wire[63:0] MEM_writing_data;							
wire[63:0] mem_data;
wire memtoreg_mem;
wire regwrite_mem;
wire[4:0] rd_mem_mem;
wire[4:0] RegRs2_mem;

wire[4:0] ID_EX_RegRs1;
wire[4:0] ID_EX_RegRs2;

wire[63:0] mem_data_W;
wire[63:0] alu_out;
wire memtoreg_wb;

wire[1:0] ForwardA;
wire[1:0] ForwardB;
wire Forward_M2M;

assign stall = (reset_n)? stall_load : 1'b0;
assign clr = 1'b0;
	
IF IF( 	.clk(clk),
			.reset_n(reset_n),
			.b_j_Result(b_j_Result),
			.pc_src(branch_pc_src),
			.inst(inst_if),
			.stall(stall),
			.pc_current(pc_if)
			);
			
/*************************  IF part  *******************************/
	
IF_ID_Reg IF_ID_Reg(	.clk(clk),
							.clr(branch_pc_src),
							.rst_n(reset_n),
							.en(!stall),
							.inst_new(inst_if),
							.pc_new(pc_if),
							.inst_old(inst_id),
							.pc_old(pc_id)
							);

/**************************  ID part  **********************************/							

/************************  Decoder  ***********************/							
assign rs1_id = inst_id[19:15];
assign rs2_id = inst_id[24:20];
assign rd_id = inst_id[11:7];
assign opcode_id = inst_id[6:0];
assign func_op_id = {inst_id[30],inst_id[14:12]};
/*********************************************************/	

imm_gen imm_gen(	.inst(inst_id),
						.imm_data(imm_id)
						);
						
RegFile RF(   .Clk(clk),
				  .rst_n(reset_n),
				  .Write_en(wen_regfile),
				  .R_Addr_A(rs1_id),
				  .R_Addr_B(rs2_id),
				  .W_Addr(rd_final),
				  .W_Data(writeback_data),
				  .R_Data_A(oprand1),
				  .R_Data_B(oprand2)
				  );

Control Control(    .opcode(opcode_id),
						  .memtoreg(memtoreg_id),
						  .memread(memread),
						  .memwrite(memwrite),
						  .branch(branch_id),
						  .alusrc(alusrc_id),
						  .regwrite(regwrite),
						  .aluop(aluop_id),
						  .lui(lui_id),
						  .auipc(auipc_id),
						  .jal(jal_id),
						  .jalr(jalr_id)
						  );
						  
/*********************  control_signal_mux   **************************/
assign memread_id = (clr|stall)? 1'b0 : memread;
assign memwrite_id = (clr|stall)? 1'b0 : memwrite;
assign regwrite_id = (clr|stall)? 1'b0 : regwrite;
/**********************************************************************/
						  
ID_EX_Reg ID_EX_Reg(	  .clk(clk),
							  .clr(branch_pc_src),
							  .reset_n(reset_n),
							  .memtoreg(memtoreg_id),
							  .memread(memread_id),
							  .memwrite(memwrite_id),
							  .branch(branch_id),
							  .alusrc(alusrc_id),
							  .regwrite(regwrite_id),
							  .aluop(aluop_id),
							  .read_data1(oprand1),
							  .read_data2(oprand2),
							  .imm_data(imm_id),
							  .func_op(func_op_id),
							  .rd(rd_id),
							  .rs1(rs1_id),
							  .rs2(rs2_id),
							  .pc_id(pc_id),
							  .lui_id(lui_id),
							  .auipc_id(auipc_id),
							  .jal_id(jal_id),
							  .jalr_id(jalr_id),
							  .q1(memtoreg_ex),
							  .q2(memread_ex),
							  .q3(memwrite_ex),
							  .q4(branch_ex),
							  .q5(alusrc_ex),
							  .q6(regwrite_ex),
							  .q7(aluop_ex),
							  .q8(r1_ex),
							  .q9(r2_ex),
							  .q10(imm_ex),
							  .q11(func_op_ex),
							  .q12(rd_ex),
							  .q13(pc_ex),
							  .q14(ID_EX_RegRs1),
							  .q15(ID_EX_RegRs2),
							  .q16(lui_ex),
							  .q17(auipc_ex),
							  .q18(jal_ex),
							  .q19(jalr_ex)
							  );						
/****************************  EX part  ****************************************/			
			
ALU_Control alu_control( 	.aluop(aluop_ex),
									.func_op(func_op_ex),
									.lui(lui_ex),
									.op(alu_oprator)
									);
		
//choose to pass regfile output or immediate data
alu_opr2_mux alu_opr2_mux(	.r2(alu_oprand2_itm),   //intermediate data
									.imm(imm_ex),
									.alu_scr(alusrc_ex),
									.opr2(alu_oprand2)
									);	
									
assign alu_oprand1 = (auipc_ex)? pc_ex : alu_oprand1_itm;
							
PC_add PC_add(	.pc(pc_ex),
					.imm(imm_ex),
					.ZF(alu_ZF),
					.SF(alu_SF),
					.CF(alu_CF),
					.branch(branch_ex),
					.func_op(func_op_ex),
					.jal(jal_ex),
					.jalr(jalr_ex),
					.se(branch_pc_src),
					.pc_result(pc_dest_itm)
					);		
						
ALU alu(	.OP(alu_oprator),
			.A(alu_oprand1),
			.B(alu_oprand2),
			.F(alu_F),
			.ZF(alu_ZF),
			.CF(alu_CF),
			.OF(),
			.SF(alu_SF),
			.PF()
			);

assign b_j_Result = (jalr_ex)? alu_F : pc_dest_itm;
assign alu_result_ex = (jalr_ex)? (pc_ex+64'd4) : alu_F;

/**************************  MEM  part  **********************************/			
			
EX_MEM_Reg ex_mem_reg(	.clk(clk),
								.clr(clr),
								.rst_n(reset_n),
								.p1(memtoreg_ex),
								.p2(memread_ex),
								.p3(memwrite_ex),
								.p4(regwrite_ex),
								.alu_result_ex(alu_result_ex),
								.writedata_ex(alu_oprand2_itm),
								.rd_ex_ex(rd_ex),
								.RegRs2_ex(ID_EX_RegRs2),
								.memtoreg_mem(memtoreg_mem),
								.memread_mem(memread_mem),
								.memwrite_mem(memwrite_mem),
								.regwrite_mem(regwrite_mem),
								.alu_result_mem(alu_result_mem),
								.writedata_mem(writedata_mem),
								.rd_mem(rd_mem_mem),
								.RegRs2_mem(RegRs2_mem)
								);
		
data_mem data_mem(
							.address(alu_result_mem[4:0]),
							.clock(~clk),
							.data(MEM_writing_data),
							.rden(memread_mem),
							.wren(memwrite_mem),
							.q(mem_data)
							);

/***************************  WB part  *****************************/							
							
MEM_WB_Reg mem_wb_reg(	.clk(clk),
								.clr(clr),
								.rst_n(reset_n),
								.p1(memtoreg_mem),
								.p2(regwrite_mem),
								.mem_data(mem_data),
								.alu_data(alu_result_mem),
								.rd_mem_mem(rd_mem_mem),
								.memtoreg_wb(memtoreg_wb),
								.regwrite_wb(wen_regfile),
								.mem_data_W(mem_data_W),
								.alu_out(alu_out),
								.rd_wb(rd_final)
								);

//choose to pass alu result or memory output								
alu_mem_mux alu_mem_mux(	.alu_data(alu_out),
									.mem_data(mem_data_W),
									.select_signal(memtoreg_wb),
									.outdata(writeback_data)
									);
									
									
/***********************  Hazard Unit  ******************************/									
load_Hazard load_Hazard(		.ID_EX_Memread(memread_ex),
										.ID_EX_RegRd(rd_ex),
										.IF_ID_RegRs1(rs1_id),
										.IF_ID_RegRs2(rs2_id),
										.MemWrite(memwrite_id),
										.Jal(jal_id),
										.I(alusrc_id),
										.stall(stall_load)
										);

//data hazarad forwarding						
Forwarding Forwarding(	.EX_MEM_RegWrite(regwrite_mem),
								.EX_MEM_RegRd(rd_mem_mem),
								.MEM_WB_RegWrite(wen_regfile),
								.MEM_WB_RegRd(rd_final),
								.ID_EX_RegRs1(ID_EX_RegRs1),
								.ID_EX_RegRs2(ID_EX_RegRs2),
								.MEM_WB_MEMtoReg(memtoreg_wb),
								.EX_MEM_RegRs2(RegRs2_mem),
								.ForwardA(ForwardA),
								.ForwardB(ForwardB),
								.Forward_M2M(Forward_M2M)
								);
								
forward_muxA forward_muxA( 	.ex(r1_ex),
										.mem(alu_result_mem),
										.wb(writeback_data),
										.se(ForwardA),
										.rs1out(alu_oprand1_itm)
										);
								
forward_muxB forward_muxB( 	.ex(r2_ex),
										.mem(alu_result_mem),
										.wb(writeback_data),
										.se(ForwardB),
										.rs2out(alu_oprand2_itm)
										);

assign MEM_writing_data = (Forward_M2M)? writeback_data : writedata_mem;
/********************************** top level outputs (Monitoring use) *************************/									
assign pc_fetch = pc_if;
assign pc_decode = pc_id;
assign inst_fetch = inst_if;
assign inst_decode = inst_id;
assign alu_outdata = alu_result_ex;
assign mem_out_data = mem_data;

endmodule
						  