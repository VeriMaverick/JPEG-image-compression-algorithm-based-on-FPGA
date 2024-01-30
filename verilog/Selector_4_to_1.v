module Selector_4_to_1(
Data_0_Add_7,
Data_0_Sub_7,
Data_1_Add_6,
Data_1_Sub_6,
Data_2_Add_5,
Data_2_Sub_5,
Data_3_Add_4,
Data_3_Sub_4,
Sele,
Out_Add_Data,
Out_Sub_Data
);

parameter WIDTH = 8;

input signed [WIDTH:0] Data_0_Add_7;
input signed [WIDTH:0] Data_0_Sub_7;
input signed [WIDTH:0] Data_1_Add_6;
input signed [WIDTH:0] Data_1_Sub_6;
input signed [WIDTH:0] Data_2_Add_5;
input signed [WIDTH:0] Data_2_Sub_5;
input signed [WIDTH:0] Data_3_Add_4;
input signed [WIDTH:0] Data_3_Sub_4;
input [1:0] Sele;

output signed [WIDTH:0] Out_Add_Data;
output signed [WIDTH:0] Out_Sub_Data;

reg signed [WIDTH:0] Out_Add_Data;
reg signed [WIDTH:0] Out_Sub_Data;

always @( * ) 
begin
    case (Sele) 
        2'b00: 
            begin
                Out_Add_Data = Data_0_Add_7;
                Out_Sub_Data = Data_0_Sub_7;
            end
        2'b01:
            begin
                Out_Add_Data = Data_1_Add_6;
                Out_Sub_Data = Data_1_Sub_6;
            end
        2'b10: 
            begin
                Out_Add_Data = Data_2_Add_5;
                Out_Sub_Data = Data_2_Sub_5;
            end
        2'b11: 
            begin
                Out_Add_Data = Data_3_Add_4;
                Out_Sub_Data = Data_3_Sub_4;
            end
        default: 
            begin
                Out_Add_Data = 9'b0;
                Out_Sub_Data = 9'b0;
            end
    endcase
end


endmodule 