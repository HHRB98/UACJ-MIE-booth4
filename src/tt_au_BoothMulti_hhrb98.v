module tt_au_BoothMulti_hhrb98(
 output wire [7:0] uio_out,  // IOs: Output path
 output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)  input  wire       ena,      // will go high when the design is enabled
 input  wire       clk,      // clock
 input  wire       rst_n,     // reset_n - low to reset
 input  wire       ena      // will go high when the design is enabled
 input [3:0] X, Y,
 output [7:0] Z,
 reg [7:0] Z,
 reg [3:0] temp,
 integer i,
 reg E1,
 reg [3:0] Y1
 );

 always @ (X, Y)
 begin
 Z = 8'd0;
 E1 = 1'd0;
 for (i = 0; i < 4; i = i + 1)
 begin
 temp = {X[i], E1};
 if (Y[3] == 1'b1)
 Y1 = -Y;
 else
 Y1 = Y;
 case (temp)
 2'd2: Z[7:4] = Z[7:4] + Y1[3:0];
 2'd1: Z[7:4] = Z[7:4] + Y[3:0];
 default: begin end
 endcase
 Z = Z >> 1;
 Z[7] = Z[6];
 E1 = X[i];
 end
 if (Y == 4'd8)
 begin
 Z = -Z;
 end
 end
endmodule
