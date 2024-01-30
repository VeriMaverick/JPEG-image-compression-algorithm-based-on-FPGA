module Adder_1(
In_Pixel_0,
In_Pixel_1,
In_Pixel_2,
In_Pixel_3,
In_Pixel_4,
In_Pixel_5,
In_Pixel_6,
In_Pixel_7,
Data_0_Add_7,
Data_0_Sub_7,
Data_1_Add_6,
Data_1_Sub_6,
Data_2_Add_5,
Data_2_Sub_5,
Data_3_Add_4,
Data_3_Sub_4
);

//Data bit width parameter
parameter WIDTH = 8;

input signed [WIDTH-1:0] In_Pixel_0;//Input pixel value 0
input signed [WIDTH-1:0] In_Pixel_1;//Input pixel value 1
input signed [WIDTH-1:0] In_Pixel_2;//Input pixel value 2
input signed [WIDTH-1:0] In_Pixel_3;//Input pixel value 3
input signed [WIDTH-1:0] In_Pixel_4;//Input pixel value 4
input signed [WIDTH-1:0] In_Pixel_5;//Input pixel value 5
input signed [WIDTH-1:0] In_Pixel_6;//Input pixel value 6
input signed [WIDTH-1:0] In_Pixel_7;//Input pixel value 7

output signed [WIDTH:0] Data_0_Add_7;//Output value Pixel 0+7
output signed [WIDTH:0] Data_0_Sub_7;//Output value Pixel 0-7
output signed [WIDTH:0] Data_1_Add_6;//Output value Pixel 1+6
output signed [WIDTH:0] Data_1_Sub_6;//Output value Pixel 1-6    
output signed [WIDTH:0] Data_2_Add_5;//Output value Pixel 2+5
output signed [WIDTH:0] Data_2_Sub_5;//Output value Pixel 2-5
output signed [WIDTH:0] Data_3_Add_4;//Output value Pixel 3+4
output signed [WIDTH:0] Data_3_Sub_4;//Output value Pixel 3-4

//Add = Adder "+"//Sub = Subtractor "-"
assign Data_0_Add_7 = In_Pixel_0 + In_Pixel_7;
assign Data_0_Sub_7 = In_Pixel_0 - In_Pixel_7;
assign Data_1_Add_6 = In_Pixel_1 + In_Pixel_6;
assign Data_1_Sub_6 = In_Pixel_1 - In_Pixel_6;
assign Data_2_Add_5 = In_Pixel_2 + In_Pixel_5;
assign Data_2_Sub_5 = In_Pixel_2 - In_Pixel_5;
assign Data_3_Add_4 = In_Pixel_3 + In_Pixel_4;
assign Data_3_Sub_4 = In_Pixel_3 - In_Pixel_4;

endmodule 