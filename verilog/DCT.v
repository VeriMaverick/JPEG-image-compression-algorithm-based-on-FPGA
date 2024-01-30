module DCT(
Clock,
Reset_n,
En_In,
In_Data,
En_Out,
Out_Data
);

input Clock;
input Reset_n;
input En_In;            //Input enable signal
input signed [7:0] In_Data;

output En_Out;          //Output enable signal
output signed [11:0] Out_Data;

wire En_U0_to_U1;       //Enable transmission from U0 to U1
wire En_U1_to_U2;       //Enable transmission from U1 to U2
wire signed [9:0] Data_U0_to_U1; //Data transmission from U0 to U1
wire signed [9:0] Data_U1_to_U0; //Data transmission from U1 to U0

//U0    Instantiate DCT_1D_1 module
DCT_1D #(8) DCT_1D_1(
.Clock(Clock),
.Reset_n(Reset_n),
.En_In(En_In),
.Data_In(In_Data),
.En_Out(En_U0_to_U1),
.Data_Out(Data_U0_to_U1)
);

//U1    Instantiate Mem module
Mem Mem(
.Clock(Clock),
.Reset_n(Reset_n),
.In_Data(Data_U0_to_U1),
.En_In(En_U0_to_U1),
.Out_Data(Data_U1_to_U0),
.En_Out(En_U1_to_U2)
);

//U2    Instantiate DCT_1D_2 module
DCT_1D #(10) DCT_1D_2(
.Clock(Clock),
.Reset_n(Reset_n),
.En_In(En_U1_to_U2),
.Data_In(Data_U1_to_U0),
.En_Out(En_Out),
.Data_Out(Out_Data)
);

endmodule 