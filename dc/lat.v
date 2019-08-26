module lat(num,xval,yval,zval,dec);

input wire[1:0] num;
input wire xval;
input wire yval;
input wire zval;
output reg dec;

always @(zval or xval or yval) begin
  dec=zval;
  if(num==2'b00)
    dec=xval;
  else if(num==2'b01)
    dec=yval;
end

endmodule
