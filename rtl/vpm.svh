
// vpm.svh
// 
// SystemVerilog pipeline macros
// Copyright(c) 2017-2018 Stanislav Zhelnio
// 
// https://github.com/zhelnio/vpm

`ifndef INCLUDE_VPM
`define INCLUDE_VPM

// ******************************************************
// to change default signal names redefine
// these macros values in your code before 'include' directive

//TODO:
// - overwrite signal type option: logic or wire or reg
// - overwrite ff type option

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

`define VPM_REG_W(stage,name,size,in,out) \
    `ifdef VPM_STAGE_C_``stage \
        prm_register_c #(size) name (`VPM_CLK, `VPM_RSTN, in, out); \
    `elsif VPM_STAGE_CC_``stage \
        prm_register_cc #(size) name (`VPM_CLK, `VPM_RSTN, `VPM_SIGNAL_FLUSH(stage), in, out); \
    `elsif VPM_STAGE_CCE_``stage \
        prm_register_cce #(size) name (`VPM_CLK, `VPM_RSTN, `VPM_SIGNAL_FLUSH(stage),`VPM_SIGNAL_STALL(stage), in, out); \
    `elsif VPM_STAGE_CE_``stage \
        prm_register_ce #(size) name (`VPM_CLK, `VPM_RSTN, `VPM_SIGNAL_STALL(stage), in, out); \
    `elsif VPM_STAGE_``stage \
        prm_register #(size) name (`VPM_CLK, in, out); \
    `endif

`define VPM_REG_1(stage,name,in,out) \
    `ifdef VPM_STAGE_C_``stage \
        prm_register_c name (`VPM_CLK, `VPM_RSTN, in, out); \
    `elsif VPM_STAGE_CC_``stage \
        prm_register_cc name (`VPM_CLK, `VPM_RSTN, `VPM_SIGNAL_FLUSH(stage), in, out); \
    `elsif VPM_STAGE_CCE_``stage \
        prm_register_cce name (`VPM_CLK, `VPM_RSTN, `VPM_SIGNAL_FLUSH(stage),`VPM_SIGNAL_STALL(stage), in, out); \
    `elsif VPM_STAGE_CE_``stage \
        prm_register_ce name (`VPM_CLK, `VPM_RSTN, `VPM_SIGNAL_STALL(stage), in, out); \
    `elsif VPM_STAGE_``stage \
        prm_register name (`VPM_CLK, in, out); \
    `endif

`define VPM_VPIPE_1(name,size,s0) \
    wire [size-1:0] name``_``s0;

`define VPM_VPIPE_2(name,size,s0,s1) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; 

`define VPM_VPIPE_3(name,size,s0,s1,s2) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; 

`define VPM_VPIPE_4(name,size,s0,s1,s2,s3) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; \
    wire [size-1:0] name``_``s3; 

`define VPM_VPIPE_5(name,size,s0,s1,s2,s3,s4) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; \
    wire [size-1:0] name``_``s3; \
    wire [size-1:0] name``_``s4; 

`define VPM_VPIPE_6(name,size,s0,s1,s2,s3,s4,s5) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; \
    wire [size-1:0] name``_``s3; \
    wire [size-1:0] name``_``s4; \
    wire [size-1:0] name``_``s5; 

`define VPM_VPIPE_7(name,size,s0,s1,s2,s3,s4,s5,s6) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; \
    wire [size-1:0] name``_``s3; \
    wire [size-1:0] name``_``s4; \
    wire [size-1:0] name``_``s5; \
    wire [size-1:0] name``_``s6; 

`define VPM_VPIPE_8(name,size,s0,s1,s2,s3,s4,s5,s6,s7) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; \
    wire [size-1:0] name``_``s3; \
    wire [size-1:0] name``_``s4; \
    wire [size-1:0] name``_``s5; \
    wire [size-1:0] name``_``s6; \
    wire [size-1:0] name``_``s7; 

`define VPM_VPIPE_9(name,size,s0,s1,s2,s3,s4,s5,s6,s7,s8) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; \
    wire [size-1:0] name``_``s3; \
    wire [size-1:0] name``_``s4; \
    wire [size-1:0] name``_``s5; \
    wire [size-1:0] name``_``s6; \
    wire [size-1:0] name``_``s7; \
    wire [size-1:0] name``_``s8; 

`define VPM_VPIPE_10(name,size,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9) \
    wire [size-1:0] name``_``s0; \
    wire [size-1:0] name``_``s1; \
    wire [size-1:0] name``_``s2; \
    wire [size-1:0] name``_``s3; \
    wire [size-1:0] name``_``s4; \
    wire [size-1:0] name``_``s5; \
    wire [size-1:0] name``_``s6; \
    wire [size-1:0] name``_``s7; \
    wire [size-1:0] name``_``s8; \
    wire [size-1:0] name``_``s9; 

`define VPM_VPIPE_11(name,size,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10) \
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
    wire [size-1:0] name``_``s10; 

`define VPM_WPIPE_1(name,size,s0) \
    `VPM_VPIPE_1(name,size,s0)

`define VPM_WPIPE_2(name,size,s0,s1) \
    `VPM_VPIPE_2(name,size,s0,s1) \
    `VPM_REG_W(s1,r_``name``_``s1, size, name``_``s0, name``_``s1)

`define VPM_WPIPE_3(name,size,s0,s1,s2) \
    `VPM_VPIPE_3(name,size,s0,s1,s2) \
    `VPM_REG_W(s1,r_``name``_``s1, size, name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, size, name``_``s1, name``_``s2)

`define VPM_WPIPE_4(name,size,s0,s1,s2,s3) \
    `VPM_VPIPE_4(name,size,s0,s1,s2,s3) \
    `VPM_REG_W(s1,r_``name``_``s1, size, name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, size, name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, size, name``_``s2, name``_``s3)

`define VPM_WPIPE_5(name,size,s0,s1,s2,s3,s4) \
    `VPM_VPIPE_5(name,size,s0,s1,s2,s3,s4) \
    `VPM_REG_W(s1,r_``name``_``s1, size, name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, size, name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, size, name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, size, name``_``s3, name``_``s4)

`define VPM_WPIPE_6(name,size,s0,s1,s2,s3,s4,s5) \
    `VPM_VPIPE_6(name,size,s0,s1,s2,s3,s4,s5) \
    `VPM_REG_W(s1,r_``name``_``s1, size, name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, size, name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, size, name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, size, name``_``s3, name``_``s4) \
    `VPM_REG_W(s5,r_``name``_``s5, size, name``_``s4, name``_``s5)

`define VPM_WPIPE_7(name,size,s0,s1,s2,s3,s4,s5,s6) \
    `VPM_VPIPE_7(name,size,s0,s1,s2,s3,s4,s5,s6) \
    `VPM_REG_W(s1,r_``name``_``s1, size, name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, size, name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, size, name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, size, name``_``s3, name``_``s4) \
    `VPM_REG_W(s5,r_``name``_``s5, size, name``_``s4, name``_``s5) \
    `VPM_REG_W(s6,r_``name``_``s6, size, name``_``s5, name``_``s6)

`define VPM_WPIPE_8(name,size,s0,s1,s2,s3,s4,s5,s6,s7) \
    `VPM_VPIPE_8(name,size,s0,s1,s2,s3,s4,s5,s6,s7) \
    `VPM_REG_W(s1,r_``name``_``s1, size, name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, size, name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, size, name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, size, name``_``s3, name``_``s4) \
    `VPM_REG_W(s5,r_``name``_``s5, size, name``_``s4, name``_``s5) \
    `VPM_REG_W(s6,r_``name``_``s6, size, name``_``s5, name``_``s6) \
    `VPM_REG_W(s7,r_``name``_``s7, size, name``_``s6, name``_``s7)

`define VPM_WPIPE_9(name,size,s0,s1,s2,s3,s4,s5,s6,s7,s8) \
    `VPM_VPIPE_9(name,size,s0,s1,s2,s3,s4,s5,s6,s7,s8) \
    `VPM_REG_W(s1,r_``name``_``s1, size, name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, size, name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, size, name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, size, name``_``s3, name``_``s4) \
    `VPM_REG_W(s5,r_``name``_``s5, size, name``_``s4, name``_``s5) \
    `VPM_REG_W(s6,r_``name``_``s6, size, name``_``s5, name``_``s6) \
    `VPM_REG_W(s7,r_``name``_``s7, size, name``_``s6, name``_``s7) \
    `VPM_REG_W(s8,r_``name``_``s8, size, name``_``s7, name``_``s8)

`define VPM_WPIPE_10(name,size,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9) \
    `VPM_VPIPE_10(name,size,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9) \
    `VPM_REG_W(s1,r_``name``_``s1, size, name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, size, name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, size, name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, size, name``_``s3, name``_``s4) \
    `VPM_REG_W(s5,r_``name``_``s5, size, name``_``s4, name``_``s5) \
    `VPM_REG_W(s6,r_``name``_``s6, size, name``_``s5, name``_``s6) \
    `VPM_REG_W(s7,r_``name``_``s7, size, name``_``s6, name``_``s7) \
    `VPM_REG_W(s8,r_``name``_``s8, size, name``_``s7, name``_``s8) \
    `VPM_REG_W(s9,r_``name``_``s9, size, name``_``s8, name``_``s9)

`define VPM_WPIPE_11(name,size,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10) \
    `VPM_VPIPE_11(name,size,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10) \
    `VPM_REG_W(s1, r_``name``_``s1,  size, name``_``s0, name``_``s1) \
    `VPM_REG_W(s2, r_``name``_``s2,  size, name``_``s1, name``_``s2) \
    `VPM_REG_W(s3, r_``name``_``s3,  size, name``_``s2, name``_``s3) \
    `VPM_REG_W(s4, r_``name``_``s4,  size, name``_``s3, name``_``s4) \
    `VPM_REG_W(s5, r_``name``_``s5,  size, name``_``s4, name``_``s5) \
    `VPM_REG_W(s6, r_``name``_``s6,  size, name``_``s5, name``_``s6) \
    `VPM_REG_W(s7, r_``name``_``s7,  size, name``_``s6, name``_``s7) \
    `VPM_REG_W(s8, r_``name``_``s8,  size, name``_``s7, name``_``s8) \
    `VPM_REG_W(s9, r_``name``_``s9,  size, name``_``s8, name``_``s9) \
    `VPM_REG_W(s10,r_``name``_``s10, size, name``_``s9, name``_``s10)

`define VPM_APIPE_1(name,size0,size1,s0) \
    wire [size0-1:0][size1-1:0] name``_``s0;

`define VPM_APIPE_2(name,size0,size1,s0,s1) \
    wire [size0-1:0][size1-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0] name``_``s1; 

`define VPM_APIPE_3(name,size0,size1,s0,s1,s2) \
    wire [size0-1:0][size1-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0] name``_``s2; 

`define VPM_APIPE_4(name,size0,size1,s0,s1,s2,s3) \
    wire [size0-1:0][size1-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0] name``_``s2; \
    wire [size0-1:0][size1-1:0] name``_``s3; 

`define VPM_APIPE_5(name,size0,size1,s0,s1,s2,s3,s4) \
    wire [size0-1:0][size1-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0] name``_``s2; \
    wire [size0-1:0][size1-1:0] name``_``s3; \
    wire [size0-1:0][size1-1:0] name``_``s4; 

`define VPM_APIPE_6(name,size0,size1,s0,s1,s2,s3,s4,s5) \
    wire [size0-1:0][size1-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0] name``_``s2; \
    wire [size0-1:0][size1-1:0] name``_``s3; \
    wire [size0-1:0][size1-1:0] name``_``s4; \
    wire [size0-1:0][size1-1:0] name``_``s5; 

`define VPM_APIPE_7(name,size0,size1,s0,s1,s2,s3,s4,s5,s6) \
    wire [size0-1:0][size1-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0] name``_``s2; \
    wire [size0-1:0][size1-1:0] name``_``s3; \
    wire [size0-1:0][size1-1:0] name``_``s4; \
    wire [size0-1:0][size1-1:0] name``_``s5; \
    wire [size0-1:0][size1-1:0] name``_``s6; 

`define VPM_APIPE_8(name,size0,size1,s0,s1,s2,s3,s4,s5,s6,s7) \
    wire [size0-1:0][size1-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0] name``_``s2; \
    wire [size0-1:0][size1-1:0] name``_``s3; \
    wire [size0-1:0][size1-1:0] name``_``s4; \
    wire [size0-1:0][size1-1:0] name``_``s5; \
    wire [size0-1:0][size1-1:0] name``_``s6; \
    wire [size0-1:0][size1-1:0] name``_``s7; 

`define VPM_APIPE_9(name,size0,size1,s0,s1,s2,s3,s4,s5,s6,s7,s8) \
    wire [size0-1:0][size1-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0] name``_``s2; \
    wire [size0-1:0][size1-1:0] name``_``s3; \
    wire [size0-1:0][size1-1:0] name``_``s4; \
    wire [size0-1:0][size1-1:0] name``_``s5; \
    wire [size0-1:0][size1-1:0] name``_``s6; \
    wire [size0-1:0][size1-1:0] name``_``s7; \
    wire [size0-1:0][size1-1:0] name``_``s8; 

`define VPM_APIPE_10(name,size0,size1,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9) \
    wire [size0-1:0][size1-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0] name``_``s2; \
    wire [size0-1:0][size1-1:0] name``_``s3; \
    wire [size0-1:0][size1-1:0] name``_``s4; \
    wire [size0-1:0][size1-1:0] name``_``s5; \
    wire [size0-1:0][size1-1:0] name``_``s6; \
    wire [size0-1:0][size1-1:0] name``_``s7; \
    wire [size0-1:0][size1-1:0] name``_``s8; \
    wire [size0-1:0][size1-1:0] name``_``s9; 

`define VPM_APIPE_11(name,size0,size1,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10) \
    wire [size0-1:0][size1-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0] name``_``s2; \
    wire [size0-1:0][size1-1:0] name``_``s3; \
    wire [size0-1:0][size1-1:0] name``_``s4; \
    wire [size0-1:0][size1-1:0] name``_``s5; \
    wire [size0-1:0][size1-1:0] name``_``s6; \
    wire [size0-1:0][size1-1:0] name``_``s7; \
    wire [size0-1:0][size1-1:0] name``_``s8; \
    wire [size0-1:0][size1-1:0] name``_``s9; \
    wire [size0-1:0][size1-1:0] name``_``s10; 

`define VPM_PPIPE_1(name,size0,size1,s0) \
    `VPM_APIPE_1(name,size0,size1,s0)

`define VPM_PPIPE_2(name,size0,size1,s0,s1) \
    `VPM_APIPE_2(name,size0,size1,s0,s1) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1), name``_``s0, name``_``s1)

`define VPM_PPIPE_3(name,size0,size1,s0,s1,s2) \
    `VPM_APIPE_3(name,size0,size1,s0,s1,s2) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, (size0*size1), name``_``s1, name``_``s2)

`define VPM_PPIPE_4(name,size0,size1,s0,s1,s2,s3) \
    `VPM_APIPE_4(name,size0,size1,s0,s1,s2,s3) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, (size0*size1), name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, (size0*size1), name``_``s2, name``_``s3)

`define VPM_PPIPE_5(name,size0,size1,s0,s1,s2,s3,s4) \
    `VPM_APIPE_5(name,size0,size1,s0,s1,s2,s3,s4) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, (size0*size1), name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, (size0*size1), name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, (size0*size1), name``_``s3, name``_``s4)

`define VPM_PPIPE_6(name,size0,size1,s0,s1,s2,s3,s4,s5) \
    `VPM_APIPE_6(name,size0,size1,s0,s1,s2,s3,s4,s5) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, (size0*size1), name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, (size0*size1), name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, (size0*size1), name``_``s3, name``_``s4) \
    `VPM_REG_W(s5,r_``name``_``s5, (size0*size1), name``_``s4, name``_``s5)

`define VPM_PPIPE_7(name,size0,size1,s0,s1,s2,s3,s4,s5,s6) \
    `VPM_APIPE_7(name,size0,size1,s0,s1,s2,s3,s4,s5,s6) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, (size0*size1), name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, (size0*size1), name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, (size0*size1), name``_``s3, name``_``s4) \
    `VPM_REG_W(s5,r_``name``_``s5, (size0*size1), name``_``s4, name``_``s5) \
    `VPM_REG_W(s6,r_``name``_``s6, (size0*size1), name``_``s5, name``_``s6)

`define VPM_PPIPE_8(name,size0,size1,s0,s1,s2,s3,s4,s5,s6,s7) \
    `VPM_APIPE_8(name,size0,size1,s0,s1,s2,s3,s4,s5,s6,s7) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, (size0*size1), name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, (size0*size1), name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, (size0*size1), name``_``s3, name``_``s4) \
    `VPM_REG_W(s5,r_``name``_``s5, (size0*size1), name``_``s4, name``_``s5) \
    `VPM_REG_W(s6,r_``name``_``s6, (size0*size1), name``_``s5, name``_``s6) \
    `VPM_REG_W(s7,r_``name``_``s7, (size0*size1), name``_``s6, name``_``s7)

`define VPM_PPIPE_9(name,size0,size1,s0,s1,s2,s3,s4,s5,s6,s7,s8) \
    `VPM_APIPE_9(name,size0,size1,s0,s1,s2,s3,s4,s5,s6,s7,s8) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, (size0*size1), name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, (size0*size1), name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, (size0*size1), name``_``s3, name``_``s4) \
    `VPM_REG_W(s5,r_``name``_``s5, (size0*size1), name``_``s4, name``_``s5) \
    `VPM_REG_W(s6,r_``name``_``s6, (size0*size1), name``_``s5, name``_``s6) \
    `VPM_REG_W(s7,r_``name``_``s7, (size0*size1), name``_``s6, name``_``s7) \
    `VPM_REG_W(s8,r_``name``_``s8, (size0*size1), name``_``s7, name``_``s8)

`define VPM_PPIPE_10(name,size0,size1,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9) \
    `VPM_APIPE_10(name,size0,size1,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, (size0*size1), name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, (size0*size1), name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, (size0*size1), name``_``s3, name``_``s4) \
    `VPM_REG_W(s5,r_``name``_``s5, (size0*size1), name``_``s4, name``_``s5) \
    `VPM_REG_W(s6,r_``name``_``s6, (size0*size1), name``_``s5, name``_``s6) \
    `VPM_REG_W(s7,r_``name``_``s7, (size0*size1), name``_``s6, name``_``s7) \
    `VPM_REG_W(s8,r_``name``_``s8, (size0*size1), name``_``s7, name``_``s8) \
    `VPM_REG_W(s9,r_``name``_``s9, (size0*size1), name``_``s8, name``_``s9)

`define VPM_PPIPE_11(name,size0,size1,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10) \
    `VPM_APIPE_11(name,size0,size1,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10) \
    `VPM_REG_W(s1, r_``name``_``s1,  (size0*size1), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2, r_``name``_``s2,  (size0*size1), name``_``s1, name``_``s2) \
    `VPM_REG_W(s3, r_``name``_``s3,  (size0*size1), name``_``s2, name``_``s3) \
    `VPM_REG_W(s4, r_``name``_``s4,  (size0*size1), name``_``s3, name``_``s4) \
    `VPM_REG_W(s5, r_``name``_``s5,  (size0*size1), name``_``s4, name``_``s5) \
    `VPM_REG_W(s6, r_``name``_``s6,  (size0*size1), name``_``s5, name``_``s6) \
    `VPM_REG_W(s7, r_``name``_``s7,  (size0*size1), name``_``s6, name``_``s7) \
    `VPM_REG_W(s8, r_``name``_``s8,  (size0*size1), name``_``s7, name``_``s8) \
    `VPM_REG_W(s9, r_``name``_``s9,  (size0*size1), name``_``s8, name``_``s9) \
    `VPM_REG_W(s10,r_``name``_``s10, (size0*size1), name``_``s9, name``_``s10)

`define VPM_BPIPE_1(name,size0,size1,size2,s0) \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s0;

`define VPM_BPIPE_2(name,size0,size1,size2,s0,s1) \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s1; 

`define VPM_BPIPE_3(name,size0,size1,size2,s0,s1,s2) \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s2; 

`define VPM_BPIPE_4(name,size0,size1,size2,s0,s1,s2,s3) \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s2; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s3; 

`define VPM_BPIPE_5(name,size0,size1,size2,s0,s1,s2,s3,s4) \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s2; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s3; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s4; 

`define VPM_BPIPE_6(name,size0,size1,size2,s0,s1,s2,s3,s4,s5) \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s2; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s3; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s4; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s5; 

`define VPM_BPIPE_7(name,size0,size1,size2,s0,s1,s2,s3,s4,s5,s6) \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s2; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s3; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s4; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s5; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s6; 

`define VPM_BPIPE_8(name,size0,size1,size2,s0,s1,s2,s3,s4,s5,s6,s7) \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s2; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s3; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s4; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s5; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s6; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s7; 

`define VPM_BPIPE_9(name,size0,size1,size2,s0,s1,s2,s3,s4,s5,s6,s7,s8) \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s2; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s3; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s4; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s5; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s6; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s7; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s8; 

`define VPM_BPIPE_10(name,size0,size1,size2,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9) \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s2; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s3; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s4; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s5; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s6; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s7; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s8; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s9; 

`define VPM_BPIPE_11(name,size0,size1,size2,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10) \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s0; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s1; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s2; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s3; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s4; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s5; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s6; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s7; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s8; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s9; \
    wire [size0-1:0][size1-1:0][size2-1:0] name``_``s10; 

`define VPM_TPIPE_1(name,size0,size1,size2,s0) \
    `VPM_BPIPE_1(name,size0,size1,size2,s0)

`define VPM_TPIPE_2(name,size0,size1,size2,s0,s1) \
    `VPM_BPIPE_2(name,size0,size1,size2,s0,s1) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1*size2), name``_``s0, name``_``s1)

`define VPM_TPIPE_3(name,size0,size1,size2,s0,s1,s2) \
    `VPM_BPIPE_3(name,size0,size1,size2,s0,s1,s2) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1*size2), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, (size0*size1*size2), name``_``s1, name``_``s2)

`define VPM_TPIPE_4(name,size0,size1,size2,s0,s1,s2,s3) \
    `VPM_BPIPE_4(name,size0,size1,size2,s0,s1,s2,s3) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1*size2), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, (size0*size1*size2), name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, (size0*size1*size2), name``_``s2, name``_``s3)

`define VPM_TPIPE_5(name,size0,size1,size2,s0,s1,s2,s3,s4) \
    `VPM_BPIPE_5(name,size0,size1,size2,s0,s1,s2,s3,s4) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1*size2), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, (size0*size1*size2), name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, (size0*size1*size2), name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, (size0*size1*size2), name``_``s3, name``_``s4)

`define VPM_TPIPE_6(name,size0,size1,size2,s0,s1,s2,s3,s4,s5) \
    `VPM_BPIPE_6(name,size0,size1,size2,s0,s1,s2,s3,s4,s5) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1*size2), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, (size0*size1*size2), name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, (size0*size1*size2), name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, (size0*size1*size2), name``_``s3, name``_``s4) \
    `VPM_REG_W(s5,r_``name``_``s5, (size0*size1*size2), name``_``s4, name``_``s5)

`define VPM_TPIPE_7(name,size0,size1,size2,s0,s1,s2,s3,s4,s5,s6) \
    `VPM_BPIPE_7(name,size0,size1,size2,s0,s1,s2,s3,s4,s5,s6) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1*size2), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, (size0*size1*size2), name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, (size0*size1*size2), name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, (size0*size1*size2), name``_``s3, name``_``s4) \
    `VPM_REG_W(s5,r_``name``_``s5, (size0*size1*size2), name``_``s4, name``_``s5) \
    `VPM_REG_W(s6,r_``name``_``s6, (size0*size1*size2), name``_``s5, name``_``s6)

`define VPM_TPIPE_8(name,size0,size1,size2,s0,s1,s2,s3,s4,s5,s6,s7) \
    `VPM_BPIPE_8(name,size0,size1,size2,s0,s1,s2,s3,s4,s5,s6,s7) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1*size2), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, (size0*size1*size2), name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, (size0*size1*size2), name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, (size0*size1*size2), name``_``s3, name``_``s4) \
    `VPM_REG_W(s5,r_``name``_``s5, (size0*size1*size2), name``_``s4, name``_``s5) \
    `VPM_REG_W(s6,r_``name``_``s6, (size0*size1*size2), name``_``s5, name``_``s6) \
    `VPM_REG_W(s7,r_``name``_``s7, (size0*size1*size2), name``_``s6, name``_``s7)

`define VPM_TPIPE_9(name,size0,size1,size2,s0,s1,s2,s3,s4,s5,s6,s7,s8) \
    `VPM_BPIPE_9(name,size0,size1,size2,s0,s1,s2,s3,s4,s5,s6,s7,s8) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1*size2), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, (size0*size1*size2), name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, (size0*size1*size2), name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, (size0*size1*size2), name``_``s3, name``_``s4) \
    `VPM_REG_W(s5,r_``name``_``s5, (size0*size1*size2), name``_``s4, name``_``s5) \
    `VPM_REG_W(s6,r_``name``_``s6, (size0*size1*size2), name``_``s5, name``_``s6) \
    `VPM_REG_W(s7,r_``name``_``s7, (size0*size1*size2), name``_``s6, name``_``s7) \
    `VPM_REG_W(s8,r_``name``_``s8, (size0*size1*size2), name``_``s7, name``_``s8)

`define VPM_TPIPE_10(name,size0,size1,size2,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9) \
    `VPM_BPIPE_10(name,size0,size1,size2,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9) \
    `VPM_REG_W(s1,r_``name``_``s1, (size0*size1*size2), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2,r_``name``_``s2, (size0*size1*size2), name``_``s1, name``_``s2) \
    `VPM_REG_W(s3,r_``name``_``s3, (size0*size1*size2), name``_``s2, name``_``s3) \
    `VPM_REG_W(s4,r_``name``_``s4, (size0*size1*size2), name``_``s3, name``_``s4) \
    `VPM_REG_W(s5,r_``name``_``s5, (size0*size1*size2), name``_``s4, name``_``s5) \
    `VPM_REG_W(s6,r_``name``_``s6, (size0*size1*size2), name``_``s5, name``_``s6) \
    `VPM_REG_W(s7,r_``name``_``s7, (size0*size1*size2), name``_``s6, name``_``s7) \
    `VPM_REG_W(s8,r_``name``_``s8, (size0*size1*size2), name``_``s7, name``_``s8) \
    `VPM_REG_W(s9,r_``name``_``s9, (size0*size1*size2), name``_``s8, name``_``s9)

`define VPM_TPIPE_11(name,size0,size1,size2,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10) \
    `VPM_BPIPE_11(name,size0,size1,size2,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10) \
    `VPM_REG_W(s1, r_``name``_``s1,  (size0*size1*size2), name``_``s0, name``_``s1) \
    `VPM_REG_W(s2, r_``name``_``s2,  (size0*size1*size2), name``_``s1, name``_``s2) \
    `VPM_REG_W(s3, r_``name``_``s3,  (size0*size1*size2), name``_``s2, name``_``s3) \
    `VPM_REG_W(s4, r_``name``_``s4,  (size0*size1*size2), name``_``s3, name``_``s4) \
    `VPM_REG_W(s5, r_``name``_``s5,  (size0*size1*size2), name``_``s4, name``_``s5) \
    `VPM_REG_W(s6, r_``name``_``s6,  (size0*size1*size2), name``_``s5, name``_``s6) \
    `VPM_REG_W(s7, r_``name``_``s7,  (size0*size1*size2), name``_``s6, name``_``s7) \
    `VPM_REG_W(s8, r_``name``_``s8,  (size0*size1*size2), name``_``s7, name``_``s8) \
    `VPM_REG_W(s9, r_``name``_``s9,  (size0*size1*size2), name``_``s8, name``_``s9) \
    `VPM_REG_W(s10,r_``name``_``s10, (size0*size1*size2), name``_``s9, name``_``s10)

`define VPM_NPIPE_1(name,s0) \
    wire name``_``s0; 

`define VPM_NPIPE_2(name,s0,s1) \
    wire name``_``s0; \
    wire name``_``s1; 

`define VPM_NPIPE_3(name,s0,s1,s2) \
    wire name``_``s0; \
    wire name``_``s1; \
    wire name``_``s2; 

`define VPM_NPIPE_4(name,s0,s1,s2,s3) \
    wire name``_``s0; \
    wire name``_``s1; \
    wire name``_``s2; \
    wire name``_``s3; 

`define VPM_NPIPE_5(name,s0,s1,s2,s3,s4) \
    wire name``_``s0; \
    wire name``_``s1; \
    wire name``_``s2; \
    wire name``_``s3; \
    wire name``_``s4; 

`define VPM_NPIPE_6(name,s0,s1,s2,s3,s4,s5) \
    wire name``_``s0; \
    wire name``_``s1; \
    wire name``_``s2; \
    wire name``_``s3; \
    wire name``_``s4; \
    wire name``_``s5; 

`define VPM_NPIPE_7(name,s0,s1,s2,s3,s4,s5,s6) \
    wire name``_``s0; \
    wire name``_``s1; \
    wire name``_``s2; \
    wire name``_``s3; \
    wire name``_``s4; \
    wire name``_``s5; \
    wire name``_``s6; 

`define VPM_NPIPE_8(name,s0,s1,s2,s3,s4,s5,s6,s7) \
    wire name``_``s0; \
    wire name``_``s1; \
    wire name``_``s2; \
    wire name``_``s3; \
    wire name``_``s4; \
    wire name``_``s5; \
    wire name``_``s6; \
    wire name``_``s7; 

`define VPM_NPIPE_9(name,s0,s1,s2,s3,s4,s5,s6,s7,s8) \
    wire name``_``s0; \
    wire name``_``s1; \
    wire name``_``s2; \
    wire name``_``s3; \
    wire name``_``s4; \
    wire name``_``s5; \
    wire name``_``s6; \
    wire name``_``s7; \
    wire name``_``s8; 

`define VPM_NPIPE_10(name,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9) \
    wire name``_``s0; \
    wire name``_``s1; \
    wire name``_``s2; \
    wire name``_``s3; \
    wire name``_``s4; \
    wire name``_``s5; \
    wire name``_``s6; \
    wire name``_``s7; \
    wire name``_``s8; \
    wire name``_``s9; 

`define VPM_NPIPE_11(name,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10) \
    wire name``_``s0; \
    wire name``_``s1; \
    wire name``_``s2; \
    wire name``_``s3; \
    wire name``_``s4; \
    wire name``_``s5; \
    wire name``_``s6; \
    wire name``_``s7; \
    wire name``_``s8; \
    wire name``_``s9; \
    wire name``_``s10; 

`define VPM_SPIPE_1(name,s0) \
    `VPM_NPIPE_1(name,s0)

`define VPM_SPIPE_2(name,s0,s1) \
    `VPM_NPIPE_2(name,s0,s1) \
    `VPM_REG_1(s1,r_``name``_``s1, name``_``s0, name``_``s1)

`define VPM_SPIPE_3(name,s0,s1,s2) \
    `VPM_NPIPE_3(name,s0,s1,s2) \
    `VPM_REG_1(s1,r_``name``_``s1, name``_``s0, name``_``s1) \
    `VPM_REG_1(s2,r_``name``_``s2, name``_``s1, name``_``s2)

`define VPM_SPIPE_4(name,s0,s1,s2,s3) \
    `VPM_NPIPE_4(name,s0,s1,s2,s3) \
    `VPM_REG_1(s1,r_``name``_``s1, name``_``s0, name``_``s1) \
    `VPM_REG_1(s2,r_``name``_``s2, name``_``s1, name``_``s2) \
    `VPM_REG_1(s3,r_``name``_``s3, name``_``s2, name``_``s3)

`define VPM_SPIPE_5(name,s0,s1,s2,s3,s4) \
    `VPM_NPIPE_5(name,s0,s1,s2,s3,s4) \
    `VPM_REG_1(s1,r_``name``_``s1, name``_``s0, name``_``s1) \
    `VPM_REG_1(s2,r_``name``_``s2, name``_``s1, name``_``s2) \
    `VPM_REG_1(s3,r_``name``_``s3, name``_``s2, name``_``s3) \
    `VPM_REG_1(s4,r_``name``_``s4, name``_``s3, name``_``s4)

`define VPM_SPIPE_6(name,s0,s1,s2,s3,s4,s5) \
    `VPM_NPIPE_6(name,s0,s1,s2,s3,s4,s5) \
    `VPM_REG_1(s1,r_``name``_``s1, name``_``s0, name``_``s1) \
    `VPM_REG_1(s2,r_``name``_``s2, name``_``s1, name``_``s2) \
    `VPM_REG_1(s3,r_``name``_``s3, name``_``s2, name``_``s3) \
    `VPM_REG_1(s4,r_``name``_``s4, name``_``s3, name``_``s4) \
    `VPM_REG_1(s5,r_``name``_``s5, name``_``s4, name``_``s5)

`define VPM_SPIPE_7(name,s0,s1,s2,s3,s4,s5,s6) \
    `VPM_NPIPE_7(name,s0,s1,s2,s3,s4,s5,s6) \
    `VPM_REG_1(s1,r_``name``_``s1, name``_``s0, name``_``s1) \
    `VPM_REG_1(s2,r_``name``_``s2, name``_``s1, name``_``s2) \
    `VPM_REG_1(s3,r_``name``_``s3, name``_``s2, name``_``s3) \
    `VPM_REG_1(s4,r_``name``_``s4, name``_``s3, name``_``s4) \
    `VPM_REG_1(s5,r_``name``_``s5, name``_``s4, name``_``s5) \
    `VPM_REG_1(s6,r_``name``_``s6, name``_``s5, name``_``s6)

`define VPM_SPIPE_8(name,s0,s1,s2,s3,s4,s5,s6,s7) \
    `VPM_NPIPE_8(name,s0,s1,s2,s3,s4,s5,s6,s7) \
    `VPM_REG_1(s1,r_``name``_``s1, name``_``s0, name``_``s1) \
    `VPM_REG_1(s2,r_``name``_``s2, name``_``s1, name``_``s2) \
    `VPM_REG_1(s3,r_``name``_``s3, name``_``s2, name``_``s3) \
    `VPM_REG_1(s4,r_``name``_``s4, name``_``s3, name``_``s4) \
    `VPM_REG_1(s5,r_``name``_``s5, name``_``s4, name``_``s5) \
    `VPM_REG_1(s6,r_``name``_``s6, name``_``s5, name``_``s6) \
    `VPM_REG_1(s7,r_``name``_``s7, name``_``s6, name``_``s7)

`define VPM_SPIPE_9(name,s0,s1,s2,s3,s4,s5,s6,s7,s8) \
    `VPM_NPIPE_9(name,s0,s1,s2,s3,s4,s5,s6,s7,s8) \
    `VPM_REG_1(s1,r_``name``_``s1, name``_``s0, name``_``s1) \
    `VPM_REG_1(s2,r_``name``_``s2, name``_``s1, name``_``s2) \
    `VPM_REG_1(s3,r_``name``_``s3, name``_``s2, name``_``s3) \
    `VPM_REG_1(s4,r_``name``_``s4, name``_``s3, name``_``s4) \
    `VPM_REG_1(s5,r_``name``_``s5, name``_``s4, name``_``s5) \
    `VPM_REG_1(s6,r_``name``_``s6, name``_``s5, name``_``s6) \
    `VPM_REG_1(s7,r_``name``_``s7, name``_``s6, name``_``s7) \
    `VPM_REG_1(s8,r_``name``_``s8, name``_``s7, name``_``s8)

`define VPM_SPIPE_10(name,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9) \
    `VPM_NPIPE_10(name,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9) \
    `VPM_REG_1(s1,r_``name``_``s1, name``_``s0, name``_``s1) \
    `VPM_REG_1(s2,r_``name``_``s2, name``_``s1, name``_``s2) \
    `VPM_REG_1(s3,r_``name``_``s3, name``_``s2, name``_``s3) \
    `VPM_REG_1(s4,r_``name``_``s4, name``_``s3, name``_``s4) \
    `VPM_REG_1(s5,r_``name``_``s5, name``_``s4, name``_``s5) \
    `VPM_REG_1(s6,r_``name``_``s6, name``_``s5, name``_``s6) \
    `VPM_REG_1(s7,r_``name``_``s7, name``_``s6, name``_``s7) \
    `VPM_REG_1(s8,r_``name``_``s8, name``_``s7, name``_``s8) \
    `VPM_REG_1(s9,r_``name``_``s9, name``_``s8, name``_``s9)

`define VPM_SPIPE_11(name,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10) \
    `VPM_NPIPE_11(name,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10) \
    `VPM_REG_1(s1, r_``name``_``s1,  name``_``s0, name``_``s1) \
    `VPM_REG_1(s2, r_``name``_``s2,  name``_``s1, name``_``s2) \
    `VPM_REG_1(s3, r_``name``_``s3,  name``_``s2, name``_``s3) \
    `VPM_REG_1(s4, r_``name``_``s4,  name``_``s3, name``_``s4) \
    `VPM_REG_1(s5, r_``name``_``s5,  name``_``s4, name``_``s5) \
    `VPM_REG_1(s6, r_``name``_``s6,  name``_``s5, name``_``s6) \
    `VPM_REG_1(s7, r_``name``_``s7,  name``_``s6, name``_``s7) \
    `VPM_REG_1(s8, r_``name``_``s8,  name``_``s7, name``_``s8) \
    `VPM_REG_1(s9, r_``name``_``s9,  name``_``s8, name``_``s9) \
    `VPM_REG_1(s10,r_``name``_``s10, name``_``s9, name``_``s10)

`endif // INCLUDE_VPM
