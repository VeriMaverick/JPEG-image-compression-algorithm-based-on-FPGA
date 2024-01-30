module RGB_to_Y( 
Clock,
Reset_n,
In_Data,
En_In,
En_Out,
Out_Y
);

input Clock;
input Reset_n;
input En_In;
input [15:0] In_Data;

output En_Out;
output signed [7:0] Out_Y;

wire [4:0] R = In_Data[15:11];
wire [5:0] G = In_Data[10:5];
wire [4:0] B = In_Data[4:0];

reg En_Out;
reg En;
reg [16:0] R_Reg;
reg [17:0] G_Reg;
reg [14:0] B_Reg;
reg [17:0] Sum;

always @(posedge Clock or negedge Reset_n)
begin
    if (!Reset_n)
        begin
            R_Reg <= 17'b0;
            G_Reg <= 18'b0;
            B_Reg <= 15'b0;
            En <= 1'b0;
        end  
    else if(En_In)
        begin
            R_Reg <= (R<<11) + (R<<8) + (R<<7) + (R<<6)+ (R<<4) + (R<<2)+ (R<<1) + R;  // 2.460 X 1024 = 2519  12'd2519  = 12'b1001 1101 0111
            G_Reg <= (G<<11) + (G<<8) + (G<<7) + G;                                    // 2.376 X 1024 = 2433  12'd2433  = 12'b1001 1000 0001
            B_Reg <= (B<<9) + (B<<8) + (B<<7) + (B<<6);                                // 0.938 X 1024 = 960   10'd960   = 10'b11 1100 0000
            En <= 1'b1;
        end  
    else
        begin
            R_Reg <= R_Reg;
            G_Reg <= G_Reg;
            B_Reg <= B_Reg;
            En <= 1'b0;
        end
end

always @(posedge Clock or negedge Reset_n)
begin
    if (!Reset_n)
        begin
            Sum <= 18'b0;
            En_Out <= 1'b0;
        end
    else if(En)
        begin
            Sum <= R_Reg + G_Reg + B_Reg;
			   En_Out <= 1'b1;
        end
    else if(!En)
            En_Out <= 1'b0;
    else
            En_Out <= En_Out;
end

assign Out_Y = (En_Out) ? ( {~Sum[17] , Sum[16:10]} ) : 8'b0;

endmodule 