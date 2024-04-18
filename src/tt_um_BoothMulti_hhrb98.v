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
  wire [7:0] Z;

  // Assigning values to output wires
  assign uio_out = Z;
  assign uio_oe = ~rst_n;

  // Extracting bits from input
  assign X = ui_in[3:0];
  assign Y = ui_in[7:4];

  reg [7:0] Z1;
  reg [3:0] temp;
  integer i;
  reg E1;

  always @ (X, Y)
  begin
    Z1 = 8'd0;
    E1 = 1'b0;
    for (i = 0; i < 4; i = i + 1)
    begin
      temp = {X[i], E1};
      case (temp)
        2'b10: Z1 = Z1 + Y;
        2'b01: Z1 = Z1 - Y;
        default: Z1 = Z1; // Added default case to avoid latches
      endcase
      Z1 = Z1 >> 1;
      E1 = X[i];
    end
  end

  assign uo_out = Z1;

endmodule
