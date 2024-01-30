###################     ModelSim TCL     ######################## 

set  TB_DIR  ./
set  VL_DIR  ../verilog   

##### Create the Project/Lib ##### 

#vlib work 

# map the library 

#vmap work work 

   

##### Compile the verilog ##### 

vlog ${TB_DIR}/JPEG_DCT_TB.v \
${VL_DIR}/Adder_1.v\
${VL_DIR}/Adder_2.v\
${VL_DIR}/DCT.v\
${VL_DIR}/DCT_1D.v\
${VL_DIR}/DCT_1D_Control_Unit.v\
${VL_DIR}/DCT_1D_D_Flip_Flop_1.v\
${VL_DIR}/DCT_1D_D_Flip_Flop_2.v\
${VL_DIR}/DCT_1D_Data_Path.v\
${VL_DIR}/Dispose.v\
${VL_DIR}/Image.v\
${VL_DIR}/JPEG_DCT.v\
${VL_DIR}/Mem.v\
${VL_DIR}/Multiplier.v\
${VL_DIR}/RAM.v\
${VL_DIR}/RAM_Mem.v\
${VL_DIR}/Receive_8_Pixel.v\
${VL_DIR}/RGB_to_Y.v\
${VL_DIR}/Selector_1_to_4.v\
${VL_DIR}/Selector_4_to_1.v\
${VL_DIR}/Send_8_Pixel.v\
C:/intelFPGA_lite/20.1/quartus/eda/sim_lib/220model.v\
C:/intelFPGA_lite/20.1/quartus/eda/sim_lib/altera_mf.v\


##### Start Simulation ##### 

vsim work.JPEG_DCT_TB

#add wave -binary clk rst
add wave JPEG_DCT/*
#add wave JPEG_DCT/Dispose/*
#add wave JPEG_DCT/DCT/DCT_1D/Data_Out/*
#view wave  

#add wave -unsigned random c_count 

#run 990 
run -all
   

##### Quit the Simulation ##### 

#quit -sim


