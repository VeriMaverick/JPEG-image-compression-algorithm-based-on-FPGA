module DCT_1D_D_Flip_Flop_1(
Clock,
Reset_n,
In_Data_0,
In_Data_1,
In_Data_2,
In_Data_3,
In_Data_4,
In_Data_5,
In_Data_6,
In_Data_7,
Data_0_Add_7,
Data_0_Sub_7,
Data_1_Add_6,
Data_1_Sub_6,
Data_2_Add_5,
Data_2_Sub_5,
Data_3_Add_4,
Data_3_Sub_4
);

parameter WIDTH = 8;

input Clock;
input Reset_n;
input signed [WIDTH:0] In_Data_0;
input signed [WIDTH:0] In_Data_1;
input signed [WIDTH:0] In_Data_2;
input signed [WIDTH:0] In_Data_3;
input signed [WIDTH:0] In_Data_4;
input signed [WIDTH:0] In_Data_5;
input signed [WIDTH:0] In_Data_6;
input signed [WIDTH:0] In_Data_7;

output signed [WIDTH:0] Data_0_Add_7;
output signed [WIDTH:0] Data_0_Sub_7;
output signed [WIDTH:0] Data_1_Add_6;
output signed [WIDTH:0] Data_1_Sub_6;
output signed [WIDTH:0] Data_2_Add_5;
output signed [WIDTH:0] Data_2_Sub_5;
output signed [WIDTH:0] Data_3_Add_4;
output signed [WIDTH:0] Data_3_Sub_4;

reg signed [WIDTH:0] Data_0_Add_7;
reg signed [WIDTH:0] Data_0_Sub_7;
reg signed [WIDTH:0] Data_1_Add_6;
reg signed [WIDTH:0] Data_1_Sub_6;
reg signed [WIDTH:0] Data_2_Add_5;
reg signed [WIDTH:0] Data_2_Sub_5;
reg signed [WIDTH:0] Data_3_Add_4;
reg signed [WIDTH:0] Data_3_Sub_4;

always @(posedge Clock or negedge Reset_n)
begin
    if(!Reset_n)
        begin
            Data_0_Add_7 <= 9'b0;
            Data_0_Sub_7 <= 9'b0;
            Data_1_Add_6 <= 9'b0;
            Data_1_Sub_6 <= 9'b0;
            Data_2_Add_5 <= 9'b0;
            Data_2_Sub_5 <= 9'b0;
            Data_3_Add_4 <= 9'b0;
            Data_3_Sub_4 <= 9'b0;
        end
    else
        begin
            Data_0_Add_7 <= In_Data_0;
            Data_0_Sub_7 <= In_Data_1;
            Data_1_Add_6 <= In_Data_2;
            Data_1_Sub_6 <= In_Data_3;
            Data_2_Add_5 <= In_Data_4;
            Data_2_Sub_5 <= In_Data_5;
            Data_3_Add_4 <= In_Data_6;
            Data_3_Sub_4 <= In_Data_7;
        end
end
endmodule 