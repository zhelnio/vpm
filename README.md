# vpm
Verilog pipeline macros

## Tested
- [x] Cadence Xcelium 18.03
- [x] Mentor Modelsim 10.5b (Intel Starter Edition)
- [x] Icarus Verilog 10.2
- [x] Xilinx Vivado 2018.2 (simulation+synthesis)
- [x] Intel Quartus Lite 17.1, 18.0

## common style
```verilog
wire       hz_flush_n_M1;
wire [7:0] data_I;
wire [7:0] data_M1;
wire [7:0] data_M2;
wire [7:0] data_M3;
wire [7:0] data_O;

wire       control_I;
wire       control_M1;
wire       control_M2;
wire       control_O;

// data pipeline
always @(posedge clk or negedge rst_n) begin
    if(hz_flush_n_M1)
        data_M1 <= data_I;
    else
        data_M1 <= 8'b0;
    data_M2 <= data_M1;
    data_M3 <= data_M2;
    data_O <= data_M3;
end

// control pipeline
always @(posedge clk or negedge rst_n) begin
    if(hz_flush_n_M1)
        control_M1 <= control_I;
    else
        control_M1 <= 8'b0;
    control_M2 <= control_M1;
    data_O <= data_M3;
end
```

## primitive based style
```verilog
wire       hz_flush_n_M1;
wire [7:0] data_I;
wire [7:0] data_M1;
wire [7:0] data_M2;
wire [7:0] data_M3;
wire [7:0] data_O;

wire       control_I;
wire       control_M1;
wire       control_M2;
wire       control_O;

prm_register_cc #(8) r_data_M1 (clk, rst_n, hz_flush_n_M1, data_I,  data_M1);
prm_register_c  #(8) r_data_M2 (clk, rst_n,                data_M1, data_M2);
prm_register_c  #(8) r_data_M3 (clk, rst_n,                data_M2, data_M3);
prm_register_c  #(8) r_data_O  (clk, rst_n,                data_M3, data_O);

prm_register_cc r_control_M1 (clk, rst_n, hz_flush_n_M1, control_I,  control_M1);
prm_register_c  r_control_M1 (clk, rst_n,                control_M1, control_M2);
prm_register_c  r_control_M1 (clk, rst_n,                control_M2, control_O);
```

## VPM macros alternative
```verilog
`include "vpm.svh"

`VPM_STAGE_C(I)
`VPM_STAGE_CC(M1)
`VPM_STAGE_C(M2)
`VPM_STAGE_C(M3)
`VPM_STAGE_C(O)

`VPM_PIPE_5(data, DATA_WIDTH, I, M1, M2, M3, O)
`VPM_PIPE_4(control, 1, I, M1, M2, M3, O)
```
