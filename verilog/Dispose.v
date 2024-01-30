module Dispose(
Clock,
Reset_n,
En_In,
Data_In,
En_Out,
Data_Out
);

input Clock;
input Reset_n;
input En_In;            //Input enable signal
input [15:0] Data_In;   //RGB565,R[4:0];G[10:5];B=[15:11];

output En_Out;          //Output enable signal
output [7:0] Data_Out;

wire En_Y_to_Image;     //Enable transmission from U0 to U1
wire [7:0] Data_Y_to_Image;

//U0    Instantiate RGB_to_Y module
RGB_to_Y RGB_to_Y( 
.Clock( Clock ),
.Reset_n( Reset_n ),
.In_Data( Data_In ),
.En_In( En_In ),
.En_Out( En_Y_to_Image ),
.Out_Y( Data_Y_to_Image )
);

//U1    Instantiate Image module
Image Image(
.Clock( Clock ),
.Reset_n( Reset_n ),
.En_In( En_Y_to_Image ),
.In_Data(Data_Y_to_Image),
.En_Out( En_Out ),
.Out_Data(Data_Out)
);

endmodule