module Image(
Clock,
Reset_n,
En_In,
In_Data,//Input data
En_Out,
Out_Data//Output data
);

input Clock;
input Reset_n;
input En_In;
input [7:0] In_Data;

output En_Out;
output [7:0] Out_Data;

reg En_Out;
reg [7:0] Out_Data;

reg [7:0] Cache_8_Pixel ;       //Input Data Cache
reg [11:0] W_Address ;          //Write address
reg W_En ;                      //Write Enable
reg [11:0] R_Address ;          //Read address
reg [2:0] Row_Counter;          //Row Counter
reg R_En ;                      //Read Enable
reg [11:0] Address_0 ;          //RAM_0 address
reg [11:0] Address_1 ;          //RAM_1 address
reg Chip_Sele;                  //Chip select
reg R_En_0 ;                    //RAM_0 read enable
reg R_En_1 ;                    //RAM_1 read enable
reg W_En_0 ;                    //RAM_0 write enable
reg W_En_1 ;                    //RAM_1 write enable
reg Chip_Sele_DFF;              //Chip select DFF
wire [7:0] RAM_0_Out;           //RAM_0 output;    
wire [7:0] RAM_1_Out;           //RAM_1 output;

//Instantiating RAM_0 modules
RAM RAM_0(
.address ( Address_0 ),
.clock ( Clock ),
.data ( Cache_8_Pixel ),
.rden ( R_En_0 ),
.wren ( W_En_0 ),
.q ( RAM_0_Out )
);
//Instantiating RAM_1 modules
RAM RAM_1(
.address ( Address_1 ),
.clock ( Clock ),
.data ( Cache_8_Pixel ),
.rden ( R_En_1 ),
.wren ( W_En_1 ),
.q ( RAM_1_Out )
);

//Input Data Cache
always @( posedge Clock or negedge Reset_n )
begin
    if( !Reset_n )
        Cache_8_Pixel <= 8'b0;
    else 
        Cache_8_Pixel <= In_Data;
end

//RAM Write enable control
always @(posedge Clock or negedge Reset_n)
begin
    if(!Reset_n)
        W_En <= 1'b0;
    else if(En_In)  //  Input enables effective execution of write operations
        W_En <= 1'b1;
    else
        W_En <= 1'b0;
end

//RAM Write control
always @( posedge Clock or negedge Reset_n )
begin
    if(!Reset_n)
        W_Address <= 12'd2559;
    else if(En_In)
        begin
            if(W_Address == 12'd2559) //If the last data is written, start writing from scratch
                W_Address <= 12'd0;
            else
                W_Address <= W_Address + 12'b1; // Write in sequence 0~2559
        end
    else if(W_Address > 12'd2559)
        W_Address <= 12'd0;
    else
        W_Address <= W_Address;
end

//RAM read enable control
always @(posedge Clock or negedge Reset_n)
begin
    if(!Reset_n)
	    R_En <= 1'b0;
    else if( R_Address == 12'd2559 ) //If the last bit is read
        begin
	        if( (W_Address == 12'd2559) && W_En) // The operation can be read when one of the ROMs is finished
                R_En <= 1'b1;
	        else 
		        R_En <= 1'b0;
        end
    else 
	    R_En <= R_En ;
end

//Row Count
always @(posedge Clock or negedge Reset_n)
begin
    if(!Reset_n)
        Row_Counter <= 3'b0;
    else if( (R_Address[2:0] == 3'b111) && R_En ) // The lower 3 bits of the address from 0 to 7 represent reading one line
        begin
            if(Row_Counter == 3'b111)           // Count from scratch every 8 lines read
                Row_Counter <= 3'b0;
            else
                Row_Counter <= Row_Counter + 1'b1;
        end
    else
        Row_Counter <= Row_Counter;
end

//RAM read control
always @(posedge Clock or negedge Reset_n)
begin
    if(!Reset_n)
        R_Address <= 12'd2559;
    else if(R_Address == 12'd2559) //If the last bit is read
        begin
            if( (W_Address == 12'd2559) && W_En )//At the same time, there is already RAM written. The read address can be reset to 0
                R_Address <= 12'd0;
            else
                R_Address <= R_Address;
        end
    else if( (R_Address[2:0] == 3'b111 ) && R_En ) //If the read enable is valid and one line has been read, proceed to the next step for judgment. R_Address[2:0]From 0 to 7 represents reading 8
        begin
            if(Row_Counter == 3'b111) // Determine if you have read enough 8 lines
                R_Address <= R_Address - 12'd2239 ; // Switch to the next group after reading 8 lines
            else
                R_Address <= R_Address + 12'd313 ;  // Switch to the next column if you haven't read enough rows
        end
    else if(R_En)
        R_Address <= R_Address + 12'd1;
    else if(R_Address > 12'd2559)
        R_Address <= 12'd0;
    else
        R_Address <= R_Address;
end    

//Ping_pang Control
always @(posedge Clock or negedge Reset_n)
begin
    if(!Reset_n)
        Chip_Sele <= 1'b0;
    else if( (W_Address == 12'd2559) && W_En )//If the write enable is valid (continue writing) and the last bit is written, switch RAM
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
            Address_0 = R_Address;
            Address_1 = W_Address;
        end
    else
        begin
            W_En_0 = W_En;
            W_En_1 = 1'b0;
            R_En_0 = 1'b0;
            R_En_1 = R_En;
            Address_0 = W_Address;
            Address_1 = R_Address;
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
        Out_Data = RAM_0_Out;
    else
        Out_Data = RAM_1_Out;
end

endmodule 