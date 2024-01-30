module Receive_8_Pixel(
Clock,
Reset_n,
Data_In,
En_In,
Out_Pixel_0,
Out_Pixel_1,
Out_Pixel_2,
Out_Pixel_3,
Out_Pixel_4,
Out_Pixel_5,
Out_Pixel_6,
Out_Pixel_7,
En_Out
);

parameter WIDTH = 8; //One pixel of data has an 8-bit width

input Clock;
input Reset_n;
input signed [WIDTH-1:0] Data_In;
input En_In;

output signed [WIDTH-1:0] Out_Pixel_0;
output signed [WIDTH-1:0] Out_Pixel_1;
output signed [WIDTH-1:0] Out_Pixel_2;
output signed [WIDTH-1:0] Out_Pixel_3;
output signed [WIDTH-1:0] Out_Pixel_4;
output signed [WIDTH-1:0] Out_Pixel_5;
output signed [WIDTH-1:0] Out_Pixel_6;
output signed [WIDTH-1:0] Out_Pixel_7;
output En_Out;

reg signed [WIDTH-1:0] Out_Pixel_0;
reg signed [WIDTH-1:0] Out_Pixel_1;
reg signed [WIDTH-1:0] Out_Pixel_2;
reg signed [WIDTH-1:0] Out_Pixel_3;
reg signed [WIDTH-1:0] Out_Pixel_4;
reg signed [WIDTH-1:0] Out_Pixel_5;
reg signed [WIDTH-1:0] Out_Pixel_6;
reg signed [WIDTH-1:0] Out_Pixel_7;
reg En_Out;

reg signed [WIDTH-1:0] Reg_Pixel_0;
reg signed [WIDTH-1:0] Reg_Pixel_1;
reg signed [WIDTH-1:0] Reg_Pixel_2;
reg signed [WIDTH-1:0] Reg_Pixel_3;
reg signed [WIDTH-1:0] Reg_Pixel_4;
reg signed [WIDTH-1:0] Reg_Pixel_5;
reg signed [WIDTH-1:0] Reg_Pixel_6;
reg signed [WIDTH-1:0] Reg_Pixel_7;

reg [2:0] Counter;  //Counter for 8 pixels
//Counter for 8 pixels
always @(posedge Clock or negedge Reset_n)
begin
    if(!Reset_n)
        Counter <= 3'b0;
    else if(Counter == 3'b111)
        Counter <= 3'b0;
    else if(En_In)
        Counter <= Counter + 3'b1;
    else
        Counter <= Counter;
end

//Combinational logic
//Serial input to parallel output
always @( * )
begin
    case (Counter)
        3'b000:begin Reg_Pixel_0 = Data_In; end 
        3'b001:begin Reg_Pixel_1 = Data_In; end
        3'b010:begin Reg_Pixel_2 = Data_In; end
        3'b011:begin Reg_Pixel_3 = Data_In; end
        3'b100:begin Reg_Pixel_4 = Data_In; end
        3'b101:begin Reg_Pixel_5 = Data_In; end
        3'b110:begin Reg_Pixel_6 = Data_In; end
        3'b111:begin Reg_Pixel_7 = Data_In; end
        default:begin 
                    Reg_Pixel_0 = 8'b0; 
                    Reg_Pixel_1 = 8'b0;
                    Reg_Pixel_2 = 8'b0;
                    Reg_Pixel_3 = 8'b0;
                    Reg_Pixel_4 = 8'b0;
                    Reg_Pixel_5 = 8'b0;
                    Reg_Pixel_6 = 8'b0;
                    Reg_Pixel_7 = 8'b0;
                end
        endcase
end

always @(posedge Clock or negedge Reset_n)
begin
    if(!Reset_n)
        En_Out <= 1'b0;
    else if(Counter == 3'b111)
        En_Out <= 1'b1;
    else
        En_Out <= 1'b0;
end

always @(posedge Clock or negedge Reset_n)
begin
    if(!Reset_n)
        begin
            Out_Pixel_0 <= 8'b0;
            Out_Pixel_1 <= 8'b0;
            Out_Pixel_2 <= 8'b0;
            Out_Pixel_3 <= 8'b0;
            Out_Pixel_4 <= 8'b0;
            Out_Pixel_5 <= 8'b0;
            Out_Pixel_6 <= 8'b0;
            Out_Pixel_7 <= 8'b0;
        end
    else if(Counter == 3'b111)
        begin
            Out_Pixel_0 <= Reg_Pixel_0;
            Out_Pixel_1 <= Reg_Pixel_1;
            Out_Pixel_2 <= Reg_Pixel_2;
            Out_Pixel_3 <= Reg_Pixel_3;
            Out_Pixel_4 <= Reg_Pixel_4;
            Out_Pixel_5 <= Reg_Pixel_5;
            Out_Pixel_6 <= Reg_Pixel_6;
            Out_Pixel_7 <= Reg_Pixel_7;
        end
    else
        begin
            Out_Pixel_0 <= Out_Pixel_0;
            Out_Pixel_1 <= Out_Pixel_1;
            Out_Pixel_2 <= Out_Pixel_2;
            Out_Pixel_3 <= Out_Pixel_3;
            Out_Pixel_4 <= Out_Pixel_4;
            Out_Pixel_5 <= Out_Pixel_5;
            Out_Pixel_6 <= Out_Pixel_6;
            Out_Pixel_7 <= Out_Pixel_7;
        end
end

endmodule 