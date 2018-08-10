

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
IVER_OPT += $(SRC_DIR)/*.v
IVER_OPT += $(TB_DIR)/*.sv

iverilog_cmd: simdir
	$(IVER_BIN) $(IVER_OPT)
	$(VVP_BIN) -la.lst -n a.out -vcd

iverilog_gui: iverilog_cmd
	$(GTK_BIN) dump.vcd

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
