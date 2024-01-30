`timescale 1ns / 1ns 
module JPEG_DCT_TB();
integer fileId0,fileId1,cc,out_file1,out_file2,i,j,k,dct_cnt,dct_cnt2,y_cnt,y2_cnt;
reg [7:0]bmp_data0[0:307300];   //54+320x320x3
reg signed[10:0]mem_dctdata[0:320*320-1];   //320x320
reg signed[11:0]mem_dctdata2[0:320*320-1];   //320x320
reg signed[7:0]mem_ydata[0:320*320-1];   //320x320
reg signed[7:0]mem_y2data[0:320*320-1];   //320x320
reg signed[9:0]mem_8x8_1[0:63];   //8x8
reg signed[7:0]mem_y_back[0:320*320-1];   //320x320
reg signed[11:0]mem_dct2_exp[0:320*320-1];   //320x320
integer bmp_width0,bmp_hight0,data_start_index0,bmp_size0;

//read bmp image data
initial begin
fileId0 = $fopen("1.bmp","rb");    //org image 320x320
out_file1 = $fopen("out1.bmp","wb"); //gray image of org image 
out_file2 = $fopen("out2.bmp","wb"); //gray image from I-DCT back
cc = $fread(bmp_data0, fileId0);
bmp_width0 = {bmp_data0[21],bmp_data0[20],bmp_data0[19],bmp_data0[18]};
bmp_hight0 = {bmp_data0[25],bmp_data0[24],bmp_data0[23],bmp_data0[22]};
data_start_index0 = {bmp_data0[13],bmp_data0[12],bmp_data0[11],bmp_data0[10]};
bmp_size0 = {bmp_data0[5],bmp_data0[4],bmp_data0[3],bmp_data0[2]};
end


parameter CYCLE = 10;
reg clk;
reg rst_n;

reg en;
reg [15:0]in;  // RGB565 R=in[4:0];G=in[10:5];B=in[15:11];

wire[11:0]dct_data;
wire dct_en;
//DUT instance                        
JPEG_DCT JPEG_DCT (
// port map - connection between master ports and signals/registers   
	.Clock(clk),
	.Out_Data(dct_data),
	.En_Out(dct_en),
	.En_In(en),
	.In_Data(in),
	.Reset_n(rst_n)
);
//generage clock
initial begin
	clk = 0;
	forever begin
		#(CYCLE/2);
		clk = 1;
		#(CYCLE/2);
		clk = 0;
	end
end

integer	fw0,fw1,fw2,fw3,fw4,fw5,fw6,fw7;
initial begin
	fw0	= $fopen("rgb565.txt","w");
	fw1	= $fopen("dct2_act.txt","w");
	fw2	= $fopen("y_act.txt","w");
	fw3	= $fopen("dct2_exp.txt","w");
	fw4	= $fopen("dct1_act.txt","w");
	fw5	= $fopen("dct1_exp.txt","w");
	fw6	= $fopen("y_back.txt","w");
	fw7	= $fopen("y8x8_act.txt","w");
end

initial begin
	dct_cnt	= 0;
	dct_cnt2	= 0;
	y_cnt	= 0;
	y2_cnt	= 0;
	rst_n	= 0;
	en	= 0;
	in	= 0;
	repeat(5)@(posedge clk);
	rst_n = 1;
	repeat(5)@(posedge clk);

	//BGR888->RGB565 to DUT input
	for(i=0; i<(bmp_size0-data_start_index0)/3; i=i+1)begin
		#1;
		en = 1;
		in = {bmp_data0[data_start_index0+i*3+2][7:3],bmp_data0[data_start_index0+i*3+1][7:2],bmp_data0[data_start_index0+i*3][7:3]};
		$fdisplay(fw0,"%h",in);
		@(posedge clk);
	end
	en	= 0;
	
	#(CYCLE*5000);
	$display("dtc_out number is%d",dct_cnt2);
	//generate DCT expected value for RTL debug
	//DCT model
	for(i=0; i<bmp_width0*bmp_hight0/64; i=i+1)begin
		for(j=0; j<64/8; j=j+1)begin
			k = i/(bmp_width0/8)*8*bmp_width0+(i%(bmp_width0/8))*8+j*bmp_width0;
			//if(i==0&&j==7)$display("k=%d,%d,%d,%d,%d,%d,%d,%d,%d",k,mem_ydata[k],mem_ydata[k+1],mem_ydata[k+2],mem_ydata[k+3],mem_ydata[k+4],mem_ydata[k+5],mem_ydata[k+6],mem_ydata[k+7]);
			t_dct1(
				mem_ydata[k],
				mem_ydata[k+1],
				mem_ydata[k+2],
				mem_ydata[k+3],
				mem_ydata[k+4],
				mem_ydata[k+5],
				mem_ydata[k+6],
				mem_ydata[k+7],
				mem_8x8_1[j],
				mem_8x8_1[j+8],
				mem_8x8_1[j+8*2],
				mem_8x8_1[j+8*3],
				mem_8x8_1[j+8*4],
				mem_8x8_1[j+8*5],
				mem_8x8_1[j+8*6],
				mem_8x8_1[j+8*7]
			);
		end

		for(j=0; j<64; j=j+1)begin
			$fwrite(fw5,"%d",mem_8x8_1[j]);
			if(j%8==7)$fwrite(fw5, "\n");
			if(j%64==63)$fwrite(fw5, "\n");
		end		
		for(j=0; j<64/8; j=j+1)begin
			t_dct2(
				mem_8x8_1[j*8],
				mem_8x8_1[j*8+1],
				mem_8x8_1[j*8+2],
				mem_8x8_1[j*8+3],
				mem_8x8_1[j*8+4],
				mem_8x8_1[j*8+5],
				mem_8x8_1[j*8+6],
				mem_8x8_1[j*8+7],
				mem_dct2_exp[i*64+j*8],
				mem_dct2_exp[i*64+j*8+1],
				mem_dct2_exp[i*64+j*8+2],
				mem_dct2_exp[i*64+j*8+3],
				mem_dct2_exp[i*64+j*8+4],
				mem_dct2_exp[i*64+j*8+5],
				mem_dct2_exp[i*64+j*8+6],
				mem_dct2_exp[i*64+j*8+7]
			);
			//if(i==0&&j==0)$display("%d,%d,%d,%d,%d,%d,%d,%d",mem_8x8_1[j*8],mem_8x8_1[j*8+1],mem_8x8_1[j*8+2],mem_8x8_1[j*8+3],mem_8x8_1[j*8+4],mem_8x8_1[j*8+5],mem_8x8_1[j*8+6],mem_8x8_1[j*8+7]);
		end
	end
	for(i=0; i<bmp_width0*bmp_hight0; i=i+1)begin
		$fwrite(fw3,"%d",mem_dct2_exp[i]);
		if(i%8==7)$fwrite(fw3, "\n");
		if(i%64==63)$fwrite(fw3, "\n");
	end
	//generate Y value from I-DCT model
	//I-DCT model
	for(i=0; i<bmp_width0*bmp_hight0/64; i=i+1)begin
		for(j=0; j<64/8; j=j+1)begin
			t_idct1(
				mem_dctdata2[i*64+j*8],
				mem_dctdata2[i*64+j*8+1],
				mem_dctdata2[i*64+j*8+2],
				mem_dctdata2[i*64+j*8+3],
				mem_dctdata2[i*64+j*8+4],
				mem_dctdata2[i*64+j*8+5],
				mem_dctdata2[i*64+j*8+6],
				mem_dctdata2[i*64+j*8+7],
				mem_8x8_1[j],
				mem_8x8_1[j+8],
				mem_8x8_1[j+8*2],
				mem_8x8_1[j+8*3],
				mem_8x8_1[j+8*4],
				mem_8x8_1[j+8*5],
				mem_8x8_1[j+8*6],
				mem_8x8_1[j+8*7]
			);
		end
		for(j=0; j<64/8; j=j+1)begin
			k = i/(bmp_width0/8)*8*bmp_width0+(i%(bmp_width0/8))*8+j*bmp_width0;
			t_idct2(
				mem_8x8_1[j*8],
				mem_8x8_1[j*8+1],
				mem_8x8_1[j*8+2],
				mem_8x8_1[j*8+3],
				mem_8x8_1[j*8+4],
				mem_8x8_1[j*8+5],
				mem_8x8_1[j*8+6],
				mem_8x8_1[j*8+7],
				mem_y_back[k],
				mem_y_back[k+1],
				mem_y_back[k+2],
				mem_y_back[k+3],
				mem_y_back[k+4],
				mem_y_back[k+5],
				mem_y_back[k+6],
				mem_y_back[k+7]
			);
		end
	end
	for(i=0; i<bmp_width0*bmp_hight0; i=i+1)begin
		$fdisplay(fw6,mem_y_back[i]);
	end

	//output y image
	for(i=0;i<(bmp_size0-data_start_index0)/3;i=i+1)begin
		bmp_data0[i*3+data_start_index0]  ={~mem_ydata[i][7],mem_ydata[i][6:0]};
		bmp_data0[i*3+1+data_start_index0]={~mem_ydata[i][7],mem_ydata[i][6:0]};
		bmp_data0[i*3+2+data_start_index0]={~mem_ydata[i][7],mem_ydata[i][6:0]};
	end
	for(i=0;i<bmp_size0;i=i+1)begin
		$fwrite(out_file1,"%c",bmp_data0[i]);
	end

	//output y image from idct2
	for(i=0;i<(bmp_size0-data_start_index0)/3;i=i+1)begin
		bmp_data0[i*3+data_start_index0]  ={~mem_y_back[i][7],mem_y_back[i][6:0]};
		bmp_data0[i*3+1+data_start_index0]={~mem_y_back[i][7],mem_y_back[i][6:0]};
		bmp_data0[i*3+2+data_start_index0]={~mem_y_back[i][7],mem_y_back[i][6:0]};
	end
	for(i=0;i<bmp_size0;i=i+1)begin
		$fwrite(out_file2,"%c",bmp_data0[i]);
	end
	
	$fclose(fileId0);
	$fclose(fw0);
	$fclose(fw1);
	$fclose(fw2);
	$fclose(fw3);
	$fclose(fw4);
	$fclose(fw5);
	$fclose(fw6);
	$fclose(fw7);
	$fclose(out_file1);
	$fclose(out_file2);
	$display("sim end!!!");
	$finish;
end


//print y_data of RTL 
always@(posedge clk)
begin
  if(JPEG_DCT.Dispose.RGB_to_Y.En_Out ) 
  begin
	mem_ydata[y_cnt] = JPEG_DCT.Dispose.RGB_to_Y.Out_Y;
	//$fdisplay(fw2, jpeg_dct.dispose.y_data );
	$fdisplay(fw2, mem_ydata[y_cnt] );
	y_cnt = y_cnt+1;
  end
end
//print y_data(8x8) of RTL 
always@(posedge clk)
begin
  if(JPEG_DCT.Dispose.En_Out ) 
  begin
	mem_y2data[y2_cnt] = JPEG_DCT.Dispose.Data_Out;
	//$fdisplay(fw2, jpeg_dct.dispose.y_data );
	$fwrite(fw7, "%d",mem_y2data[y2_cnt] );
	if(y2_cnt%8==7)$fwrite(fw7, "\n");
	if(y2_cnt%64==63)$fwrite(fw7, "\n");
	y2_cnt = y2_cnt+1;
  end
end
//print dct2_data of RTL 
always@(posedge clk)
begin
  if(dct_en ) 
  begin
	mem_dctdata2[dct_cnt2] = dct_data;
	//$fwrite(fw1, "%d", $signed(dct_data));
	$fwrite(fw1, "%d",mem_dctdata2[dct_cnt2] );
	if(dct_cnt2%8==7)$fwrite(fw1, "\n");
	if(dct_cnt2%64==63)$fwrite(fw1, "\n");
	dct_cnt2 = dct_cnt2+1;
  end
end
//print dct1_data of RTL 
always@(posedge clk)
begin
  if(JPEG_DCT.DCT.Mem.En_Out) 
  begin
	mem_dctdata[dct_cnt] = JPEG_DCT.DCT.Mem.Out_Data;
	//$fwrite(fw4, "%d", $signed(jpeg_dct.DCT2.out_data));
	$fwrite(fw4, "%d",mem_dctdata[dct_cnt] );
	if(dct_cnt%8==7)$fwrite(fw4, "\n");
	if(dct_cnt%64==63)$fwrite(fw4, "\n");
	dct_cnt = dct_cnt+1;
  end
end
////print dct1_data of RTL 
//always@(posedge clk)
//begin
//  if(jpeg_dct.DCT2.DCT_en ) 
//  begin
//	mem_dctdata[dct_cnt] = jpeg_dct.DCT2.DCT_data;
//	//$fwrite(fw4, "%d", $signed(jpeg_dct.DCT2.out_data));
//	$fwrite(fw4, "%d",mem_dctdata[dct_cnt] );
//	if(dct_cnt%8==7)$fwrite(fw4, "\n");
//	if(dct_cnt%64==63)$fwrite(fw4, "\n");
//	dct_cnt = dct_cnt+1;
//  end
//end
//DCT task
parameter a = 362;//0.3536*1024
parameter b = 502;//0.4904
parameter c = 473;//0.4619
parameter d = 426;//0.4157
parameter e = 284;//0.2778
parameter f = 196;//0.1913
parameter g = 100;//0.0975
task t_dct1;
input	signed[7:0]	x0;
input	signed[7:0]	x1;
input	signed[7:0]	x2;
input	signed[7:0]	x3;
input	signed[7:0]	x4;
input	signed[7:0]	x5;
input	signed[7:0]	x6;
input	signed[7:0]	x7;
output	signed[9:0]	y0;
output	signed[9:0]	y1;
output	signed[9:0]	y2;
output	signed[9:0]	y3;
output	signed[9:0]	y4;
output	signed[9:0]	y5;
output	signed[9:0]	y6;
output	signed[9:0]	y7;
begin
	y0 = (a*x0 +a*x1 +a*x2 +a*x3 +a*x4 +a*x5 +a*x6 +a*x7)/1024;
	y1 = (b*x0 +d*x1 +e*x2 +g*x3 -g*x4 -e*x5 -d*x6 -b*x7)/1024;
	y2 = (c*x0 +f*x1 -f*x2 -c*x3 -c*x4 -f*x5 +f*x6 +c*x7)/1024;
	y3 = (d*x0 -g*x1 -b*x2 -e*x3 +e*x4 +b*x5 +g*x6 -d*x7)/1024;
	y4 = (a*x0 -a*x1 -a*x2 +a*x3 +a*x4 -a*x5 -a*x6 +a*x7)/1024;
	y5 = (e*x0 -b*x1 +g*x2 +d*x3 -d*x4 -g*x5 +b*x6 -e*x7)/1024;
	y6 = (f*x0 -c*x1 +c*x2 -f*x3 -f*x4 +c*x5 -c*x6 +f*x7)/1024;
	y7 = (g*x0 -e*x1 +d*x2 -b*x3 +b*x4 -d*x5 +e*x6 -g*x7)/1024;
end
endtask
task t_dct2;
input	signed[9:0]	x0;
input	signed[9:0]	x1;
input	signed[9:0]	x2;
input	signed[9:0]	x3;
input	signed[9:0]	x4;
input	signed[9:0]	x5;
input	signed[9:0]	x6;
input	signed[9:0]	x7;
output	signed[11:0]	y0;
output	signed[11:0]	y1;
output	signed[11:0]	y2;
output	signed[11:0]	y3;
output	signed[11:0]	y4;
output	signed[11:0]	y5;
output	signed[11:0]	y6;
output	signed[11:0]	y7;
begin
	y0 = (a*x0 +a*x1 +a*x2 +a*x3 +a*x4 +a*x5 +a*x6 +a*x7)/1024;
	y1 = (b*x0 +d*x1 +e*x2 +g*x3 -g*x4 -e*x5 -d*x6 -b*x7)/1024;
	y2 = (c*x0 +f*x1 -f*x2 -c*x3 -c*x4 -f*x5 +f*x6 +c*x7)/1024;
	y3 = (d*x0 -g*x1 -b*x2 -e*x3 +e*x4 +b*x5 +g*x6 -d*x7)/1024;
	y4 = (a*x0 -a*x1 -a*x2 +a*x3 +a*x4 -a*x5 -a*x6 +a*x7)/1024;
	y5 = (e*x0 -b*x1 +g*x2 +d*x3 -d*x4 -g*x5 +b*x6 -e*x7)/1024;
	y6 = (f*x0 -c*x1 +c*x2 -f*x3 -f*x4 +c*x5 -c*x6 +f*x7)/1024;
	y7 = (g*x0 -e*x1 +d*x2 -b*x3 +b*x4 -d*x5 +e*x6 -g*x7)/1024;
end
endtask

//I-DCT task
task t_idct1;
input	signed[11:0]	x0;
input	signed[11:0]	x1;
input	signed[11:0]	x2;
input	signed[11:0]	x3;
input	signed[11:0]	x4;
input	signed[11:0]	x5;
input	signed[11:0]	x6;
input	signed[11:0]	x7;
output	signed[9:0]	y0;
output	signed[9:0]	y1;
output	signed[9:0]	y2;
output	signed[9:0]	y3;
output	signed[9:0]	y4;
output	signed[9:0]	y5;
output	signed[9:0]	y6;
output	signed[9:0]	y7;
integer y0i;
integer y1i;
integer y2i;
integer y3i;
integer y4i;
integer y5i;
integer y6i;
integer y7i;
begin
	y0i = (a*x0 +b*x1 +c*x2 +d*x3 +a*x4 +e*x5 +f*x6 +g*x7)/1024;
	y1i = (a*x0 +d*x1 +f*x2 -g*x3 -a*x4 -b*x5 -c*x6 -e*x7)/1024;
	y2i = (a*x0 +e*x1 -f*x2 -b*x3 -a*x4 +g*x5 +c*x6 +d*x7)/1024;
	y3i = (a*x0 +g*x1 -c*x2 -e*x3 +a*x4 +d*x5 -f*x6 -b*x7)/1024;
	y4i = (a*x0 -g*x1 -c*x2 +e*x3 +a*x4 -d*x5 -f*x6 +b*x7)/1024;
	y5i = (a*x0 -e*x1 -f*x2 +b*x3 -a*x4 -g*x5 +c*x6 -d*x7)/1024;
	y6i = (a*x0 -d*x1 +f*x2 +g*x3 -a*x4 +b*x5 -c*x6 +e*x7)/1024;
	y7i = (a*x0 -b*x1 +c*x2 -d*x3 +a*x4 -e*x5 +f*x6 -g*x7)/1024;
	y0 = y0i>511 ? 511 : y0i<-512 ? -512 : y0i;
	y1 = y1i>511 ? 511 : y1i<-512 ? -512 : y1i;
	y2 = y2i>511 ? 511 : y2i<-512 ? -512 : y2i;
	y3 = y3i>511 ? 511 : y3i<-512 ? -512 : y3i;
	y4 = y4i>511 ? 511 : y4i<-512 ? -512 : y4i;
	y5 = y5i>511 ? 511 : y5i<-512 ? -512 : y5i;
	y6 = y6i>511 ? 511 : y6i<-512 ? -512 : y6i;
	y7 = y7i>511 ? 511 : y7i<-512 ? -512 : y7i;
end
endtask
task t_idct2;
input	signed[9:0]	x0;
input	signed[9:0]	x1;
input	signed[9:0]	x2;
input	signed[9:0]	x3;
input	signed[9:0]	x4;
input	signed[9:0]	x5;
input	signed[9:0]	x6;
input	signed[9:0]	x7;
output	signed[7:0]	y0;
output	signed[7:0]	y1;
output	signed[7:0]	y2;
output	signed[7:0]	y3;
output	signed[7:0]	y4;
output	signed[7:0]	y5;
output	signed[7:0]	y6;
output	signed[7:0]	y7;
integer y0i;
integer y1i;
integer y2i;
integer y3i;
integer y4i;
integer y5i;
integer y6i;
integer y7i;
begin
	y0i = (a*x0 +b*x1 +c*x2 +d*x3 +a*x4 +e*x5 +f*x6 +g*x7)/1024;
	y1i = (a*x0 +d*x1 +f*x2 -g*x3 -a*x4 -b*x5 -c*x6 -e*x7)/1024;
	y2i = (a*x0 +e*x1 -f*x2 -b*x3 -a*x4 +g*x5 +c*x6 +d*x7)/1024;
	y3i = (a*x0 +g*x1 -c*x2 -e*x3 +a*x4 +d*x5 -f*x6 -b*x7)/1024;
	y4i = (a*x0 -g*x1 -c*x2 +e*x3 +a*x4 -d*x5 -f*x6 +b*x7)/1024;
	y5i = (a*x0 -e*x1 -f*x2 +b*x3 -a*x4 -g*x5 +c*x6 -d*x7)/1024;
	y6i = (a*x0 -d*x1 +f*x2 +g*x3 -a*x4 +b*x5 -c*x6 +e*x7)/1024;
	y7i = (a*x0 -b*x1 +c*x2 -d*x3 +a*x4 -e*x5 +f*x6 -g*x7)/1024;
	y0 = y0i>127 ? 127 : y0i<-128 ? -128 : y0i;
	y1 = y1i>127 ? 127 : y1i<-128 ? -128 : y1i;
	y2 = y2i>127 ? 127 : y2i<-128 ? -128 : y2i;
	y3 = y3i>127 ? 127 : y3i<-128 ? -128 : y3i;
	y4 = y4i>127 ? 127 : y4i<-128 ? -128 : y4i;
	y5 = y5i>127 ? 127 : y5i<-128 ? -128 : y5i;
	y6 = y6i>127 ? 127 : y6i<-128 ? -128 : y6i;
	y7 = y7i>127 ? 127 : y7i<-128 ? -128 : y7i;
end
endtask

endmodule 