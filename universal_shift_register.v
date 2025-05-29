module shift_register (data_out, data_in, msb_out, msb_in, lsb_out, lsb_in, s0, s1, clk, rst);
output [3:0]data_out;
output msb_out,lsb_out;
input [3:0]data_in;
input msb_in,lsb_in;
input s1,s0,clk,rst;
reg[3:0] data_out;
assign msb_out=data_out[3];
assign lsb_out=data_out[0];
always@(posedge clk)
begin
if(rst) data_out<=data_in;
else
case({s1,s0})
0:data_out<=data_in;
1:data_out<={msb_in,data_in[3:1]};
2:data_out<={data_in[2:0],lsb_in};
3:data_out<=data_in;
endcase
end
endmodule