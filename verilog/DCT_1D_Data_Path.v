module DCT_1D_Data_Path(
Clock,
Reset_n,
Sele,
In_Data,
En_In,
End_Calc,
Start_Calc,
Out_Data,
En_Out
);

parameter WIDTH = 8;

input Clock;
input Reset_n;
input [1:0] Sele;
input signed [WIDTH-1:0] In_Data;
input En_In;
input End_Calc;

output Start_Calc;
output signed [WIDTH+1:0] Out_Data;
output En_Out;

wire [1:0] Sele;
// Receive_8_Pixel U0 to Adder_1 U1
wire signed [WIDTH-1:0] Receive_8_Pixel_to_Adder_1_In_Pixel_0;
wire signed [WIDTH-1:0] Receive_8_Pixel_to_Adder_1_In_Pixel_1;
wire signed [WIDTH-1:0] Receive_8_Pixel_to_Adder_1_In_Pixel_2;
wire signed [WIDTH-1:0] Receive_8_Pixel_to_Adder_1_In_Pixel_3;
wire signed [WIDTH-1:0] Receive_8_Pixel_to_Adder_1_In_Pixel_4;
wire signed [WIDTH-1:0] Receive_8_Pixel_to_Adder_1_In_Pixel_5;
wire signed [WIDTH-1:0] Receive_8_Pixel_to_Adder_1_In_Pixel_6;
wire signed [WIDTH-1:0] Receive_8_Pixel_to_Adder_1_In_Pixel_7;

// Adder_1 U1 to D_Flip_Flop_1 U2
wire signed [WIDTH:0] Data_0_Add_7_to_D_Flip_Flop_1_0;
wire signed [WIDTH:0] Data_0_Sub_7_to_D_Flip_Flop_1_1;
wire signed [WIDTH:0] Data_1_Add_6_to_D_Flip_Flop_1_2;
wire signed [WIDTH:0] Data_1_Sub_6_to_D_Flip_Flop_1_3;
wire signed [WIDTH:0] Data_2_Add_5_to_D_Flip_Flop_1_4;
wire signed [WIDTH:0] Data_2_Sub_5_to_D_Flip_Flop_1_5;
wire signed [WIDTH:0] Data_3_Add_4_to_D_Flip_Flop_1_6;
wire signed [WIDTH:0] Data_3_Sub_4_to_D_Flip_Flop_1_7;

//D_Flip_Flop_1 U2 to Selector_4_to_1 U3
wire signed [WIDTH:0] D_Flip_Flop_1_Seler_4_to_1_0;
wire signed [WIDTH:0] D_Flip_Flop_1_Seler_4_to_1_1;
wire signed [WIDTH:0] D_Flip_Flop_1_Seler_4_to_1_2;
wire signed [WIDTH:0] D_Flip_Flop_1_Seler_4_to_1_3;
wire signed [WIDTH:0] D_Flip_Flop_1_Seler_4_to_1_4;
wire signed [WIDTH:0] D_Flip_Flop_1_Seler_4_to_1_5;
wire signed [WIDTH:0] D_Flip_Flop_1_Seler_4_to_1_6;
wire signed [WIDTH:0] D_Flip_Flop_1_Seler_4_to_1_7;

//Selector_4_to_1 U3 to Multiplier U4
wire signed [WIDTH:0] Selector_4_to_1_to_Mult_Add;
wire signed [WIDTH:0] Selector_4_to_1_to_Mult_Sub;

//Multiplier U4 to Selector_1_to_4 U5
wire signed [WIDTH-1:0] Mult_to_Selector_1_to_4_Add_A;
wire signed [WIDTH-1:0] Mult_to_Selector_1_to_4_Add_C;
wire signed [WIDTH-1:0] Mult_to_Selector_1_to_4_Add_F;
wire signed [WIDTH-1:0] Mult_to_Selector_1_to_4_Sub_B;
wire signed [WIDTH-1:0] Mult_to_Selector_1_to_4_Sub_D;
wire signed [WIDTH-1:0] Mult_to_Selector_1_to_4_Sub_E;
wire signed [WIDTH-1:0] Mult_to_Selector_1_to_4_Sub_G;

//Selector_1_to_4 U5 to Adder_2 U6
wire signed [WIDTH-1:0] Data_0_Add_7_A;
wire signed [WIDTH-1:0] Data_0_Add_7_C;
wire signed [WIDTH-1:0] Data_0_Add_7_F;
wire signed [WIDTH-1:0] Data_0_Sub_7_B;
wire signed [WIDTH-1:0] Data_0_Sub_7_D;
wire signed [WIDTH-1:0] Data_0_Sub_7_E;
wire signed [WIDTH-1:0] Data_0_Sub_7_G;
wire signed [WIDTH-1:0] Data_1_Add_6_A;
wire signed [WIDTH-1:0] Data_1_Add_6_C;
wire signed [WIDTH-1:0] Data_1_Add_6_F;
wire signed [WIDTH-1:0] Data_1_Sub_6_B;
wire signed [WIDTH-1:0] Data_1_Sub_6_D;
wire signed [WIDTH-1:0] Data_1_Sub_6_E;
wire signed [WIDTH-1:0] Data_1_Sub_6_G;
wire signed [WIDTH-1:0] Data_2_Add_5_A;
wire signed [WIDTH-1:0] Data_2_Add_5_C;
wire signed [WIDTH-1:0] Data_2_Add_5_F;
wire signed [WIDTH-1:0] Data_2_Sub_5_B;
wire signed [WIDTH-1:0] Data_2_Sub_5_D;
wire signed [WIDTH-1:0] Data_2_Sub_5_E;
wire signed [WIDTH-1:0] Data_2_Sub_5_G;
wire signed [WIDTH-1:0] Data_3_Add_4_A;
wire signed [WIDTH-1:0] Data_3_Add_4_C;
wire signed [WIDTH-1:0] Data_3_Add_4_F;
wire signed [WIDTH-1:0] Data_3_Sub_4_B;
wire signed [WIDTH-1:0] Data_3_Sub_4_D;
wire signed [WIDTH-1:0] Data_3_Sub_4_E;
wire signed [WIDTH-1:0] Data_3_Sub_4_G;

//Adder_2 U6 to D_Flip_Flop_2 U7
wire signed [WIDTH+1:0] Adder_2_to_D_Flip_Flop_2_0;
wire signed [WIDTH+1:0] Adder_2_to_D_Flip_Flop_2_1;
wire signed [WIDTH+1:0] Adder_2_to_D_Flip_Flop_2_2;
wire signed [WIDTH+1:0] Adder_2_to_D_Flip_Flop_2_3;
wire signed [WIDTH+1:0] Adder_2_to_D_Flip_Flop_2_4;
wire signed [WIDTH+1:0] Adder_2_to_D_Flip_Flop_2_5;
wire signed [WIDTH+1:0] Adder_2_to_D_Flip_Flop_2_6;
wire signed [WIDTH+1:0] Adder_2_to_D_Flip_Flop_2_7;

//D_Flip_Flop_2 U7 tp Send_8_Pixel U8
wire signed [WIDTH+1:0] D_Flip_Flop_2_to_Send_8_Pixel_0;
wire signed [WIDTH+1:0] D_Flip_Flop_2_to_Send_8_Pixel_1;
wire signed [WIDTH+1:0] D_Flip_Flop_2_to_Send_8_Pixel_2;
wire signed [WIDTH+1:0] D_Flip_Flop_2_to_Send_8_Pixel_3;
wire signed [WIDTH+1:0] D_Flip_Flop_2_to_Send_8_Pixel_4;
wire signed [WIDTH+1:0] D_Flip_Flop_2_to_Send_8_Pixel_5;
wire signed [WIDTH+1:0] D_Flip_Flop_2_to_Send_8_Pixel_6;
wire signed [WIDTH+1:0] D_Flip_Flop_2_to_Send_8_Pixel_7;

Receive_8_Pixel #(WIDTH) Receive_8_Pixel(
.Clock( Clock ),
.Reset_n( Reset_n ),
.Data_In( In_Data ),
.En_In( En_In ),
.Out_Pixel_0( Receive_8_Pixel_to_Adder_1_In_Pixel_0 ),
.Out_Pixel_1( Receive_8_Pixel_to_Adder_1_In_Pixel_1 ),
.Out_Pixel_2( Receive_8_Pixel_to_Adder_1_In_Pixel_2 ),
.Out_Pixel_3( Receive_8_Pixel_to_Adder_1_In_Pixel_3 ),
.Out_Pixel_4( Receive_8_Pixel_to_Adder_1_In_Pixel_4 ),
.Out_Pixel_5( Receive_8_Pixel_to_Adder_1_In_Pixel_5 ),
.Out_Pixel_6( Receive_8_Pixel_to_Adder_1_In_Pixel_6 ),
.Out_Pixel_7( Receive_8_Pixel_to_Adder_1_In_Pixel_7 ),
.En_Out(Start_Calc)
);

Adder_1 #(WIDTH) Adder_1(
.In_Pixel_0( Receive_8_Pixel_to_Adder_1_In_Pixel_0 ),
.In_Pixel_1( Receive_8_Pixel_to_Adder_1_In_Pixel_1 ),
.In_Pixel_2( Receive_8_Pixel_to_Adder_1_In_Pixel_2 ),
.In_Pixel_3( Receive_8_Pixel_to_Adder_1_In_Pixel_3 ),
.In_Pixel_4( Receive_8_Pixel_to_Adder_1_In_Pixel_4 ),
.In_Pixel_5( Receive_8_Pixel_to_Adder_1_In_Pixel_5 ),
.In_Pixel_6( Receive_8_Pixel_to_Adder_1_In_Pixel_6 ),
.In_Pixel_7( Receive_8_Pixel_to_Adder_1_In_Pixel_7 ),
.Data_0_Add_7( Data_0_Add_7_to_D_Flip_Flop_1_0 ),
.Data_0_Sub_7( Data_0_Sub_7_to_D_Flip_Flop_1_1 ),
.Data_1_Add_6( Data_1_Add_6_to_D_Flip_Flop_1_2 ),
.Data_1_Sub_6( Data_1_Sub_6_to_D_Flip_Flop_1_3 ),
.Data_2_Add_5( Data_2_Add_5_to_D_Flip_Flop_1_4 ),
.Data_2_Sub_5( Data_2_Sub_5_to_D_Flip_Flop_1_5 ),
.Data_3_Add_4( Data_3_Add_4_to_D_Flip_Flop_1_6 ),
.Data_3_Sub_4( Data_3_Sub_4_to_D_Flip_Flop_1_7 )
);

DCT_1D_D_Flip_Flop_1 #(WIDTH) D_Flip_Flop_1(
.Clock( Clock ),
.Reset_n( Reset_n ),
.In_Data_0( Data_0_Add_7_to_D_Flip_Flop_1_0 ),
.In_Data_1( Data_0_Sub_7_to_D_Flip_Flop_1_1 ),
.In_Data_2( Data_1_Add_6_to_D_Flip_Flop_1_2 ),
.In_Data_3( Data_1_Sub_6_to_D_Flip_Flop_1_3 ),
.In_Data_4( Data_2_Add_5_to_D_Flip_Flop_1_4 ),
.In_Data_5( Data_2_Sub_5_to_D_Flip_Flop_1_5 ),
.In_Data_6( Data_3_Add_4_to_D_Flip_Flop_1_6 ),
.In_Data_7( Data_3_Sub_4_to_D_Flip_Flop_1_7 ),
.Data_0_Add_7(D_Flip_Flop_1_Seler_4_to_1_0),
.Data_0_Sub_7(D_Flip_Flop_1_Seler_4_to_1_1),
.Data_1_Add_6(D_Flip_Flop_1_Seler_4_to_1_2),
.Data_1_Sub_6(D_Flip_Flop_1_Seler_4_to_1_3),
.Data_3_Add_4(D_Flip_Flop_1_Seler_4_to_1_4),
.Data_3_Sub_4(D_Flip_Flop_1_Seler_4_to_1_5),
.Data_2_Add_5(D_Flip_Flop_1_Seler_4_to_1_6),
.Data_2_Sub_5(D_Flip_Flop_1_Seler_4_to_1_7)
);

Selector_4_to_1 #(WIDTH) Selector_4_to_1(
.Sele(Sele),
.Data_0_Add_7(D_Flip_Flop_1_Seler_4_to_1_0),
.Data_0_Sub_7(D_Flip_Flop_1_Seler_4_to_1_1),
.Data_1_Add_6(D_Flip_Flop_1_Seler_4_to_1_2),
.Data_1_Sub_6(D_Flip_Flop_1_Seler_4_to_1_3),
.Data_3_Add_4(D_Flip_Flop_1_Seler_4_to_1_4),
.Data_3_Sub_4(D_Flip_Flop_1_Seler_4_to_1_5),
.Data_2_Add_5(D_Flip_Flop_1_Seler_4_to_1_6),
.Data_2_Sub_5(D_Flip_Flop_1_Seler_4_to_1_7),
.Out_Add_Data(Selector_4_to_1_to_Mult_Add),
.Out_Sub_Data(Selector_4_to_1_to_Mult_Sub)
);

Multiplier #(WIDTH) Multiplier(
.Data_Add(Selector_4_to_1_to_Mult_Add),
.Data_Sub(Selector_4_to_1_to_Mult_Sub),
.Out_Data_Add_A(Mult_to_Selector_1_to_4_Add_A),
.Out_Data_Add_C(Mult_to_Selector_1_to_4_Add_C),
.Out_Data_Add_F(Mult_to_Selector_1_to_4_Add_F),
.Out_Data_Sub_B(Mult_to_Selector_1_to_4_Sub_B),
.Out_Data_Sub_D(Mult_to_Selector_1_to_4_Sub_D),
.Out_Data_Sub_E(Mult_to_Selector_1_to_4_Sub_E),
.Out_Data_Sub_G(Mult_to_Selector_1_to_4_Sub_G)
);

Selector_1_to_4 #(WIDTH) Selector_1_to_4(
.Sele(Sele),
.Data_Add_A(Mult_to_Selector_1_to_4_Add_A),
.Data_Add_C(Mult_to_Selector_1_to_4_Add_C),
.Data_Add_F(Mult_to_Selector_1_to_4_Add_F),
.Data_Sub_B(Mult_to_Selector_1_to_4_Sub_B),
.Data_Sub_D(Mult_to_Selector_1_to_4_Sub_D),
.Data_Sub_E(Mult_to_Selector_1_to_4_Sub_E),
.Data_Sub_G(Mult_to_Selector_1_to_4_Sub_G),
.Data_0_Add_7_A(Data_0_Add_7_A),
.Data_0_Add_7_C(Data_0_Add_7_C),
.Data_0_Add_7_F(Data_0_Add_7_F),
.Data_0_Sub_7_B(Data_0_Sub_7_B),
.Data_0_Sub_7_D(Data_0_Sub_7_D),
.Data_0_Sub_7_E(Data_0_Sub_7_E),
.Data_0_Sub_7_G(Data_0_Sub_7_G),
.Data_1_Add_6_A(Data_1_Add_6_A),
.Data_1_Add_6_C(Data_1_Add_6_C),
.Data_1_Add_6_F(Data_1_Add_6_F),
.Data_1_Sub_6_B(Data_1_Sub_6_B),
.Data_1_Sub_6_D(Data_1_Sub_6_D),
.Data_1_Sub_6_E(Data_1_Sub_6_E),
.Data_1_Sub_6_G(Data_1_Sub_6_G),
.Data_2_Add_5_A(Data_2_Add_5_A),
.Data_2_Add_5_C(Data_2_Add_5_C),
.Data_2_Add_5_F(Data_2_Add_5_F),
.Data_2_Sub_5_B(Data_2_Sub_5_B),
.Data_2_Sub_5_D(Data_2_Sub_5_D),
.Data_2_Sub_5_E(Data_2_Sub_5_E),
.Data_2_Sub_5_G(Data_2_Sub_5_G),
.Data_3_Add_4_A(Data_3_Add_4_A),
.Data_3_Add_4_C(Data_3_Add_4_C),
.Data_3_Add_4_F(Data_3_Add_4_F),
.Data_3_Sub_4_B(Data_3_Sub_4_B),
.Data_3_Sub_4_D(Data_3_Sub_4_D),
.Data_3_Sub_4_E(Data_3_Sub_4_E),
.Data_3_Sub_4_G(Data_3_Sub_4_G)
);

Adder_2 #(WIDTH) Adder_2(
.Data_0_Add_7_A(Data_0_Add_7_A),
.Data_0_Add_7_C(Data_0_Add_7_C),
.Data_0_Add_7_F(Data_0_Add_7_F),
.Data_0_Sub_7_B(Data_0_Sub_7_B),
.Data_0_Sub_7_D(Data_0_Sub_7_D),
.Data_0_Sub_7_E(Data_0_Sub_7_E),
.Data_0_Sub_7_G(Data_0_Sub_7_G),
.Data_1_Add_6_A(Data_1_Add_6_A),
.Data_1_Add_6_C(Data_1_Add_6_C),
.Data_1_Add_6_F(Data_1_Add_6_F),
.Data_1_Sub_6_B(Data_1_Sub_6_B),
.Data_1_Sub_6_D(Data_1_Sub_6_D),
.Data_1_Sub_6_E(Data_1_Sub_6_E),
.Data_1_Sub_6_G(Data_1_Sub_6_G),
.Data_2_Add_5_A(Data_2_Add_5_A),
.Data_2_Add_5_C(Data_2_Add_5_C),
.Data_2_Add_5_F(Data_2_Add_5_F),
.Data_2_Sub_5_B(Data_2_Sub_5_B),
.Data_2_Sub_5_D(Data_2_Sub_5_D),
.Data_2_Sub_5_E(Data_2_Sub_5_E),
.Data_2_Sub_5_G(Data_2_Sub_5_G),
.Data_3_Add_4_A(Data_3_Add_4_A),
.Data_3_Add_4_C(Data_3_Add_4_C),
.Data_3_Add_4_F(Data_3_Add_4_F),
.Data_3_Sub_4_B(Data_3_Sub_4_B),
.Data_3_Sub_4_D(Data_3_Sub_4_D),
.Data_3_Sub_4_E(Data_3_Sub_4_E),
.Data_3_Sub_4_G(Data_3_Sub_4_G),
.Out_Data_0(Adder_2_to_D_Flip_Flop_2_0),
.Out_Data_1(Adder_2_to_D_Flip_Flop_2_1),
.Out_Data_2(Adder_2_to_D_Flip_Flop_2_2),
.Out_Data_3(Adder_2_to_D_Flip_Flop_2_3),
.Out_Data_4(Adder_2_to_D_Flip_Flop_2_4),
.Out_Data_5(Adder_2_to_D_Flip_Flop_2_5),
.Out_Data_6(Adder_2_to_D_Flip_Flop_2_6),
.Out_Data_7(Adder_2_to_D_Flip_Flop_2_7)
);

DCT_1D_D_Flip_Flop_2 #(WIDTH) D_Flip_Flop_2(
.Clock(Clock),
.Reset_n(Reset_n),
.In_Data_0(Adder_2_to_D_Flip_Flop_2_0),
.In_Data_1(Adder_2_to_D_Flip_Flop_2_1),
.In_Data_2(Adder_2_to_D_Flip_Flop_2_2),
.In_Data_3(Adder_2_to_D_Flip_Flop_2_3),
.In_Data_4(Adder_2_to_D_Flip_Flop_2_4),
.In_Data_5(Adder_2_to_D_Flip_Flop_2_5),
.In_Data_6(Adder_2_to_D_Flip_Flop_2_6),
.In_Data_7(Adder_2_to_D_Flip_Flop_2_7),
.Out_Data_0(D_Flip_Flop_2_to_Send_8_Pixel_0),
.Out_Data_1(D_Flip_Flop_2_to_Send_8_Pixel_1),
.Out_Data_2(D_Flip_Flop_2_to_Send_8_Pixel_2),
.Out_Data_3(D_Flip_Flop_2_to_Send_8_Pixel_3),
.Out_Data_4(D_Flip_Flop_2_to_Send_8_Pixel_4),
.Out_Data_5(D_Flip_Flop_2_to_Send_8_Pixel_5),
.Out_Data_6(D_Flip_Flop_2_to_Send_8_Pixel_6),
.Out_Data_7(D_Flip_Flop_2_to_Send_8_Pixel_7)
);

Send_8_Pixel #(WIDTH) Send_8_Pixel(
.Clock(Clock),
.Reset_n(Reset_n),
.In_Data_0(D_Flip_Flop_2_to_Send_8_Pixel_0),
.In_Data_1(D_Flip_Flop_2_to_Send_8_Pixel_1),
.In_Data_2(D_Flip_Flop_2_to_Send_8_Pixel_2),
.In_Data_3(D_Flip_Flop_2_to_Send_8_Pixel_3),
.In_Data_4(D_Flip_Flop_2_to_Send_8_Pixel_4),
.In_Data_5(D_Flip_Flop_2_to_Send_8_Pixel_5),
.In_Data_6(D_Flip_Flop_2_to_Send_8_Pixel_6),
.In_Data_7(D_Flip_Flop_2_to_Send_8_Pixel_7),
.Out_Data(Out_Data),
.Start(End_Calc),
.En_Out(En_Out)
);

endmodule