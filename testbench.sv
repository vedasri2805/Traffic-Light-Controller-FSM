
`timescale 1ns/1ps

module tb_traffic_light_controller;

    reg clk;
    reg reset;

    wire red;
    wire yellow;
    wire green;

    // Connect the design to the testbench
    traffic_light_controller dut (
        .clk(clk),
        .reset(reset),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    // Generate clock: 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Apply reset and run the simulation
    initial begin
        $dumpfile("traffic_light.vcd");
        $dumpvars(0, tb_traffic_light_controller);

        $monitor(
            "Time=%0t | Red=%b Yellow=%b Green=%b",
            $time, red, yellow, green
        );

        reset = 1;
        #12;
        reset = 0;

        #200;
        $finish;
    end

endmodule
