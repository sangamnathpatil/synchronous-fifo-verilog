module fifo_tb;

reg reset;
reg clock = 0;
reg wr_enable;
reg rd_enable;
reg [7:0] din;

wire full;
wire empty;
wire [4:0] count;
wire [7:0] dout;

fifo dut(reset, clock, wr_enable, rd_enable, din, dout, count, full, empty);

always #10 clock = ~clock;

initial begin

	
	$monitor("din=%b  wr_enable=%b  rd_enable=%b  reset=%b  |  dout=%b  count=%d  full=%b  empty=%b",din,wr_enable,rd_enable,reset,dout,count,full,empty);


	@(posedge clock); reset=1; wr_enable=0; rd_enable=0; din=0;

	repeat (2) @(posedge clock); reset=0; 

	//--------write 1
	@(posedge clock);
	wr_enable=1;
	rd_enable=0;
	din=8'hA5;
	

	//--------write 2
	@(posedge clock);
	wr_enable=1;
	rd_enable=0;
	din=8'hFF;
	

	//---------read 1
	@(posedge clock);
	wr_enable=0;
	rd_enable=1;
	

	//---------both write and read
	@(posedge clock);
	wr_enable=1;
	rd_enable=1;
	din=8'hAA;
	

	//---------read 2
	@(posedge clock);
	wr_enable=0;
	rd_enable=1;

	$finish;
	

end
endmodule
