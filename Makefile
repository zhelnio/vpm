

help:
	$(info make help           - show this message)
	$(info make clean          - delete temp dirs )
	$(info make xcelium_gui    - run simulation using Cadence Xcelium (console))
	$(info make xcelium_cmd    - run simulation using Cadence Xcelium (gui))
	$(info make xsim_cmd       - run simulation using Xilinx Vivado Xsim (console))
	$(info make xsim_gui       - run simulation using Xilinx Vivado Xsim (gui))
	$(info make modelsim_cmd   - run simulation using Mentor Modelsim (console))
	$(info make modelsim_gui   - run simulation using Mentor Modelsim (gui))
	$(info make iverilog_cmd   - run simulation using Icarus Verilog (console))
	$(info make iverilog_gui   - run simulation using Icarus Verilog (gui))
	$(info make iverilog_macro - use Icarus Verilog to preprocess macros without compilation)
	$(info make vivado_load    - init Xilinx Vivado project)
	$(info make vivado_syn     - run synthesis using Xilinx Vivado (console))
	$(info make vivado_gui     - open Xilinx Vivado project (gui))
	$(info make quartus_load   - init Intel Quartus project)
	$(info make quartus_syn    - run synthesis using Intel Quartus (console))
	$(info make quartus_gui    - open Intel Quartus project (gui))
	@true

#############################################
# common options

SIM_DIR = $(PWD)/sim
RUN_DIR = $(PWD)/run
TB_DIR  = $(PWD)/tb
SRC_DIR = $(PWD)/rtl
SYN_DIR = $(PWD)/syn

TB_NAME = tb

#############################################
# common targets

sim: xcelium_cmd

gui: xcelium_gui

clean:
	rm -rf $(SYN_DIR)
	rm -rf $(SIM_DIR)

simdir:
	rm -rf $(SIM_DIR)
	mkdir $(SIM_DIR)

synthdir:
	rm -rf $(SYN_DIR)
	mkdir $(SYN_DIR)

release:
	rm -f vpm.tar.gz
	tar -zcvf vpm.tar.gz ./*

#############################################
# xcelium

XRUN_XIL_LIBS = /opt/simlibs/vivado_2018.2

XRUN_BIN      = cd $(SIM_DIR) && xrun

XRUN_OPT_COMMON  = -64bit
XRUN_OPT_COMMON += -v93
XRUN_OPT_COMMON += -relax
XRUN_OPT_COMMON += -access +rwc
XRUN_OPT_COMMON += -namemap_mixgen
XRUN_OPT_COMMON += -sv
XRUN_OPT_COMMON += -timescale 1ns/10ps
XRUN_OPT_COMMON += -mcdump
XRUN_OPT_COMMON += -linedebug

XRUN_OPT_GUI  = -gui

XRUN_OPT_TB += -top $(TB_NAME)
XRUN_OPT_TB += -libext .v
XRUN_OPT_TB += -libext .sv
XRUN_OPT_TB += $(SRC_DIR)/*.v -incdir $(SRC_DIR)
XRUN_OPT_TB += $(TB_DIR)/*.sv -incdir $(TB_DIR)

xcelium_gui: simdir
	$(XRUN_BIN) $(XRUN_OPT_COMMON) $(XRUN_OPT_TB) $(XRUN_OPT_GUI)

xcelium_cmd: simdir
	$(XRUN_BIN) $(XRUN_OPT_COMMON) $(XRUN_OPT_TB)

#############################################
# vivado xsim

XVLOG_BIN = cd $(SIM_DIR) && xvlog
XELAB_BIN = cd $(SIM_DIR) && xelab
XSIM_BIN  = cd $(SIM_DIR) && xsim

xsim_compile: simdir
	$(XVLOG_BIN) $(SRC_DIR)/*.v
	$(XVLOG_BIN) --sv $(TB_DIR)/*.sv -i $(SRC_DIR)
	$(XELAB_BIN) --incr --debug typical --relax --mt 8 $(TB_NAME) -s tb_sim

xsim_cmd: xsim_compile
	$(XSIM_BIN) tb_sim --runall

xsim_gui: xsim_compile
	$(XSIM_BIN) tb_sim --gui

#############################################
# modelsim

VLIB_BIN = cd $(SIM_DIR) && vlib
VLOG_BIN = cd $(SIM_DIR) && vlog
VSIM_BIN = cd $(SIM_DIR) && vsim

VSIM_OPT_CMD    = -c
VSIM_OPT_COMMON = -novopt work.$(TB_NAME) -do "run -all"

modelsim_compile: simdir
	$(VLIB_BIN) work
	$(VLOG_BIN) $(SRC_DIR)/*.v
	$(VLOG_BIN) $(TB_DIR)/*.sv +incdir+$(SRC_DIR)

modelsim_cmd: modelsim_compile
	$(VSIM_BIN) $(VSIM_OPT_COMMON) $(VSIM_OPT_CMD) 

modelsim_gui: modelsim_compile
	$(VSIM_BIN) $(VSIM_OPT_COMMON)

#############################################
# icarus
IVER_BIN = cd $(SIM_DIR) && iverilog
VVP_BIN  = cd $(SIM_DIR) && vvp
GTK_BIN  = cd $(SIM_DIR) && gtkwave

IVER_OPT  = -g2012
IVER_OPT += -s $(TB_NAME)
IVER_OPT += -I $(SRC_DIR)
IVER_OPT += -D ICARUS
IVER_OPT += $(SRC_DIR)/*.v
IVER_OPT += $(TB_DIR)/*.sv

iverilog_cmd: simdir
	$(IVER_BIN) $(IVER_OPT)
	$(VVP_BIN) -la.lst -n a.out -vcd

iverilog_gui: iverilog_cmd
	$(GTK_BIN) dump.vcd

#############################################
# icarus (preprocess only)

IVER_MACRO_TARGET = tb_pipeline

IVER_MACRO_OPT  = -g2012
IVER_MACRO_OPT += -E
IVER_MACRO_OPT += -I $(SRC_DIR)
IVER_MACRO_OPT += $(TB_DIR)/$(IVER_MACRO_TARGET).sv
IVER_MACRO_OPT += -o a.out

iverilog_macro: simdir
	$(IVER_BIN) $(IVER_MACRO_OPT)
	cd $(SIM_DIR) && grep -v "^\s*$$" a.out > $(IVER_MACRO_TARGET)_o.sv

#############################################
# vivado synth

VIVADO_BIN = cd $(SYN_DIR) && vivado
VIVADO_OPT = -mode batch

vivado_load: synthdir
	$(VIVADO_BIN) $(VIVADO_OPT) -source $(RUN_DIR)/vivado_load.tcl

vivado_syn: vivado_load
	$(VIVADO_BIN) $(VIVADO_OPT) -source $(RUN_DIR)/vivado_syn.tcl

vivado_gui:
	$(VIVADO_BIN) system.xpr &

#############################################
# quartus synth

QUARTUS_BIN    = cd $(SYN_DIR) && quartus
QUARTUS_SH_BIN = cd $(SYN_DIR) && quartus_sh
QUARTUS_PROJECT = tb_pipeline

quartus_load: synthdir
	echo "# This file can be empty" > $(SYN_DIR)/$(QUARTUS_PROJECT).qpf
	cp $(RUN_DIR)/quartus.qsf $(SYN_DIR)/$(QUARTUS_PROJECT).qsf

quartus_syn: quartus_load
	$(QUARTUS_SH_BIN) --flow compile $(QUARTUS_PROJECT)

quartus_gui:
	$(QUARTUS_BIN) $(QUARTUS_PROJECT) &
