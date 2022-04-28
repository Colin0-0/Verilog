`timescale 1ns/10ps
module seg_dec (
    num,
    a_g
);
input[3:0]   num;
output[6:0]  a_g;//a_g-->{a,b,c,d,e,f,g}

reg [6:0] a_g;
always @(num) begin
    case (num)
        4'd0:begin a_g<=7'b111_1110;end 
        4'd1:begin a_g<=7'b011_0000;end 
        4'd2:begin a_g<=7'b110_1101;end 
        4'd3:begin a_g<=7'b111_1100;end 
        4'd4:begin a_g<=7'b011_0011;end 
        4'd5:begin a_g<=7'b101_1111;end 
        4'd6:begin a_g<=7'b101_1111;end 
        4'd7:begin a_g<=7'b111_0000;end 
        4'd8:begin a_g<=7'b111_1111;end 
        4'd9:begin a_g<=7'b111_1011;end 
        default: a_g<=7'b000_0001;//中杠
    endcase
    
end
    
endmodule