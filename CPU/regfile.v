module RegFile(	Clk,
						rst_n,
						Write_en,
						R_Addr_A,
						R_Addr_B,
						W_Addr,
						W_Data,
						R_Data_A,
						R_Data_B
						);
						
    parameter ADDR = 5;//寄存器编码/地址位宽
    parameter NUMB = 1<<ADDR;//寄存器个数
    parameter SIZE = 64;//寄存器数据位宽
    
    input Clk;//写入时钟信号
    input rst_n;//清零信号
    input Write_en;//写控制信号
	 wire wen;
    input [ADDR-1:0]R_Addr_A;//A端口读寄存器地址
    input [ADDR-1:0]R_Addr_B;//B端口读寄存器地址
    input [4:0]W_Addr;//写寄存器地址
    input [SIZE-1:0]W_Data;//写入数据
    
    output [SIZE-1:0]R_Data_A;//A端口读出数据
    output [SIZE-1:0]R_Data_B;//B端口读出数据
	 
    assign wen= W_Addr[0]|W_Addr[1]|W_Addr[2]|W_Addr[3]|W_Addr[4];
    reg [SIZE-1:0]REG_Files[0:NUMB-1];//寄存器堆本体
    integer i;//用于遍历NUMB个寄存器
    
    initial//初始化NUMB个寄存器，全为0
        for(i=0;i<NUMB;i=i+1) REG_Files[i]<=0;
    always@(negedge Clk or negedge rst_n)//时钟信号或清零信号上升沿
    begin
        if(!rst_n) 
			begin//清零
           for(i=0;i<NUMB;i=i+1) REG_Files[i]<=0;
			end
        else
				//if(W_Addr[0]|W_Addr[1]|W_Addr[2]|W_Addr[3]|W_Addr[4])
					if(Write_en&(W_Addr[0]|W_Addr[1]|W_Addr[2]|W_Addr[3]|W_Addr[4])) 
							REG_Files[W_Addr]<=W_Data;
    end
    
    //读操作没有使能或时钟信号控制, 使用数据流建模(组合逻辑电路,读不需要时钟控制)
    assign R_Data_A=REG_Files[R_Addr_A];
    assign R_Data_B=REG_Files[R_Addr_B];

endmodule
