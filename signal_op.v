module signal_op(clk, rst, forward, backward, left, right, auto_mode_signal, dance_mode_signal,
		LED_shutdown, LED_headlight, LED_yellowflash,
		rst_op, forward_op, backward_op, left_op, right_op, auto_mode_signal_op, dance_mode_signal_op,
		LED_shutdown_op, LED_headlight_op, LED_yellowflash_op);
    input clk;
    input rst;
	input forward;
    input backward;
    input left;
	input right;
	input auto_mode_signal;
	input dance_mode_signal;
	input LED_shutdown, LED_headlight, LED_yellowflash;
	output rst_op, forward_op, backward_op, left_op, right_op, auto_mode_signal_op, dance_mode_signal_op;
	output LED_shutdown_op, LED_headlight_op, LED_yellowflash_op;
	wire rst_db, forward_db, backward_db, left_db, right_db, auto_mode_signal_db, dance_mode_signal_db;
	wire LED_shutdown_db, LED_headlight_db, LED_yellowflash_db;

	debounce DB0(
		.s(rst),
		.s_db(rst_db),
		.clk(clk)
	);
	
	onepulse OP0(
		.s(rst_db),
		.s_op(rst_op),
		.clk(clk)
	);
	debounce DB1(
		.s(forward),
		.s_db(forward_db),
		.clk(clk)
	);
	
	onepulse OP1(
		.s(forward_db),
		.s_op(forward_op),
		.clk(clk)
	);
	debounce DB2(
		.s(backward),
		.s_db(backward_db),
		.clk(clk)
	);
	
	onepulse OP2(
		.s(backward_db),
		.s_op(backward_op),
		.clk(clk)
	);
	debounce DB3(
		.s(left),
		.s_db(left_db),
		.clk(clk)
	);
	onepulse OP3(
		.s(left_db),
		.s_op(left_op),
		.clk(clk)
	);
	debounce DB4(
		.s(right),
		.s_db(right_db),
		.clk(clk)
	);
	onepulse OP4(
		.s(right_db),
		.s_op(right_op),
		.clk(clk)
	);
	debounce DB5(
		.s(auto_mode_signal),
		.s_db(auto_mode_signal_db),
		.clk(clk)
	);
	onepulse OP5(
		.s(auto_mode_signal_db),
		.s_op(auto_mode_signal_op),
		.clk(clk)
	);
	debounce DB6(
		.s(dance_mode_signal),
		.s_db(dance_mode_signal_db),
		.clk(clk)
	);
	onepulse OP6(
		.s(dance_mode_signal_db),
		.s_op(dance_mode_signal_op),
		.clk(clk)
	);
	debounce DB7(
		.s(LED_shutdown),
		.s_db(LED_shutdown_db),
		.clk(clk)
	);
	onepulse OP7(
		.s(LED_shutdown_db),
		.s_op(LED_shutdown_op),
		.clk(clk)
	);
	debounce DB8(
		.s(LED_headlight),
		.s_db(LED_headlight_db),
		.clk(clk)
	);
	onepulse OP8(
		.s(LED_headlight_db),
		.s_op(LED_headlight_op),
		.clk(clk)
	);
	debounce DB9(
		.s(LED_yellowflash),
		.s_db(LED_yellowflash_db),
		.clk(clk)
	);
	onepulse OP9(
		.s(LED_yellowflash_db),
		.s_op(LED_yellowflash_op),
		.clk(clk)
	);
	
endmodule

module onepulse(s, s_op, clk);
	input s, clk;
	output reg s_op;
	reg s_delay;
	always@(posedge clk)begin
		s_op <= s&(!s_delay);
		s_delay <= s;
	end
endmodule

module debounce(s, s_db, clk);
	input s, clk;
	output s_db;
	reg [3:0] DFF;
	
	always@(posedge clk)begin
		DFF[3:1] <= DFF[2:0];
		DFF[0] <= s;
	end
	assign s_db = (DFF == 4'b1111)? 1'b1 : 1'b0;
endmodule