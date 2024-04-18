module tt_um_BoothMulti_hhrb98(
    input  wire [7:0] ui_in,     // Dedicated inputs
    output wire [7:0] uo_out,    // Dedicated outputs
    input  wire [7:0] uio_in,    // IOs: Input path
    output wire [7:0] uio_out,   // IOs: Output path
    output wire [7:0] uio_oe,    // IOs: Enable path (active high: 0=input, 1=output)
    input wire        clk,
    input  wire       ena,       // will go high when the design is enabled
    input  wire       rst_n      // reset_n - low to reset
);

  // Inputs wire
  wire [3:0] X, Y;

  // Output wire
  wire signed [7:0] Z;

  // Assigning values to output wires
  assign uio_out = 8'b11111111;
  assign uio_oe = 8'b11111111;
  
  // Extracting bits from input
  assign X = ui_in[3:0];
  assign Y = ui_in[7:4];

  // Flip flop
  reg variable; // Changed to reg type

  always @(posedge clk or negedge rst_n) begin  
    if (~rst_n) begin
      // Reset condition: set variable to 0
      variable <= 1'b0; // Changed value to 1-bit
    end else begin
      // Update variable with a value
      variable <= ena; // Assigning ena to variable
    end
  end

  reg signed [7:0] Z1;
  reg [3:0] temp;
  integer i;
  reg E1;
  reg signed [3:0] Y1;

  always @ (X, Y)
  begin
    Z1 = 8'd0;
    E1 = 1'd0;
    for (i = 0; i < 4; i = i + 1)
    begin
      temp = {X[i], E1};
      if (Y[3] == 1'b1)
        Y1 = -Y;
      else
        Y1 = Y;
      case (temp)
        2'b10: Z1[7:4] = Z1[7:4] + Y1[3:0];
        2'b01: Z1[7:4] = Z1[7:4] + Y[3:0];
        default: begin end
      endcase
      Z1 = Z1 >> 1;
      Z1[7] = Z1[6];
      E1 = X[i];
    end
    if (Y == 4'd8)
    begin
      Z1 = -Z1;
    end
  end

  assign uo_out[7:0] = Z1[7:0];

endmodule
