module sequencial(input clk,input reset_n,input i,output o);

reg [3:0] i_r;

always@(posedge clk) begin
  if(reset_n == 1'b0) i_r <= 0;
  else i_r <= {i_r[2:0],i};
end

assign o = i_r==4'b1101;
endmodule
