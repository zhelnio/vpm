
`define SIMULATION_CYCLES  20

`timescale 1ns / 1ps

module tb;

    bit clk;
    bit rst_n;

    initial begin
        rst_n <= 1'b0;
        repeat (10) @(negedge clk);
        rst_n <= 1'b1;
    end

    always #10 clk <= ~clk;

    int cycle; initial cycle = 0;

    always @ (posedge clk) begin
        cycle = cycle + 1;
        if (cycle > `SIMULATION_CYCLES)
        begin
            $display ("Timeout");
            $finish;
        end
    end

    `ifdef ICARUS
        initial $dumpvars;
    `endif

    tb_top top
    (
        .clk          ( clk           ),
        .rst_n        ( rst_n         )
    );

endmodule
