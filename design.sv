
module traffic_light_controller (
    input clk,
    input reset,
    output reg red,
    output reg yellow,
    output reg green
);

    // Define the three traffic light states
    parameter RED_STATE    = 2'b00;
    parameter GREEN_STATE  = 2'b01;
    parameter YELLOW_STATE = 2'b10;

    reg [1:0] state;
    reg [1:0] timer;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= RED_STATE;
            timer <= 0;
        end
        else begin
            if (timer == 2) begin
                timer <= 0;

                case (state)
                    RED_STATE:
                        state <= GREEN_STATE;

                    GREEN_STATE:
                        state <= YELLOW_STATE;

                    YELLOW_STATE:
                        state <= RED_STATE;

                    default:
                        state <= RED_STATE;
                endcase
            end
            else begin
                timer <= timer + 1;
            end
        end
    end

    // Output logic
    always @(*) begin
        red = 0;
        yellow = 0;
        green = 0;

        case (state)
            RED_STATE:    red = 1;
            GREEN_STATE:  green = 1;
            YELLOW_STATE: yellow = 1;
            default:      red = 1;
        endcase
    end

endmodule
