module sequencial_fsm(input clk,reset_n,i,output o);
// 11011001
parameter idle = 3'b00;
parameter s1= 3'b001;
parameter s2 = 3'b010; 
parameter s3 = 3'b011; 
parameter s4= 3'b100;
parameter s5 = 3'b101;
parameter s6 = 3'b110;
parameter s7 =3'b111;

reg [2:0] cs;
reg [2:0] ns;

reg o_r;
always@(posedge clk or negedge reset_n) begin
  if(reset_n == 1'b0) cs <= idle;
  else cs<=ns;
end

always@(cs or i) begin
 o_r = 0;
 case(cs)
  idle:if(i==1) ns=s1; else ns=idle;
  s1:if(i==1)   ns=s2; else ns=idle; // 1
  s2:if(i==0)   ns=s3; else ns=s2;   // 11
  s3:if(i==1)   ns=s4; else ns=s1;   // 110
  s4:if(i==1)   ns=s5; else ns=idle; // 1101
  s5:if(i==0)   ns=s6; else ns=s2; // 11011
  s6:if(i==0)   ns=s7; else ns=s3; // 110110
  s7:if(i==1)   begin ns=s1; o_r=1;end else ns=idle; //1101100
  default: $error("error triggered!!");
 endcase 
end
assign o=o_r;

endmodule
