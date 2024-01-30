module DCT_1D_D_Flip_Flop_2(
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
Out_Data_0,
Out_Data_1,
Out_Data_2,
Out_Data_3,
Out_Data_4,
Out_Data_5,
Out_Data_6,
Out_Data_7
);

parameter WIDTH = 8;

input Clock;
input Reset_n;
input signed [WIDTH+1:0] In_Data_0;
input signed [WIDTH+1:0] In_Data_1;
input signed [WIDTH+1:0] In_Data_2;
input signed [WIDTH+1:0] In_Data_3;
input signed [WIDTH+1:0] In_Data_4;
input signed [WIDTH+1:0] In_Data_5;
input signed [WIDTH+1:0] In_Data_6;
input signed [WIDTH+1:0] In_Data_7;

output  signed [WIDTH+1:0] Out_Data_0;
output  signed [WIDTH+1:0] Out_Data_1;
output  signed [WIDTH+1:0] Out_Data_2;
output  signed [WIDTH+1:0] Out_Data_3;
output  signed [WIDTH+1:0] Out_Data_4;
output  signed [WIDTH+1:0] Out_Data_5;
output  signed [WIDTH+1:0] Out_Data_6;
output  signed [WIDTH+1:0] Out_Data_7;

reg signed [WIDTH+1:0] Out_Data_0;
reg signed [WIDTH+1:0] Out_Data_1;
reg signed [WIDTH+1:0] Out_Data_2;
reg signed [WIDTH+1:0] Out_Data_3;
reg signed [WIDTH+1:0] Out_Data_4;
reg signed [WIDTH+1:0] Out_Data_5;
reg signed [WIDTH+1:0] Out_Data_6;
reg signed [WIDTH+1:0] Out_Data_7;

always @(posedge Clock or negedge Reset_n)
begin
    if(!Reset_n)
        begin
            Out_Data_0 <= 10'b0;
            Out_Data_1 <= 10'b0;
            Out_Data_2 <= 10'b0;
            Out_Data_3 <= 10'b0;
            Out_Data_4 <= 10'b0;
            Out_Data_5 <= 10'b0;
            Out_Data_6 <= 10'b0;
            Out_Data_7 <= 10'b0;
        end
    else
        begin
            Out_Data_0 <= In_Data_0;
            Out_Data_1 <= In_Data_1;
            Out_Data_2 <= In_Data_2;
            Out_Data_3 <= In_Data_3;
            Out_Data_4 <= In_Data_4;
            Out_Data_5 <= In_Data_5;
            Out_Data_6 <= In_Data_6;
            Out_Data_7 <= In_Data_7;
        end
end
endmodule 