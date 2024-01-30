module DCT_1D_Control_Unit(
Clock,
Reset_n,
Start_Calc,
Sele,
End_Calc
);

input Clock;
input Reset_n;
input Start_Calc;       //Start calculation signal

output [1:0]Sele;       //Data selection signal
output End_Calc;        //Calculation completion signal

//Typical Gray Code
parameter ST_IDLE    =  3'b000; //Idle state
parameter ST_ADDER_1 =  3'b001; //Adder_ 1 Work
parameter ST_MULT_1  =  3'b011; //Multiplier_ 1 Work
parameter ST_MULT_2  =  3'b010; //Multiplier_ 2 Work
parameter ST_MULT_3  =  3'b110; //Multiplier_ 3 Work
parameter ST_MULT_4  =  3'b111; //Multiplier_ 4 Work
parameter ST_Empty   =  3'b101; //ST_Empty
parameter ST_ADDER_2 =  3'b100; //Adder_ 2 Work

reg [1:0]Sele;              //Data selection signal
reg End_Calc;               //Calculation completion signal
reg [2:0] Present_State;    //Present State
reg [2:0] Next_State;

//Three stage description of state machine
//The first stage: the state register
always @(posedge Clock or negedge Reset_n)
begin
    if(!Reset_n)
        Present_State <= ST_IDLE;
    else
        Present_State <= Next_State;
end
//The second stage: the next state logic
always @(*)
begin
	case(Present_State)
		ST_IDLE:
			begin
				if(Start_Calc)
					Next_State = ST_ADDER_1;
            else
					Next_State = ST_IDLE;
			end
        ST_ADDER_1: Next_State = ST_MULT_1;
        ST_MULT_1: Next_State = ST_MULT_2;
        ST_MULT_2: Next_State = ST_MULT_3;
        ST_MULT_3: Next_State = ST_MULT_4;
        ST_MULT_4: Next_State = ST_Empty;
		  ST_Empty  : Next_State = ST_ADDER_2;
		  ST_ADDER_2: Next_State = ST_IDLE;
        default: Next_State = ST_IDLE;
    endcase
end
//The third stage: the output logic
always @(posedge Clock or negedge Reset_n)
begin
	if(!Reset_n)
	begin
		Sele <= 2'b00; End_Calc = 1'b0;
	end
	else
	begin
        case(Present_State)
            ST_IDLE:    begin Sele <= 2'b00; End_Calc = 1'b0; end
            ST_ADDER_1: begin Sele <= 2'b00; End_Calc = 1'b0; end
            ST_MULT_1:  begin Sele <= 2'b01; End_Calc = 1'b0; end
            ST_MULT_2:  begin Sele <= 2'b10; End_Calc = 1'b0; end
            ST_MULT_3:  begin Sele <= 2'b11; End_Calc = 1'b0; end
            ST_MULT_4:  begin Sele <= 2'b00; End_Calc = 1'b0; end
				ST_Empty  : begin Sele <= 2'b00; End_Calc = 1'b0; end
            ST_ADDER_2: begin Sele <= 2'b00; End_Calc = 1'b1; end
            default:    begin Sele <= 2'b00; End_Calc = 1'b0; end
        endcase
	end
end

endmodule 