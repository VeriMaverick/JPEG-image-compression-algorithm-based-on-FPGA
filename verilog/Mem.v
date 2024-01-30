module Mem(
Clock,
Reset_n,
In_Data,
En_In,
Out_Data,
En_Out
);

input Clock;
input Reset_n;
input signed [9:0] In_Data;
input En_In;

output signed [9:0] Out_Data;
output En_Out;

reg signed [9:0] Cache;        //Input Data Cache
reg [5:0] W_Address;    //Data write address
reg W_En;               //Data write enable signal
reg [5:0] R_Address;    //Data read address
reg R_En;               //Data read enable signal
reg W_En_0 ;            //Chip 0 data write enable signal
reg W_En_1 ;            //Chip 1 data write enable signal
reg R_En_0 ;            //Chip 0 data read enable signal
reg R_En_1 ;            //Chip 1 data read enable signal
reg [5:0] Address_0 ;   //Chip 0 address
reg [5:0] Address_1 ;   //Chip 1 address
reg Chip_Sele ;         //Chip selection signal
reg Chip_Sele_DFF;      //Chip selection signal DFF
reg En_Out;             //Output enable signal
reg signed[9:0] Out_Data;

wire signed [9:0] RAM_Mem_0_Out;//Chip 0 output data
wire signed [9:0] RAM_Mem_1_Out;//Chip 1 output data

//Instantiating Rem_0 modules
RAM_Mem	U0_RAM_Mem(
	.address ( Address_0 ),
	.clock ( Clock ),
	.data ( Cache ),
	.rden ( R_En_0 ),
	.wren ( W_En_0 ),
	.q ( RAM_Mem_0_Out )
	);

//Instantiating Rem_1 modules
RAM_Mem	U1_RAM_Mem(
	.address ( Address_1 ),
	.clock ( Clock ),
	.data ( Cache ),
	.rden ( R_En_1 ),
	.wren ( W_En_1 ),
	.q ( RAM_Mem_1_Out )
	);

//Input Data Cache
always @( posedge Clock or negedge Reset_n )
begin
    if( !Reset_n )
        Cache <= 10'd0;
    else 
        Cache <= In_Data;
end

//Mem Write enable control
always @( posedge Clock or negedge Reset_n )
begin
    if( !Reset_n )
        W_En <= 1'b0;
    else if(En_In)
        W_En <= 1'b1;
    else
        W_En <= 1'b0;
end

//Mem Write control
always @( posedge Clock or negedge Reset_n )
begin
    if(!Reset_n)
        W_Address <= 6'd63;
    else if(En_In)
        begin
            if(W_Address == 6'd63) //If the last data is written, start writing from scratch
                W_Address <= 6'd0;
            else
                W_Address <= W_Address + 6'd1; // Write in sequence 0~63
        end
    else
        W_Address <= W_Address;
end

//Mem read enable control
always @(posedge Clock or negedge Reset_n)
begin
    if(!Reset_n)
	    R_En <= 1'b0;
    else if( R_Address == 6'd63 ) //If the last bit is read
        begin
	        if( (W_Address == 6'd63) && W_En) // The operation can be read when one of the ROMs is finished
                R_En <= 1'b1;
	        else 
		        R_En <= 1'b0;
        end
    else 
	    R_En <= R_En ;
end

//Mem read control
always @(posedge Clock or negedge Reset_n)
begin
    if(!Reset_n)
        R_Address <= 6'd63;
    else if(R_Address == 6'd63) //If the last bit is read
        begin
            if( (W_Address == 6'd63) && W_En )//At the same time, there is already RAM written. The read address can be reset to 0
                R_Address <= 6'd0;
            else
                R_Address <= R_Address;
        end
    else if(R_En)
        R_Address <= R_Address + 1'b1;
    else
        R_Address <= R_Address;
end  

//Ping_pang Control
always @(posedge Clock or negedge Reset_n)
begin
    if(!Reset_n)
        Chip_Sele <= 1'b0;
    else if( (W_Address == 6'd63) && W_En)//If the write enable is valid (continue writing) and the last bit is written, switch RAM
        Chip_Sele <= ~Chip_Sele;//Switching RAM-chips
    else
        Chip_Sele <= Chip_Sele;
end

//Wait for the data to be processed before outputting the enable signal
always@( posedge Clock or negedge Reset_n )
begin
    if(!Reset_n)
        En_Out <= 1'b0;
    else if(R_En)
        En_Out <= 1'b1;
    else
        En_Out <= 1'b0;
end

//Combinatorial logic
//Ping_pang Control
always@( * )
begin
    if(Chip_Sele)
        begin
            W_En_0 = 1'b0;
            W_En_1 = W_En;
            R_En_0 = R_En;
            R_En_1 = 1'b0;
            Address_0 = {R_Address[2:0],R_Address[5:3]};
            Address_1 = W_Address;
        end
    else
        begin
            W_En_0 = W_En;
            W_En_1 = 1'b0;
            R_En_0 = 1'b0;
            R_En_1 = R_En;
            Address_0 = W_Address;
            Address_1 = {R_Address[2:0],R_Address[5:3]};
        end
end

always@( posedge Clock or negedge Reset_n )
begin
    if(!Reset_n)
        Chip_Sele_DFF <= 1'b0;
    else
        Chip_Sele_DFF <= Chip_Sele;
end

//Combinatorial logic
// Output the data read from RAM
always @( * )
begin
    if(Chip_Sele_DFF)
        Out_Data = RAM_Mem_0_Out;
    else
        Out_Data = RAM_Mem_1_Out;
end

endmodule 