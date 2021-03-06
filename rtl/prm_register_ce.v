
module prm_register_ce
#(
    parameter WIDTH = 1
)
(
    input                        clk,
    input                        rst_n,
    input                        we,
    input      [ WIDTH - 1 : 0 ] d,
    output reg [ WIDTH - 1 : 0 ] q
);
    localparam RESET = { WIDTH { 1'b0 } };
    
    always @ (posedge clk or negedge rst_n)
        if(~rst_n)
            q <= RESET;
        else
            if(we) q <= d;
endmodule
