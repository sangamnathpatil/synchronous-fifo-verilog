module fifo(
	input wire reset,
	input wire clock,
	input wire wr_enable,
	input wire rd_enable,
	input [7:0] din,

	output reg [7:0] dout,
	output reg [4:0] count,
	output wire full,
	output wire empty
);

	//DECLARING STORaGE
	reg [7:0] memory [15:0];

	//CIRCULAR MEMORY
	reg [3:0] wr_pntr;
	reg [3:0] rd_pntr;

	//STATUS FLAG
	assign full = (count == 5'd16);
	assign empty = (count == 5'd0);

	//ACCEPTED TRANSACTION
	wire write_accept;
	wire read_accept;

	//ASSIGNING TRANSACTION
	assign read_accept = rd_enable && !empty;
	assign write_accept = wr_enable && !full;

	always@(posedge clock or posedge reset) begin
		
		//RSEST OPERATION
		if(reset) begin
			wr_pntr <= 4'd0;
			rd_pntr <= 4'd0;
			count <= 5'd0;
			dout <= 8'd0;
		end
		

		//WRITE OPERATION
		else begin
			if (write_accept) begin
			memory [wr_pntr] <= din;
			wr_pntr <= wr_pntr + 4'd1;
			end


		//READ OPERATION
			if (read_accept) begin
			dout <= memory[rd_pntr];
			rd_pntr <= rd_pntr + 4'd1;
			end

		//COUNT OPERATION
			case ({write_accept, read_accept})

			2'b10: count <= count + 5'd1;
			2'b01: count <= count - 5'd1;
			default: count <= count;

			endcase
		end
	end

endmodule
	
