//计数器
module counter (
    clk,
    res,
    y
);
input   clk;
input   res;
output[7:0] y;

reg [7:0]   y;
wire [7:0]   sum ;
assign  sum = y+1;

always @(posedge clk or negedge res) 
    if(~res)begin
        y<=0;
    end
    else begin
        y<=sum;
    end
endmodule

//----tetsbench of counter----
module counter_tb;
reg clk;
reg rst;
wire [7:0]  y;
counter counter 
(
    .res (rst),
    .clk (clk),
    .y(y)
);


initial begin
    clk<=0;rst<=0;
    #17 rst<=1;
    #6000   $stop;
end

always #5 clk<=~clk;

endmodule