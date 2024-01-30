module JPEG_DCT(
Clock,
Reset_n,
En_In,
In_Data, 
Out_Data, 
En_Out
);

input Clock;
input Reset_n;
input En_In;            //Input enable signal
input [15:0] In_Data;   // RGB565,R[4:0];G[10:5];B=[15:11];

output signed [11:0] Out_Data;
output En_Out;          //Output enable signal

wire signed [7:0] Data_U0_to_U1;
wire En_U0_to_U1;       //Enable transmission from U0 to U1

//U0    Instantiate Dispose module
Dispose Dispose(
.Clock(Clock),
.Reset_n(Reset_n),
.En_In(En_In),
.Data_In(In_Data),
.En_Out(En_U0_to_U1),
.Data_Out(Data_U0_to_U1)
);

//U1    Instantiate DCT module
DCT DCT(
.Clock(Clock),
.Reset_n(Reset_n),
.En_In(En_U0_to_U1),
.In_Data(Data_U0_to_U1),
.En_Out(En_Out),
.Out_Data(Out_Data)
);

endmodule 