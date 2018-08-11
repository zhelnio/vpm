# vpm
Verilog pipeline macros

## Tested
- [x] Cadence Xcelium 18.03
- [x] Mentor Modelsim 10.5b (Intel Starter Edition)
- [x] Icarus Verilog 10.2
- [x] Xilinx Vivado 2018.2 (simulation+synthesis)
- [x] Intel Quartus Lite 17.1, 18.0

## Code examples
All the code below have the same simulation and synthesis results:

#### 1. common style pipeline (no macro)
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
    data_O <= data_M2;
end
```

#### 2. primitive based style pipeline (no macro)
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
prm_register_c  r_control_M2 (clk, rst_n,                control_M1, control_M2);
prm_register_c  r_control_M3 (clk, rst_n,                control_M2, control_O);
```

#### 3. VPM macro based pipeline
```verilog
`include "vpm.svh"

`VPM_STAGE_C(I)
`VPM_STAGE_CC(M1)
`VPM_STAGE_C(M2)
`VPM_STAGE_C(M3)
`VPM_STAGE_C(O)

`VPM_PIPE_5(data, DATA_WIDTH, I, M1, M2, M3, O)
`VPM_PIPE_4(control, 1, I, M1, M2, O)
```
#### 4. VPM macro based pipeline (preprocessed)
This code is the result of **iverilog -E** over the source example #3
```verilog
module tb_pipeline
#(
    parameter DATA_WIDTH = 8
)(
    input  wire                  clk,
    input  wire                  rst_n,
    input  wire [DATA_WIDTH-1:0] idata,
    output wire [DATA_WIDTH-1:0] odata
);
    wire hz_flush_n_M1;
    wire [DATA_WIDTH-1:0] data_I;
    wire [DATA_WIDTH-1:0] data_M1;
    wire [DATA_WIDTH-1:0] data_M2;
    wire [DATA_WIDTH-1:0] data_M3;
    wire [DATA_WIDTH-1:0] data_O;
    prm_register_cc #(DATA_WIDTH) r_data_M1 (clk, rst_n, hz_flush_n_M1, data_I, data_M1);
    prm_register_c #(DATA_WIDTH) r_data_M2 (clk, rst_n, data_M1, data_M2);
    prm_register_c #(DATA_WIDTH) r_data_M3 (clk, rst_n, data_M2, data_M3);
    prm_register_c #(DATA_WIDTH) r_data_O (clk, rst_n, data_M3, data_O);
    wire [1-1:0] control_I;
    wire [1-1:0] control_M1;
    wire [1-1:0] control_M2;
    wire [1-1:0] control_O;
    prm_register_cc #(1) r_control_M1 (clk, rst_n, hz_flush_n_M1, control_I, control_M1);
    prm_register_c #(1) r_control_M2 (clk, rst_n, control_M1, control_M2);
    prm_register_c #(1) r_control_O (clk, rst_n, control_M2, control_O);
    assign data_I    = idata;
    assign odata     = data_O;
    assign control_I = idata[0];
    assign hz_flush_n_M1 = 1'b1;
endmodule
```

## Make targets
```
$ make
make help           - show this message
make clean          - delete temp dirs
make xcelium_gui    - run simulation using Cadence Xcelium (console mode)
make xcelium_cmd    - run simulation using Cadence Xcelium (gui mode)
make xsim_cmd       - run simulation using Xilinx Vivado Xsim (console mode)
make xsim_gui       - run simulation using Xilinx Vivado Xsim (gui mode)
make modelsim_cmd   - run simulation using Mentor Modelsim (console mode)
make modelsim_gui   - run simulation using Mentor Modelsim (gui mode)
make iverilog_cmd   - run simulation using Icarus Verilog (console mode)
make iverilog_gui   - run simulation using Icarus Verilog (gui mode)
make iverilog_macro - use Icarus Verilog to preprocess macros without compilation
make vivado_load    - init Xilinx Vivado project
make vivado_syn     - run synthesis using Xilinx Vivado (console mode)
make vivado_gui     - open Xilinx Vivado project (gui)
make quartus_load   - init Intel Quartus project
make quartus_syn    - run synthesis using Intel Quartus (console mode)
make quartus_gui    - open Intel Quartus project (gui)
```
