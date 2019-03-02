`timescale 1ns / 1ps
module Car_interface(
    input clk,
    input rst,
	input forward,
    input backward,
    input left,
	input right,
	input car_break_signal,
	input init_rotate_signal,
	input left_line_signal,
	input right_line_signal,
	input auto_mode_signal,
	input dance_mode_signal,
	input LED_shutdown,
    input LED_headlight,
    input LED_yellowflash,
    output [2:0] Motor_move_out, // DC motor, [2]: front, [1]: back, [0]: PWM
    output [3:0] Motor_rotate_out, // Stepper motor
    output [4:0] LED_out,
    output [2:0] music_out,
	output [1:0] debug_LED
    );
    
	wire clk_stepper_motor, clk_DC_motor, clk_LED;
	wire [3:0]car_mode;
	wire rst_op, forward_op, backward_op, left_op, right_op, auto_mode_signal_op, dance_mode_signal_op;
	wire LED_shutdown_op, LED_headlight_op, LED_yellowflash_op;
	wire [9:0]ibeatNum;
	wire [1:0]car_state;
	wire beatFreq;
	wire below_reset;
	
	assign debug_LED = car_state;
	
	car_signal_encoder CSI0(
		.clk(clk),
		.reset(rst_op),
		.forward(forward_op),
		.backward(backward_op),
		.left(left_op),
		.right(right_op),
		.car_break_signal(car_break_signal),
		.init_rotate_signal(init_rotate_signal),
		.auto_mode_signal(auto_mode_signal_op),
		.dance_mode_signal(dance_mode_signal_op),
		.left_line_signal(left_line_signal),
		.right_line_signal(right_line_signal),
		.ibeatNum(ibeatNum),
		.out_mode(car_mode),
		.car_state(car_state),
		.below_reset(below_reset)
	);
	
	signal_op SDB0(
		.clk(clk),
		.rst(rst),
		.forward(forward),
		.backward(backward),
		.left(left),
		.right(right),
		.auto_mode_signal(auto_mode_signal),
		.dance_mode_signal(dance_mode_signal),
		.LED_shutdown(LED_shutdown),
		.LED_headlight(LED_headlight),
		.LED_yellowflash(LED_yellowflash),
		.rst_op(rst_op),
		.forward_op(forward_op),
		.backward_op(backward_op),
		.left_op(left_op),
		.right_op(right_op),
		.auto_mode_signal_op(auto_mode_signal_op),
		.dance_mode_signal_op(dance_mode_signal_op),
		.LED_shutdown_op(LED_shutdown_op),
		.LED_headlight_op(LED_headlight_op),
		.LED_yellowflash_op(LED_yellowflash_op)
	);
		
    Clock_divisor clock_Div(
        .clk(clk),
        .rst(rst),
        .Stp_motor_clk(clk_stepper_motor),
		.DC_motor_clk(clk_DC_motor),
        .LED_clk(clk_LED)
    );

	DC_motor rear_wheel(
		.rst(rst),
		.dir(car_mode[3:2]),
		.clk(clk_DC_motor),
		.outFT(Motor_move_out[2]), // It should connect with In1 on driver
		.outBK(Motor_move_out[1]), // It should connect with In2 on driver
		.outPWM(Motor_move_out[0])
	);

    Step_motor_driver_rotate front_wheel(
        .rst(rst),
        .rotate(car_mode[1:0]),
        .clk(clk_stepper_motor),
        .en(1'b1),
        .signal(Motor_rotate_out)
    );
	
	musicbox mus(
        .clk(clk), 
        .reset(rst),
		.ibeatNum(ibeatNum),
		.beatFreq(beatFreq),
		.music_out(music_out)
	);

    LED_light(
		.clk(clk),
		.reset(rst),
		.clk_sparkle(clk_LED),
		.shutdown(LED_shutdown),
		.headlight(LED_headlight),
		.yellow_flash(LED_yellowflash),
		.car_mode(car_mode),
		.car_state(car_state),
		.ibeatNum(ibeatNum),
		.beatFreq(beatFreq),
		.below_reset(below_reset),
		.LED(LED_out)
	);

endmodule