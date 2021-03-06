
module tb_top
(
    input clk,
    input rst_n
);
    localparam DATA_WIDTH = 8;

    // test data generator
    wire [DATA_WIDTH-1:0] cntr;
    wire [DATA_WIDTH-1:0] cntr_nx = cntr + 1;
    prm_register_c #(DATA_WIDTH) r_cntr (clk, rst_n, cntr_nx, cntr);

    wire [DATA_WIDTH-1:0] idata = cntr;
    wire [DATA_WIDTH-1:0] odata;
    wire                  icontrol = 1'b1;
    wire                  ocontrol;

    //dut pipeline
    tb_pipeline #(DATA_WIDTH) dut
    (
        .clk      ( clk      ),
        .rst_n    ( rst_n    ),
        .idata    ( idata    ),
        .odata    ( odata    ),
        .icontrol ( icontrol ),
        .ocontrol ( ocontrol )
    );

    //tb output
    always @(posedge clk) begin
        $display ("rst_n=%b idata=%1h odata=%1h icontrol=%1b ocontrol=%1b",
                   rst_n,   idata,    odata,    icontrol,    ocontrol);
    end

endmodule
