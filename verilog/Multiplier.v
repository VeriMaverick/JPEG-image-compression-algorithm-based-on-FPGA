module Multiplier(
Data_Add,
Data_Sub,
Out_Data_Add_A,
Out_Data_Add_C,
Out_Data_Add_F,
Out_Data_Sub_B,
Out_Data_Sub_D,
Out_Data_Sub_E,
Out_Data_Sub_G
);

//Data bit width parameter
parameter WIDTH = 8;

parameter A = 362;	//0.35356 X 1024
parameter B = 502;	//0.49039 X 1024
parameter C = 473;	//0.46194 X 1024
parameter D = 426;	//0.41573 X 1024
parameter E = 284;	//0.27779 X 1024
parameter F = 196;	//0.19134 X 1024
parameter G = 100;	//0.09755 X 1024

input signed [WIDTH:0] Data_Add;
input signed [WIDTH:0] Data_Sub;

output signed [WIDTH-1:0] Out_Data_Add_A;
output signed [WIDTH-1:0] Out_Data_Add_C;
output signed [WIDTH-1:0] Out_Data_Add_F;
output signed [WIDTH-1:0] Out_Data_Sub_B;
output signed [WIDTH-1:0] Out_Data_Sub_D;
output signed [WIDTH-1:0] Out_Data_Sub_E;
output signed [WIDTH-1:0] Out_Data_Sub_G;

reg signed [WIDTH+9:0] Mult_Add_A;
reg signed [WIDTH+9:0] Mult_Add_C;
reg signed [WIDTH+9:0] Mult_Add_F;
reg signed [WIDTH+9:0] Mult_Sub_B;
reg signed [WIDTH+9:0] Mult_Sub_D;
reg signed [WIDTH+9:0] Mult_Sub_E;
reg signed [WIDTH+9:0] Mult_Sub_G;

reg signed [WIDTH-1:0] Out_Data_Add_A;
reg signed [WIDTH-1:0] Out_Data_Add_C;
reg signed [WIDTH-1:0] Out_Data_Add_F;
reg signed [WIDTH-1:0] Out_Data_Sub_B;
reg signed [WIDTH-1:0] Out_Data_Sub_D;
reg signed [WIDTH-1:0] Out_Data_Sub_E;
reg signed [WIDTH-1:0] Out_Data_Sub_G;

always@( * )
begin
	Mult_Add_A = Data_Add * A;
	Mult_Add_C = Data_Add * C;
	Mult_Add_F = Data_Add * F;
	Mult_Sub_B = Data_Sub * B;
	Mult_Sub_D = Data_Sub * D;
	Mult_Sub_E = Data_Sub * E;
	Mult_Sub_G = Data_Sub * G;
end

always@( * )
begin
	Out_Data_Add_A = Mult_Add_A[WIDTH+9:10];
	Out_Data_Add_C = Mult_Add_C[WIDTH+9:10];
	Out_Data_Add_F = Mult_Add_F[WIDTH+9:10];
	Out_Data_Sub_B = Mult_Sub_B[WIDTH+9:10];
	Out_Data_Sub_D = Mult_Sub_D[WIDTH+9:10];
	Out_Data_Sub_E = Mult_Sub_E[WIDTH+9:10];
	Out_Data_Sub_G = Mult_Sub_G[WIDTH+9:10];
end

endmodule 