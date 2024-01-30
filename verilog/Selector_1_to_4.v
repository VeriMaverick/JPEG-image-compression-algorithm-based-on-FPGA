module Selector_1_to_4(
Data_Add_A,
Data_Add_C,
Data_Add_F,
Data_Sub_B,
Data_Sub_D,
Data_Sub_E,
Data_Sub_G,

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

Sele
);

parameter WIDTH = 8;

input [1:0] Sele;
input signed [WIDTH-1:0] Data_Add_A;
input signed [WIDTH-1:0] Data_Add_C;
input signed [WIDTH-1:0] Data_Add_F;
input signed [WIDTH-1:0] Data_Sub_B;
input signed [WIDTH-1:0] Data_Sub_D;
input signed [WIDTH-1:0] Data_Sub_E;
input signed [WIDTH-1:0] Data_Sub_G;

output signed [WIDTH-1:0] Data_0_Add_7_A;
output signed [WIDTH-1:0] Data_0_Add_7_C;
output signed [WIDTH-1:0] Data_0_Add_7_F;
output signed [WIDTH-1:0] Data_0_Sub_7_B;
output signed [WIDTH-1:0] Data_0_Sub_7_D;
output signed [WIDTH-1:0] Data_0_Sub_7_E;
output signed [WIDTH-1:0] Data_0_Sub_7_G;

output signed [WIDTH-1:0] Data_1_Add_6_A;
output signed [WIDTH-1:0] Data_1_Add_6_C;
output signed [WIDTH-1:0] Data_1_Add_6_F;
output signed [WIDTH-1:0] Data_1_Sub_6_B;
output signed [WIDTH-1:0] Data_1_Sub_6_D;
output signed [WIDTH-1:0] Data_1_Sub_6_E;
output signed [WIDTH-1:0] Data_1_Sub_6_G;

output signed [WIDTH-1:0] Data_2_Add_5_A;
output signed [WIDTH-1:0] Data_2_Add_5_C;
output signed [WIDTH-1:0] Data_2_Add_5_F;
output signed [WIDTH-1:0] Data_2_Sub_5_B;
output signed [WIDTH-1:0] Data_2_Sub_5_D;
output signed [WIDTH-1:0] Data_2_Sub_5_E;
output signed [WIDTH-1:0] Data_2_Sub_5_G;

output signed [WIDTH-1:0] Data_3_Add_4_A;
output signed [WIDTH-1:0] Data_3_Add_4_C;
output signed [WIDTH-1:0] Data_3_Add_4_F;
output signed [WIDTH-1:0] Data_3_Sub_4_B;
output signed [WIDTH-1:0] Data_3_Sub_4_D;
output signed [WIDTH-1:0] Data_3_Sub_4_E;
output signed [WIDTH-1:0] Data_3_Sub_4_G;

reg signed [WIDTH-1:0] Data_0_Add_7_A;
reg signed [WIDTH-1:0] Data_0_Add_7_C;
reg signed [WIDTH-1:0] Data_0_Add_7_F;
reg signed [WIDTH-1:0] Data_0_Sub_7_B;
reg signed [WIDTH-1:0] Data_0_Sub_7_D;
reg signed [WIDTH-1:0] Data_0_Sub_7_E;
reg signed [WIDTH-1:0] Data_0_Sub_7_G;

reg signed [WIDTH-1:0] Data_1_Add_6_A;
reg signed [WIDTH-1:0] Data_1_Add_6_C;
reg signed [WIDTH-1:0] Data_1_Add_6_F;
reg signed [WIDTH-1:0] Data_1_Sub_6_B;
reg signed [WIDTH-1:0] Data_1_Sub_6_D;
reg signed [WIDTH-1:0] Data_1_Sub_6_E;
reg signed [WIDTH-1:0] Data_1_Sub_6_G;

reg signed [WIDTH-1:0] Data_2_Add_5_A;
reg signed [WIDTH-1:0] Data_2_Add_5_C;
reg signed [WIDTH-1:0] Data_2_Add_5_F;
reg signed [WIDTH-1:0] Data_2_Sub_5_B;
reg signed [WIDTH-1:0] Data_2_Sub_5_D;
reg signed [WIDTH-1:0] Data_2_Sub_5_E;
reg signed [WIDTH-1:0] Data_2_Sub_5_G;

reg signed [WIDTH-1:0] Data_3_Add_4_A;
reg signed [WIDTH-1:0] Data_3_Add_4_C;
reg signed [WIDTH-1:0] Data_3_Add_4_F;
reg signed [WIDTH-1:0] Data_3_Sub_4_B;
reg signed [WIDTH-1:0] Data_3_Sub_4_D;
reg signed [WIDTH-1:0] Data_3_Sub_4_E;
reg signed [WIDTH-1:0] Data_3_Sub_4_G;

always@( * )
begin
    case(Sele)
        2'b00:
        begin
            Data_0_Add_7_A = Data_Add_A;
            Data_0_Add_7_C = Data_Add_C;
            Data_0_Add_7_F = Data_Add_F;
            Data_0_Sub_7_B = Data_Sub_B;
            Data_0_Sub_7_D = Data_Sub_D;
            Data_0_Sub_7_E = Data_Sub_E;
            Data_0_Sub_7_G = Data_Sub_G;
        end
        2'b01:
        begin
            Data_1_Add_6_A = Data_Add_A;
            Data_1_Add_6_C = Data_Add_C;
            Data_1_Add_6_F = Data_Add_F;
            Data_1_Sub_6_B = Data_Sub_B;
            Data_1_Sub_6_D = Data_Sub_D;
            Data_1_Sub_6_E = Data_Sub_E;
            Data_1_Sub_6_G = Data_Sub_G;
        end
        2'b10:
        begin
            Data_2_Add_5_A = Data_Add_A;
            Data_2_Add_5_C = Data_Add_C;
            Data_2_Add_5_F = Data_Add_F;
            Data_2_Sub_5_B = Data_Sub_B;
            Data_2_Sub_5_D = Data_Sub_D;
            Data_2_Sub_5_E = Data_Sub_E;
            Data_2_Sub_5_G = Data_Sub_G;
        end
        2'b11:
        begin
            Data_3_Add_4_A = Data_Add_A;
            Data_3_Add_4_C = Data_Add_C;
            Data_3_Add_4_F = Data_Add_F;
            Data_3_Sub_4_B = Data_Sub_B;
            Data_3_Sub_4_D = Data_Sub_D;
            Data_3_Sub_4_E = Data_Sub_E;
            Data_3_Sub_4_G = Data_Sub_G;
        end
        default:
            begin
            Data_0_Add_7_A = 8'b0;
            Data_0_Add_7_C = 8'b0;
            Data_0_Add_7_F = 8'b0;
            Data_0_Sub_7_B = 8'b0;
            Data_0_Sub_7_D = 8'b0;
            Data_0_Sub_7_E = 8'b0;
            Data_0_Sub_7_G = 8'b0;

            Data_1_Add_6_A = 8'b0;
            Data_1_Add_6_C = 8'b0;
            Data_1_Add_6_F = 8'b0;
            Data_1_Sub_6_B = 8'b0;
            Data_1_Sub_6_D = 8'b0;
            Data_1_Sub_6_E = 8'b0;
            Data_1_Sub_6_G = 8'b0;

            Data_2_Add_5_A = 8'b0;
            Data_2_Add_5_C = 8'b0;
            Data_2_Add_5_F = 8'b0;
            Data_2_Sub_5_B = 8'b0;
            Data_2_Sub_5_D = 8'b0;
            Data_2_Sub_5_E = 8'b0;
            Data_2_Sub_5_G = 8'b0;

            Data_3_Add_4_A = 8'b0;
            Data_3_Add_4_C = 8'b0;
            Data_3_Add_4_F = 8'b0;
            Data_3_Sub_4_B = 8'b0;
            Data_3_Sub_4_D = 8'b0;
            Data_3_Sub_4_E = 8'b0;
            Data_3_Sub_4_G = 8'b0;
            end
    endcase
end

endmodule 