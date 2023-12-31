module DigitalDice(
  input clk,         // Clock input
  input rst,         // Reset input
  output reg [6:0] seg // Seven-segment display output
);


reg [3:0] dice_number; // Register to store the dice number
reg rolling;          // Flag to indicate dice is rolling


always @(posedge clk or posedge rst)
begin
  if (rst) // Reset the dice number and rolling flag
  begin
    dice_number <= 4'd0;
    rolling <= 1'b0;
  end
  else
  begin
    if (rolling) // If dice is rolling, generate random numbers
      dice_number <= dice_number + 1;
  end
end


always @(posedge clk or posedge rst)
begin
  if (rst) // Reset the display to show 0 on the seven-segment display
    seg <= 7'b111_1110;
  else
  begin
    case (dice_number) // Display the appropriate segment pattern based on the dice number
      4'd1: seg <= 7'b000_0110;
      4'd2: seg <= 7'b101_1011;
      4'd3: seg <= 7'b100_1111;
      4'd4: seg <= 7'b110_0110;
      4'd5: seg <= 7'b110_1101;
      4'd6: seg <= 7'b111_1101;
      default: seg <= 7'b111_1110; // Display nothing if the number is out of range
    endcase
  end
end


always @(posedge clk or posedge rst)
begin
  if (rst) // Reset the rolling flag when the dice is not rolling
    rolling <= 1'b0;
  else if (rolling == 1'b0) // Start rolling when the dice is not already rolling
  begin
    rolling <= 1'b1;
    dice_number <= 4'd0; // Reset dice number before rolling
  end
end

