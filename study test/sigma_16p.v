//相邻十六位相加(可能有问题！重要的是学习其中的脉冲产生的方式)
`timescale 1ns/10ps
module sigma_16p (
    clk,
    res,
    data_in,
    syn_in,
    data_out,
    syn_out);
input   clk;
input   res;
input[7:0]  data_in;//采样信号
input   syn_in;//采样时钟
output[11:0] data_out;//累加结果输出
output  syn_out;//累加结果同步脉冲
reg     sys_in_n1 ;//sys_in的反向延时
wire    sys_pulse;//采样时钟上升沿识别脉冲
reg [3:0]   con_syn;//采样时钟循环计数
wire[7:0]   comp_8;//补码
wire [11:0] d_12;//升位计算结果
reg [11:0]  sigma;//累加计算
reg [11:0] data_out;
reg syn_out;

assign  sys_pulse=syn_in&sys_in_n1;
assign  comp_8=data_in[7]?{data_in[7],data_in[6:0]+1}:data_in;//补码计算
assign  d_12={comp_8[7],comp_8[7],comp_8[7],comp_8[7],comp_8};

always @(posedge clk or negedge res) begin
    if (~res) begin
        sys_in_n1<=0;con_syn<=0;sigma<=0;data_out<=0;syn_out<=0;
    end 
    else begin
        sys_in_n1<=syn_in;//时序逻辑代码会有一个时钟单位的延迟
        if (sys_pulse) begin
            con_syn<=con_syn+1; 
        end
        if (sys_pulse) begin
            if(con_syn==15)begin
                sigma<=d_12;
                data_out<=sigma;
                syn_out<=1;
            end
            else begin
                sigma<=sigma+d_12;
            end 
        end
        else begin
            syn_out<=0;//会有一个时钟延迟
        end

    end
    
end
    
endmodule

//----testbench of sigma_16p----
module sigma_16p_tb;
reg     clk,res;
reg [7:0]   data_in;
reg     syn_in;
wire [11:0] data_out;
wire syn_out;
sigma_16p sigma_16p (
    .clk(clk),
    .res(res),
    .data_in(data_in),
    .syn_in(syn_in),
    .data_out(data_out),
    .syn_out(syn_out)
    );

initial begin
    clk<=0;res<=0;data_in=1;syn_in<=0;
    #17 res<=1;
    #25000   $stop;
end
always #5 clk<=~clk;
always #100 syn_in<=~syn_in;
endmodule
