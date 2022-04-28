module tri_gen(
    clk,
    res,
    d_out 
);
input clk;
input res;
output[8:0]  d_out;
reg [1:0]    state;//主状态寄存器
reg [8:0]   d_out;
reg [7:0]   con;//计数器，记录平顶周期

always @(posedge clk or negedge res) begin
    if(~res)begin
        state<=0;d_out<=0;con<=0;
    end
    else begin
        case(state)
        0:begin//上升
            d_out<=d_out+1;
            if(d_out==299)begin
                state<=1;
            end
        end
        1:begin//平顶
            if (con==200) begin
                state<=2;
                con<=0;                
            end
            else begin
                con<=con+1;
            end
        end
        2:begin//下降
            d_out<=d_out-1;
            if(d_out==1)begin
                state<=3;
            end
        end
        3:begin//下平顶
            if (con==200) begin
                state<=0;
                con<=0;                
            end
            else begin
                con<=con+1;
            end
        end
        endcase
        
    end
end
endmodule
//----testbench of tri_gen----
module tri_gen_tb ;
reg     clk,res;
wire [8:0]      d_out;
tri_gen U1(
    .clk(clk),
    .res(res),
    .d_out(d_out) 
);

initial begin
    clk<=0;res<=0;
    #17    res<=1;
    #40000  $stop; 
end
always #5 clk<=~clk;

endmodule