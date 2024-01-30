module Send_8_Pixel(
Clock,
Reset_n,
Start,
In_Data_0,
In_Data_1,
In_Data_2,
In_Data_3,
In_Data_4,
In_Data_5,
In_Data_6,
In_Data_7,
Out_Data,
En_Out
);

//Data bit width parameter
parameter WIDTH = 8;

input Clock;
input Reset_n;
input Start;
input signed [WIDTH +1:0] In_Data_0;
input signed [WIDTH +1:0] In_Data_1;
input signed [WIDTH +1:0] In_Data_2;
input signed [WIDTH +1:0] In_Data_3;
input signed [WIDTH +1:0] In_Data_4;
input signed [WIDTH +1:0] In_Data_5;
input signed [WIDTH +1:0] In_Data_6;
input signed [WIDTH +1:0] In_Data_7;

output signed [WIDTH+1:0] Out_Data;
output En_Out;

reg signed [WIDTH+1:0] Out_Data;
reg En_Out;
reg [2:0]Counter;
reg signed [WIDTH+1:0]Out_Data_reg_0;
reg signed [WIDTH+1:0]Out_Data_reg_1;
reg signed [WIDTH+1:0]Out_Data_reg_2;
reg signed [WIDTH+1:0]Out_Data_reg_3;
reg signed [WIDTH+1:0]Out_Data_reg_4;
reg signed [WIDTH+1:0]Out_Data_reg_5;
reg signed [WIDTH+1:0]Out_Data_reg_6;
reg signed [WIDTH+1:0]Out_Data_reg_7;

//Output enable control
always @(posedge Clock or negedge Reset_n)
begin
	if(!Reset_n)
		En_Out <= 1'b0;
	else if(Start)
		En_Out <= 1'b1;
	else if( (Counter == 3'b111) && (!Start) )
        En_Out <= 1'b0;
		else if(Counter == 3'b111)
			En_Out <= 1'b0;
    else
        En_Out <= En_Out;
end

//Data Counter
always @(posedge Clock or negedge Reset_n)
begin
    if(!Reset_n)
        Counter <= 3'b0;
    else if( En_Out )
        Counter <= Counter + 1'b1;
    else if(Counter == 3'b111)
        Counter <= 3'b0;
    else
        Counter <= Counter;
end

//Output Data Cache
always @(posedge Clock or negedge Reset_n)	
begin
	if(!Reset_n)
		begin
			Out_Data_reg_0 <= 10'b0;
			Out_Data_reg_1 <= 10'b0;
			Out_Data_reg_2 <= 10'b0;
			Out_Data_reg_3 <= 10'b0;
			Out_Data_reg_4 <= 10'b0;
			Out_Data_reg_5 <= 10'b0;
			Out_Data_reg_6 <= 10'b0;
			Out_Data_reg_7 <= 10'b0;
		end
	else if(Start)
		begin
			Out_Data_reg_0 <= In_Data_0;
			Out_Data_reg_1 <= In_Data_1;
			Out_Data_reg_2 <= In_Data_2;
			Out_Data_reg_3 <= In_Data_3;
			Out_Data_reg_4 <= In_Data_4;
			Out_Data_reg_5 <= In_Data_5;
			Out_Data_reg_6 <= In_Data_6;
			Out_Data_reg_7 <= In_Data_7;
		end
	else
		begin
			Out_Data_reg_0 <= Out_Data_reg_0;
			Out_Data_reg_1 <= Out_Data_reg_1;
			Out_Data_reg_2 <= Out_Data_reg_2;
			Out_Data_reg_3 <= Out_Data_reg_3;
			Out_Data_reg_4 <= Out_Data_reg_4;
			Out_Data_reg_5 <= Out_Data_reg_5;
			Out_Data_reg_6 <= Out_Data_reg_6;
			Out_Data_reg_7 <= Out_Data_reg_7;
		end
end

//Send data in order
//Parallel input to serial output
always @( * )
begin
	if(En_Out)
		begin
			case (Counter)
				3'b000: begin Out_Data = Out_Data_reg_0 ; end 
				3'b001: begin Out_Data = Out_Data_reg_1 ; end
				3'b010: begin Out_Data = Out_Data_reg_2 ; end
				3'b011: begin Out_Data = Out_Data_reg_3 ; end
				3'b100: begin Out_Data = Out_Data_reg_4 ; end
				3'b101: begin Out_Data = Out_Data_reg_5 ; end
				3'b110: begin Out_Data = Out_Data_reg_6 ; end
				3'b111: begin Out_Data = Out_Data_reg_7 ; end
				default: Out_Data =  10'b0;
			endcase
		end
	else
		Out_Data =  10'b0;
end

endmodule 