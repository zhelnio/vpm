
`ifndef INCLUDE_VPM
`define INCLUDE_VPM

// ******************************************************
// to change default signal names redefine
// these macroses in your code before 'include' directive

`ifndef VPM_SIGNAL_FLUSH
    `define VPM_SIGNAL_FLUSH(name) hz_flush_n_``name
`endif

`ifndef VPM_SIGNAL_STALL
    `define VPM_SIGNAL_STALL(name) hz_stall_n_``name
`endif

`ifndef VPM_CLK
    `define VPM_CLK clk
`endif

`ifndef VPM_RSTN
    `define VPM_RSTN rst_n
`endif

// ******************************************************

`define VPM_STAGE_C(stage) \
    `define VPM_STAGE_C_``stage

`define VPM_STAGE_CC(stage) \
    wire `VPM_SIGNAL_FLUSH(stage); \
    `define VPM_STAGE_CC_``stage

`define VPM_STAGE_CCE(stage) \
    wire `VPM_SIGNAL_STALL(stage); \
    wire `VPM_SIGNAL_FLUSH(stage); \
    `define VPM_STAGE_CCE_``stage

`define VPM_STAGE_CE(stage) \
    wire `VPM_SIGNAL_STALL(stage); \
    `define VPM_STAGE_CE_``stage

`define VPM_STAGE(stage) \
    `define VPM_STAGE_``stage

`define VPM_REG(stage,name,size,in,out) \
    `ifdef VPM_STAGE_C_``stage \
        prm_register_c #(size) name (`VPM_CLK, `VPM_RSTN, in, out) \
    `elsif VPM_STAGE_CC_``stage \
        prm_register_cc #(size) name (`VPM_CLK, `VPM_RSTN, `VPM_SIGNAL_FLUSH(stage), in, out) \
    `elsif VPM_STAGE_CCE_``stage \
        prm_register_cce #(size) name (`VPM_CLK, `VPM_RSTN, `VPM_SIGNAL_FLUSH(stage),`VPM_SIGNAL_STALL(stage), in, out) \
    `elsif STAGE_DEF_CE_``stage \
        prm_register_ce #(size) name (`VPM_CLK, `VPM_RSTN, `VPM_SIGNAL_STALL(stage), in, out) \
    `else \
        prm_register #(size) name (`VPM_CLK, in, out) \
    `endif

`define VPM_PIPE_2(name,size,s0,s1) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    `VPM_REG(s1,r_``name``_``s1, size, name``_``s0, name``_``s1);

`define VPM_PIPE_3(name,size,s0,s1,s2) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; \
    `VPM_REG(s1,r_``name``_``s1, size, name``_``s0, name``_``s1); \
    `VPM_REG(s2,r_``name``_``s2, size, name``_``s1, name``_``s2);

`define VPM_PIPE_4(name,size,s0,s1,s2,s3) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; \
    wire [size-1:0] name``_``s3; \
    `VPM_REG(s1,r_``name``_``s1, size, name``_``s0, name``_``s1); \
    `VPM_REG(s2,r_``name``_``s2, size, name``_``s1, name``_``s2); \
    `VPM_REG(s3,r_``name``_``s3, size, name``_``s2, name``_``s3);

`define VPM_PIPE_5(name,size,s0,s1,s2,s3,s4) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; \
    wire [size-1:0] name``_``s3; \
    wire [size-1:0] name``_``s4; \
    `VPM_REG(s1,r_``name``_``s1, size, name``_``s0, name``_``s1); \
    `VPM_REG(s2,r_``name``_``s2, size, name``_``s1, name``_``s2); \
    `VPM_REG(s3,r_``name``_``s3, size, name``_``s2, name``_``s3); \
    `VPM_REG(s4,r_``name``_``s4, size, name``_``s3, name``_``s4);

`define VPM_PIPE_6(name,size,s0,s1,s2,s3,s4,s5) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; \
    wire [size-1:0] name``_``s3; \
    wire [size-1:0] name``_``s4; \
    wire [size-1:0] name``_``s5; \
    `VPM_REG(s1,r_``name``_``s1, size, name``_``s0, name``_``s1); \
    `VPM_REG(s2,r_``name``_``s2, size, name``_``s1, name``_``s2); \
    `VPM_REG(s3,r_``name``_``s3, size, name``_``s2, name``_``s3); \
    `VPM_REG(s4,r_``name``_``s4, size, name``_``s3, name``_``s4); \
    `VPM_REG(s5,r_``name``_``s5, size, name``_``s4, name``_``s5);

`define VPM_PIPE_7(name,size,s0,s1,s2,s3,s4,s5,s6) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; \
    wire [size-1:0] name``_``s3; \
    wire [size-1:0] name``_``s4; \
    wire [size-1:0] name``_``s5; \
    wire [size-1:0] name``_``s6; \
    `VPM_REG(s1,r_``name``_``s1, size, name``_``s0, name``_``s1); \
    `VPM_REG(s2,r_``name``_``s2, size, name``_``s1, name``_``s2); \
    `VPM_REG(s3,r_``name``_``s3, size, name``_``s2, name``_``s3); \
    `VPM_REG(s4,r_``name``_``s4, size, name``_``s3, name``_``s4); \
    `VPM_REG(s5,r_``name``_``s5, size, name``_``s4, name``_``s5); \
    `VPM_REG(s6,r_``name``_``s6, size, name``_``s5, name``_``s6);

`define VPM_PIPE_8(name,size,s0,s1,s2,s3,s4,s5,s6,s7) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; \
    wire [size-1:0] name``_``s3; \
    wire [size-1:0] name``_``s4; \
    wire [size-1:0] name``_``s5; \
    wire [size-1:0] name``_``s6; \
    wire [size-1:0] name``_``s7; \
    `VPM_REG(s1,r_``name``_``s1, size, name``_``s0, name``_``s1); \
    `VPM_REG(s2,r_``name``_``s2, size, name``_``s1, name``_``s2); \
    `VPM_REG(s3,r_``name``_``s3, size, name``_``s2, name``_``s3); \
    `VPM_REG(s4,r_``name``_``s4, size, name``_``s3, name``_``s4); \
    `VPM_REG(s5,r_``name``_``s5, size, name``_``s4, name``_``s5); \
    `VPM_REG(s6,r_``name``_``s6, size, name``_``s5, name``_``s6); \
    `VPM_REG(s7,r_``name``_``s7, size, name``_``s6, name``_``s7);

`define VPM_PIPE_9(name,size,s0,s1,s2,s3,s4,s5,s6,s7,s8) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; \
    wire [size-1:0] name``_``s3; \
    wire [size-1:0] name``_``s4; \
    wire [size-1:0] name``_``s5; \
    wire [size-1:0] name``_``s6; \
    wire [size-1:0] name``_``s7; \
    wire [size-1:0] name``_``s8; \
    `VPM_REG(s1,r_``name``_``s1, size, name``_``s0, name``_``s1); \
    `VPM_REG(s2,r_``name``_``s2, size, name``_``s1, name``_``s2); \
    `VPM_REG(s3,r_``name``_``s3, size, name``_``s2, name``_``s3); \
    `VPM_REG(s4,r_``name``_``s4, size, name``_``s3, name``_``s4); \
    `VPM_REG(s5,r_``name``_``s5, size, name``_``s4, name``_``s5); \
    `VPM_REG(s6,r_``name``_``s6, size, name``_``s5, name``_``s6); \
    `VPM_REG(s7,r_``name``_``s7, size, name``_``s6, name``_``s7); \
    `VPM_REG(s8,r_``name``_``s8, size, name``_``s7, name``_``s8);

`define VPM_PIPE_10(name,size,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; \
    wire [size-1:0] name``_``s3; \
    wire [size-1:0] name``_``s4; \
    wire [size-1:0] name``_``s5; \
    wire [size-1:0] name``_``s6; \
    wire [size-1:0] name``_``s7; \
    wire [size-1:0] name``_``s8; \
    wire [size-1:0] name``_``s9; \
    `VPM_REG(s1,r_``name``_``s1, size, name``_``s0, name``_``s1); \
    `VPM_REG(s2,r_``name``_``s2, size, name``_``s1, name``_``s2); \
    `VPM_REG(s3,r_``name``_``s3, size, name``_``s2, name``_``s3); \
    `VPM_REG(s4,r_``name``_``s4, size, name``_``s3, name``_``s4); \
    `VPM_REG(s5,r_``name``_``s5, size, name``_``s4, name``_``s5); \
    `VPM_REG(s6,r_``name``_``s6, size, name``_``s5, name``_``s6); \
    `VPM_REG(s7,r_``name``_``s7, size, name``_``s6, name``_``s7); \
    `VPM_REG(s8,r_``name``_``s8, size, name``_``s7, name``_``s8); \
    `VPM_REG(s9,r_``name``_``s9, size, name``_``s8, name``_``s9);

`define VPM_PIPE_11(name,size,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; \
    wire [size-1:0] name``_``s3; \
    wire [size-1:0] name``_``s4; \
    wire [size-1:0] name``_``s5; \
    wire [size-1:0] name``_``s6; \
    wire [size-1:0] name``_``s7; \
    wire [size-1:0] name``_``s8; \
    wire [size-1:0] name``_``s9; \
    wire [size-1:0] name``_``s10; \
    `VPM_REG(s1, r_``name``_``s1,  size, name``_``s0, name``_``s1); \
    `VPM_REG(s2, r_``name``_``s2,  size, name``_``s1, name``_``s2); \
    `VPM_REG(s3, r_``name``_``s3,  size, name``_``s2, name``_``s3); \
    `VPM_REG(s4, r_``name``_``s4,  size, name``_``s3, name``_``s4); \
    `VPM_REG(s5, r_``name``_``s5,  size, name``_``s4, name``_``s5); \
    `VPM_REG(s6, r_``name``_``s6,  size, name``_``s5, name``_``s6); \
    `VPM_REG(s7, r_``name``_``s7,  size, name``_``s6, name``_``s7); \
    `VPM_REG(s8, r_``name``_``s8,  size, name``_``s7, name``_``s8); \
    `VPM_REG(s9, r_``name``_``s9,  size, name``_``s8, name``_``s9); \
    `VPM_REG(s10,r_``name``_``s10, size, name``_``s9, name``_``s10);

`endif // INCLUDE_VPM
