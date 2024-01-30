module Adder_2(
Data_0_Add_7_A,
Data_0_Add_7_C,
Data_0_Add_7_F,
Data_0_Sub_7_B,
Data_0_Sub_7_D,
Data_0_Sub_7_E,
Data_0_Sub_7_G,
Data_1_Add_6_A,
Data_1_Add_6_C,
Data_1_Add_6_F,
Data_1_Sub_6_B,
Data_1_Sub_6_D,
Data_1_Sub_6_E,
Data_1_Sub_6_G,
Data_2_Add_5_A,
Data_2_Add_5_C,
Data_2_Add_5_F,
Data_2_Sub_5_B,
Data_2_Sub_5_D,
Data_2_Sub_5_E,
Data_2_Sub_5_G,
Data_3_Add_4_A,
Data_3_Add_4_C,
Data_3_Add_4_F,
Data_3_Sub_4_B,
Data_3_Sub_4_D,
Data_3_Sub_4_E,
Data_3_Sub_4_G,
Out_Data_0,
Out_Data_1,
Out_Data_2,
Out_Data_3,
Out_Data_4,
Out_Data_5,
Out_Data_6,
Out_Data_7
);

//Data bit width parameter
parameter WIDTH = 8;

//Pixel 0 and 7 operations
input signed [WIDTH-1:0] Data_0_Add_7_A;//Pixel 0+7 multiplied  parameter A
input signed [WIDTH-1:0] Data_0_Add_7_C;//Pixel 0+7 multiplied  parameter C
input signed [WIDTH-1:0] Data_0_Add_7_F;//Pixel 0+7 multiplied  parameter F
input signed [WIDTH-1:0] Data_0_Sub_7_B;//Pixel 0-7 multiplied  parameter B
input signed [WIDTH-1:0] Data_0_Sub_7_D;//Pixel 0-7 multiplied  parameter D
input signed [WIDTH-1:0] Data_0_Sub_7_E;//Pixel 0-7 multiplied  parameter E
input signed [WIDTH-1:0] Data_0_Sub_7_G;//Pixel 0-7 multiplied  parameter G

//Pixel 1 and 6 operations
input signed [WIDTH-1:0] Data_1_Add_6_A;//Pixel 1+6 multiplied  parameter A
input signed [WIDTH-1:0] Data_1_Add_6_C;//Pixel 1+6 multiplied  parameter C
input signed [WIDTH-1:0] Data_1_Add_6_F;//Pixel 1+6 multiplied  parameter F
input signed [WIDTH-1:0] Data_1_Sub_6_B;//Pixel 1-6 multiplied  parameter B
input signed [WIDTH-1:0] Data_1_Sub_6_D;//Pixel 1-6 multiplied  parameter D
input signed [WIDTH-1:0] Data_1_Sub_6_E;//Pixel 1-6 multiplied  parameter E
input signed [WIDTH-1:0] Data_1_Sub_6_G;//Pixel 1-6 multiplied  parameter G

//Pixel 2 and 5 operations
input signed [WIDTH-1:0] Data_2_Add_5_A;//Pixel 2+5 multiplied  parameter A
input signed [WIDTH-1:0] Data_2_Add_5_C;//Pixel 2+5 multiplied  parameter C
input signed [WIDTH-1:0] Data_2_Add_5_F;//Pixel 2+5 multiplied  parameter F
input signed [WIDTH-1:0] Data_2_Sub_5_B;//Pixel 2-5 multiplied  parameter B
input signed [WIDTH-1:0] Data_2_Sub_5_D;//Pixel 2-5 multiplied  parameter D
input signed [WIDTH-1:0] Data_2_Sub_5_E;//Pixel 2-5 multiplied  parameter E
input signed [WIDTH-1:0] Data_2_Sub_5_G;//Pixel 2-5 multiplied  parameter G

//Pixel 3 and 4 operations
input signed [WIDTH-1:0] Data_3_Add_4_A;//Pixel 3+4 multiplied  parameter A
input signed [WIDTH-1:0] Data_3_Add_4_C;//Pixel 3+4 multiplied  parameter C
input signed [WIDTH-1:0] Data_3_Add_4_F;//Pixel 3+4 multiplied  parameter F
input signed [WIDTH-1:0] Data_3_Sub_4_B;//Pixel 3-4 multiplied  parameter B
input signed [WIDTH-1:0] Data_3_Sub_4_D;//Pixel 3-4 multiplied  parameter D
input signed [WIDTH-1:0] Data_3_Sub_4_E;//Pixel 3-4 multiplied  parameter E
input signed [WIDTH-1:0] Data_3_Sub_4_G;//Pixel 3-4 multiplied  parameter G

//Operation data output
output signed [WIDTH+1:0] Out_Data_0;
output signed [WIDTH+1:0] Out_Data_1;
output signed [WIDTH+1:0] Out_Data_2;
output signed [WIDTH+1:0] Out_Data_3;
output signed [WIDTH+1:0] Out_Data_4;
output signed [WIDTH+1:0] Out_Data_5;
output signed [WIDTH+1:0] Out_Data_6;
output signed [WIDTH+1:0] Out_Data_7;

//A 0.35356 //B 0.49039 //C 0.46194 //D 0.41573 //E 0.2779 //F 0.19134 //G 0.09755 
assign Out_Data_0 = Data_0_Add_7_A + Data_1_Add_6_A + Data_2_Add_5_A + Data_3_Add_4_A ;
assign Out_Data_1 = Data_0_Sub_7_B + Data_1_Sub_6_D + Data_2_Sub_5_E + Data_3_Sub_4_G ;
assign Out_Data_2 = Data_0_Add_7_C + Data_1_Add_6_F - Data_2_Add_5_F - Data_3_Add_4_C ; 
assign Out_Data_3 = Data_0_Sub_7_D - Data_1_Sub_6_G - Data_2_Sub_5_B - Data_3_Sub_4_E ;
assign Out_Data_4 = Data_0_Add_7_A - Data_1_Add_6_A - Data_2_Add_5_A + Data_3_Add_4_A ;
assign Out_Data_5 = Data_0_Sub_7_E - Data_1_Sub_6_B + Data_2_Sub_5_G + Data_3_Sub_4_D ;
assign Out_Data_6 = Data_0_Add_7_F - Data_1_Add_6_C + Data_2_Add_5_C - Data_3_Add_4_F ;
assign Out_Data_7 = Data_0_Sub_7_G - Data_1_Sub_6_E + Data_2_Sub_5_D - Data_3_Sub_4_B ;

endmodule 