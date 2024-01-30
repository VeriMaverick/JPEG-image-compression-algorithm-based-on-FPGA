module DCT_1D(
Clock,
Reset_n,
En_In,
Data_In,
En_Out,
Data_Out
);

parameter WIDTH = 8;
input Clock;
input Reset_n;
input En_In;    //Input enable signal
input signed [WIDTH-1:0]Data_In;

output En_Out;  //Output enable signal
output signed [WIDTH+1:0]Data_Out;

wire [1:0]Sele;
wire End_Calc;      //End signal
wire Start_Calc;    //Sstart signal

//U0    Instantiate DCT_1D_1_Data_Path module
//Pass parameter 8 to DCT_1D_1_Data_Path module
DCT_1D_Data_Path #(WIDTH) DCT_1D_1_Data_Path(
.Clock(Clock),
.Reset_n(Reset_n),
.Sele(Sele),
.In_Data(Data_In),
.En_In(En_In),
.End_Calc(End_Calc),
.Start_Calc(Start_Calc),
.Out_Data(Data_Out),
.En_Out(En_Out)
);

//U1    Instantiate DCT_1D_1_Control_Unit module
DCT_1D_Control_Unit Control_Unit(
.Clock(Clock),
.Reset_n(Reset_n),
.Sele(Sele),
.End_Calc(End_Calc),
.Start_Calc(Start_Calc)
);

endmodule 