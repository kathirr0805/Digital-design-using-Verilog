module tflipflop(t,clk,rst,q,qbar);
input t,clk,rst;
output reg q,qbar;
always @(posedge clk)
begin
if(rst)
begin
q<=0;
qbar<=1;
end
else
begin
if(t==0)
begin
q<=q;
qbar<=~q;
end
else
begin
q<=~q;
qbar<=q;
end
end
end
endmodule