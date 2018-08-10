
`include "vpm.svh"

`default_nettype none

module tb_pipeline
#(
    parameter DATA_WIDTH = 8
)(
    input  wire                  clk,
    input  wire                  rst_n,
    input  wire [DATA_WIDTH-1:0] idata,
    output wire [DATA_WIDTH-1:0] odata
);
    `VPM_STAGE_C(I)
    `VPM_STAGE_CC(M1)
    `VPM_STAGE_C(M2)
    `VPM_STAGE_C(M3)
    `VPM_STAGE_C(O)

    `VPM_PIPE_5(data, DATA_WIDTH, I, M1, M2, M3, O)

    assign data_I = idata;
    assign odata  = data_O;
    assign hz_flush_n_M1 = 1'b1;

endmodule

`default_nettype wire
