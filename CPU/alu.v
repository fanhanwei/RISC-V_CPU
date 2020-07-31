module ALU(OP,A,B,F,ZF,CF,OF,SF,PF);
    parameter SIZE = 64;
    input [3:0] OP;
    input [SIZE-1:0] A;//r1
    input [SIZE-1:0] B;//r2
    output reg [SIZE-1:0] F;//result
    output  ZF, //0标志位, 运算结果为0(全零)则置1, 否则置0 
            CF, //进借位标志位, 取最高位进位C,加法时C=1则CF=1表示有进位,减法时C=0则CF=1表示有借位
            OF, //溢出标志位，对有符号数运算有意义，溢出则OF=1，否则为0
            SF, //符号标志位，与F的最高位相同
            PF; //奇偶标志位，F有奇数个1，则PF=1，否则为0
    //reg [SIZE:1] F;
    reg C,ZF,CF,OF,SF,PF;//C为最高位进位
    always@(*)
    begin
        C=0;
        case(OP)
            4'b0000:begin F=A&B; end    //and
            4'b0001:begin F=A|B; end    //or
            4'b0010:begin {C,F}=A+B; end    //add
            4'b0011:begin F=A<<B; end //sll
            4'b0100:begin F=($signed(A)<$signed(B))? 1 : 0; end //slt
            4'b0101:begin F=(A<B)? 1 : 0;end //sltu
            4'b0110:begin {C,F}=A-B; end    //sub
            4'b0111:begin F=A^B; end   //xor
				4'b1000:begin F=A>>B; end   //srl
				4'b1001:begin F=($signed(A))>>>B; end   //sra
				4'b1010:begin F=B; end   //lui
        endcase
        ZF = F==0;//F全为0，则ZF=1
        CF = C; //进位借位标志
        OF = A[SIZE-1]^B[SIZE-1]^F[SIZE-1]^C;//溢出标志公式
        SF = F[SIZE-1];//符号标志,取F的最高位
        PF = ~^F;//奇偶标志，F有奇数个1，则F=1；偶数个1，则F=0
    end     
endmodule
