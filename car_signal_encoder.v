module car_signal_encoder(clk, reset, forward, backward, left, right,
	car_break_signal, init_rotate_signal, auto_mode_signal, dance_mode_signal,
	left_line_signal, right_line_signal, ibeatNum, out_mode, car_state, below_reset);
	input clk, reset;
	input forward;
    input backward;
    input left;
	input right;
	input car_break_signal;
	input init_rotate_signal;
	input auto_mode_signal;
	input dance_mode_signal;
	input left_line_signal;
	input right_line_signal;
	input [9:0]ibeatNum;
	output [3:0]out_mode;
	reg [3:0]mode;
	output [1:0]car_state;
	output reg below_reset;
	/*
	car_signal_decoder:
	---------------------------------
	protocol defined here: (only for car, the first two bits for moving, and the last two bits for rotating.)
	
	<1> MOVE_FORWARD 4'b1000
	<2> MOVE_BACKWARD 4'b0100
	<3> TURN_RIGHT 4'b0001
	<4> TURN_LEFT 4'b0010
	<5> STOP 4'b0000
	<6> ...
	(e.g. 4'b1010->FORWARD_LEFT)
	
	note: If you are going to design an additional top module,
	please follow this. If you find that there isn't the control signal you need,
	please add the new control signal symbol at "..." .
	---------------------------------
	*/
	parameter INIT = 2'b00;
	parameter NC = 2'b01;
	parameter AP = 2'b10;
	parameter DM = 2'b11;
	parameter ROT_LFT = 29'd460_000_000;
	parameter ROT_MID = 29'd230_000_000;
	parameter ROT_RIT = 29'd0;
	
	wire [3:0]init_mode, ap_mode, nc_mode, dm_mode;
	reg next_below_reset;
	reg [1:0]state, next_state;
	reg [28:0]rotate_cnt, next_rotate_cnt;
	wire [28:0]rotate_renew;
	
	assign car_state = state;
	
	always@(posedge clk)begin
		if(reset == 1'b1)begin
			state <= INIT;
			below_reset <= 1'b1;
			rotate_cnt <= ROT_MID;
		end
		else begin
			state <= next_state;
			below_reset <= next_below_reset;
			rotate_cnt <= next_rotate_cnt;
		end
	end
	
	always@(*)begin
		case(state)
			INIT: next_state = (init_mode == 4'b0000)? NC : INIT;
			NC: next_state = (auto_mode_signal == 1'b1)? AP : (dance_mode_signal == 1'b1)? DM : NC;
			AP: next_state = (auto_mode_signal == 1'b1)? NC : (dance_mode_signal == 1'b1)? DM : AP;
			DM: next_state = (dance_mode_signal == 1'b1)? NC : (auto_mode_signal == 1'b1)? AP : DM;
			default: next_state = NC;
		endcase
	end
	always@(*)begin
		case(state)
			INIT: next_below_reset = (init_mode == 4'b0000)? 1'b1 : 1'b0;
			NC: next_below_reset = (auto_mode_signal == 1'b1||dance_mode_signal == 1'b1)? 1'b1 : 1'b0;
			AP: next_below_reset = (auto_mode_signal == 1'b1||dance_mode_signal == 1'b1)? 1'b1 : 1'b0;
			DM: next_below_reset = (dance_mode_signal == 1'b1||auto_mode_signal == 1'b1)? 1'b1 : 1'b0;
			default: next_below_reset = 1'b0;
		endcase
	end
	always@(*)begin
		if(state == INIT) begin
			next_rotate_cnt = ROT_MID;
		end
		else begin
			next_rotate_cnt = (mode[1:0] == 2'b00||mode[1:0] == 2'b11)? rotate_cnt : rotate_renew;
		end
	end
	assign rotate_renew = (mode[1:0] == 2'b10 && rotate_cnt < ROT_LFT)? rotate_cnt+1 : (mode[1:0] == 2'b01 && rotate_cnt > ROT_RIT)? rotate_cnt-1 : rotate_cnt;
	assign out_mode = (rotate_cnt == ROT_LFT || rotate_cnt == ROT_RIT)? {mode[3:2], 2'b00} : mode;
	
	Initial_move_control IMC0(
		.clk(clk),
		.reset(below_reset),
		.signal(init_rotate_signal),
		.mode(init_mode)
	);
	
	auto_pilot AP0(=
		.left_signal(left_line_signal),
		.right_signal(right_line_signal),
		.mode(ap_mode)
	);
	
	normal_control NC0(
		.clk(clk),
		.reset(below_reset),
		.forward(forward),
		.backward(backward),
		.left(left),
		.right(right),
		.break_signal(car_break_signal),
		.mode(nc_mode)
	);
	
	dance_mode DM0(
		.ibeatNum(ibeatNum), 
		.mode(dm_mode)
	);
	
	always@(*)begin
		case(state)
			INIT: mode = init_mode;
			NC: mode = nc_mode;
			AP: mode = ap_mode;
			DM: mode = dm_mode;
			default: mode = nc_mode;
		endcase
	end
	
endmodule

module Initial_move_control(clk, reset, signal, mode);
	input clk, reset, signal;
	output [3:0]mode;
	
	//output state.
	parameter TURN_RIGHT = 4'b0001;
	parameter TURN_LEFT = 4'b0010;
	parameter STOP = 4'b0000;
	
	//time required to rotate the motor to central place.
	parameter TIME = 29'd215_000_000;

	reg [3:0]state, next_state;
	reg [28:0]count, next_count;
	
	always@(posedge clk)begin
		if(reset)begin
			state <= TURN_RIGHT;
			count <= 29'd0;
		end
		else begin
			state <= next_state;
			count <= next_count;
		end
	end
	
	always@(*)begin
		case(state)
			TURN_RIGHT: begin
				next_state = (signal == 1'b0)? TURN_LEFT : TURN_RIGHT;
				next_count = 29'd0;
			end
			TURN_LEFT: begin
				next_state = (count == TIME)? STOP : TURN_LEFT ;
				next_count = (count == TIME)? 29'd0 : count + 29'd1;
			end
			default:begin
				next_state = STOP;
				next_count = 29'd0;			
			end
		endcase
	end
	
	assign mode = state;
	
endmodule

module auto_pilot(left_signal, right_signal, mode);
	input left_signal, right_signal;
	output reg [3:0]mode;
	
	wire [1:0]state;
	
	assign state = {left_signal, right_signal};
	
	always@(*)begin
		case(state)
			2'b00: mode = 4'b0000;
			2'b10: mode = 4'b1010;
			2'b01: mode = 4'b1001;
			2'b11: mode = 4'b1000;
		endcase
	end
	
endmodule

module normal_control(clk, reset, forward, backward, left, right, break_signal, mode);
	input clk, reset;
	input forward;
    input backward;
    input left;
	input right;
	input break_signal;
	output [3:0]mode;
	
	parameter FORWARD = 2'b10;
	parameter BACKWARD = 2'b01;
	parameter LEFT = 2'b10;
    parameter RIGHT = 2'b01;
	parameter STOP = 2'b00;
	
	reg [1:0]state_motor1, next_state_motor1, state_motor2, next_state_motor2;
	wire [1:0]motor_move1;
	
	assign motor_move1 = (break_signal == 1'b0)? 2'b00 : state_motor1;
	
	always@(posedge clk)begin
		if(reset == 1'b1)begin
			state_motor1 <= STOP;
			state_motor2 <= STOP;
		end
		else begin
			state_motor1 <= next_state_motor1;
			state_motor2 <= next_state_motor2;
		end
	end
	
	always@(*)begin
		case(state_motor1)
			STOP: next_state_motor1 = (forward == 1'b1)? FORWARD : (backward == 1'b1)? BACKWARD : STOP;//stop
			BACKWARD: next_state_motor1 = (forward == 1'b1)? FORWARD : (backward == 1'b1)? STOP : BACKWARD;//backward
			FORWARD: next_state_motor1 = (backward == 1'b1)? BACKWARD : (forward == 1'b1)? STOP : FORWARD;//forward
			default: next_state_motor1 = STOP;
		endcase
	end
	
	always@(*)begin
		case(state_motor2)
			STOP: next_state_motor2 = (right == 1'b1)? RIGHT : (left == 1'b1)? LEFT : STOP;//stop
			LEFT: next_state_motor2 = (right == 1'b1)? RIGHT : (left == 1'b1)? STOP : LEFT;//left
			RIGHT: next_state_motor2 = (left == 1'b1)? LEFT : (right == 1'b1)? STOP : RIGHT;//right
			default: next_state_motor2 = STOP;
		endcase
	end
	
	assign mode = {motor_move1, state_motor2};
	
endmodule

module dance_mode(ibeatNum, mode);
	input [9:0]ibeatNum;
	output [3:0]mode;
	
	wire [6:0]movementNum;
	reg [3:0]movement;
	assign movementNum = ibeatNum>>3;
	
	always@(*)begin
		case(movementNum)
			//1
			7'd0: movement = 4'b1010;//forward, left
			7'd1: movement = 4'b0101;//backward, right
			7'd2: movement = 4'b0110;//backward, left
			7'd3: movement = 4'b1001;//forward, right
			//2
			7'd4: movement = 4'b1001;//forward, right
			7'd5: movement = 4'b0110;//backward, left
			7'd6: movement = 4'b0101;//backward, right
			7'd7: movement = 4'b1010;//forward, left
			//3
			7'd8: movement = 4'b1010;//forward, left
			7'd9: movement = 4'b0101;//backward, right
			7'd10: movement = 4'b0110;//backward, left
			7'd11: movement = 4'b1001;//forward, right
			//4
			7'd12: movement = 4'b1001;//forward, right
			7'd13: movement = 4'b0110;//backward, left
			7'd14: movement = 4'b0101;//backward, right
			7'd15: movement = 4'b1010;//forward, left
			//repeat
			//5
			7'd16: movement = 4'b1010;//forward, left
			7'd17: movement = 4'b0101;//backward, right
			7'd18: movement = 4'b0110;//backward, left
			7'd19: movement = 4'b1001;//forward, right
			//6
			7'd20: movement = 4'b1001;//forward, right
			7'd21: movement = 4'b0110;//backward, left
			7'd22: movement = 4'b0101;//backward, right
			7'd23: movement = 4'b1010;//forward, left
			//7
			7'd24: movement = 4'b1010;//forward, left
			7'd25: movement = 4'b0101;//backward, right
			7'd26: movement = 4'b0110;//backward, left
			7'd27: movement = 4'b1001;//forward, right
			//8
			7'd28: movement = 4'b1001;//forward, right
			7'd29: movement = 4'b0110;//backward, left
			7'd30: movement = 4'b0101;//backward, right
			7'd31: movement = 4'b1010;//forward, left
			//Chorus
			//9
			7'd32: movement = 4'b1000;//forward
			7'd33: movement = 4'b0000;//stop
			7'd34: movement = 4'b1000;//forward
			7'd35: movement = 4'b0000;//stop
			//10
			7'd36: movement = 4'b1000;//forward
			7'd37: movement = 4'b0000;//stop
			7'd38: movement = 4'b1000;//forward
			7'd39: movement = 4'b0000;//stop
			//11
			7'd40: movement = 4'b0100;//backward
			7'd41: movement = 4'b0000;//stop
			7'd42: movement = 4'b0100;//backward
			7'd43: movement = 4'b0000;//stop
			//12
			7'd44: movement = 4'b1000;//forward
			7'd45: movement = 4'b0100;//backward
			7'd46: movement = 4'b1000;//forward
			7'd47: movement = 4'b0100;//backward
			//13
			7'd48: movement = 4'b1000;//forward
			7'd49: movement = 4'b0100;//backward
			7'd48: movement = 4'b0000;//stop
			7'd49: movement = 4'b0000;//stop
			//14
			7'd50: movement = 4'b1000;//forward
			7'd51: movement = 4'b0000;//stop
			7'd52: movement = 4'b1000;//forward
			7'd53: movement = 4'b0000;//stop
			//15
			7'd54: movement = 4'b1000;//forward
			7'd55: movement = 4'b0000;//stop
			7'd56: movement = 4'b1000;//forward
			7'd57: movement = 4'b0000;//stop
			//16
			7'd58: movement = 4'b0100;//backward
			7'd59: movement = 4'b0000;//stop
			7'd60: movement = 4'b0100;//backward
			7'd61: movement = 4'b0000;//stop
			//17
			7'd62: movement = 4'b0100;//backward
			7'd63: movement = 4'b0000;//stop
			7'd64: movement = 4'b0100;//backward
			7'd65: movement = 4'b0000;//stop
			//18
			7'd66: movement = 4'b1000;//forward
			7'd67: movement = 4'b0100;//backward
			7'd68: movement = 4'b1000;//forward
			7'd69: movement = 4'b0100;//backward
			//19
			7'd70: movement = 4'b1010;//forward, left
			7'd71: movement = 4'b0101;//backward, right
			7'd72: movement = 4'b0110;//backward, left
			7'd73: movement = 4'b1001;//forward, right
			//20
			7'd74: movement = 4'b1001;//forward, right
			7'd75: movement = 4'b0110;//backward, left
			7'd76: movement = 4'b0101;//backward, right
			7'd77: movement = 4'b1010;//forward, left
			//21
			7'd78: movement = 4'b1010;//forward, left
			7'd79: movement = 4'b0101;//backward, right
			7'd80: movement = 4'b0110;//backward, left
			7'd81: movement = 4'b1001;//forward, right
			default: movement = 4'b0000;//stop
		endcase
	end
	
	assign mode = movement;
	
endmodule