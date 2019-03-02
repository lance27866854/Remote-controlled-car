module TOP(sig, clk, reset, Motor_move_out, Motor_rotate_out, car_break_signal,
			LED_out, music_out, AN, SEG, LED, init_rotate_signal, left_line_signal, right_line_signal);
	input sig, clk, reset;
	input car_break_signal;
	input init_rotate_signal;
	input left_line_signal;
	input right_line_signal;
	
	output [2:0] Motor_move_out; // DC motor, [2]: front, [1]: back, [0]: PWM
    output [3:0] Motor_rotate_out; // Stepper motor
    output [4:0] LED_out;
    output [2:0] music_out;
	output [3:0]AN;
	output [6:0]SEG;
	output [15:0]LED;
	
	wire [1:0] debug_LED;
	wire [16:0] sig_out;
	wire [15:0] NS_LED;
	
	NECIR_interface NI0(
		.clk(clk),
		.reset(reset),
		.LED(NS_LED),
		.sig(sig),
		.AN(AN),
		.SEG(SEG),
		.sig_out(sig_out)
	);
	
	Car_interface CI0(
		.clk(clk),
		.rst(sig_out[6]),
		.forward(sig_out[5]),
		.backward(sig_out[4]),
		.left(sig_out[3]),
		.right(sig_out[2]),
		.car_break_signal(car_break_signal),
		.init_rotate_signal(init_rotate_signal),
		.left_line_signal(left_line_signal),
		.right_line_signal(right_line_signal),
		.auto_mode_signal(sig_out[1]),
		.dance_mode_signal(sig_out[0]),
		.LED_shutdown(sig_out[16]),
		.LED_headlight(sig_out[15]),
		.LED_yellowflash(sig_out[14]),
		.Motor_move_out(Motor_move_out),
		.Motor_rotate_out(Motor_rotate_out),
		.LED_out(LED_out),
		.music_out(music_out),
		.debug_LED(debug_LED)
    );
	
	assign LED = {14'd0, debug_LED};
	
endmodule