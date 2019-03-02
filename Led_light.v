module LED_light(
	input clk,
	input reset,
    input clk_sparkle,
    input shutdown,
    input headlight,
    input yellow_flash,
	input [3:0]car_mode,
	input [1:0]car_state,
	input [9:0]ibeatNum,
	input beatFreq,
	input below_reset,
    output [4:0]LED
);
    // LED[0]: middle front white * 2 & middle bottom red * 2 (keep lighting)
    // LED[1]: front blue * 4 (open manually)
    // LED[2]: bottom red * 4 (open automatically when stop or backup)
    // LED[3]: left yellow * 4 (open automatically when turning left || manually)
    // LED[4]: right yellow * 4 (open automatically when turning right || manually)
	
	// control the signal.
	// 0: turn off / 1: turn on
	reg all_IO, blue_LED_IO, yellow_LED_IO;
	wire next_all_IO, next_blue_LED_IO, next_yellow_LED_IO;
	reg sparkle_on, beat_on;
	wire next_sparkle_on, next_beat_on;
	
	wire back, stop, left, right;
	wire [4:0] NC_LED, DM_LED;
	
	//IO
	always@(posedge clk)begin
		if(reset)begin
			all_IO <= 1'b0;
			blue_LED_IO <= 1'b0;
			yellow_LED_IO <= 1'b0;
		end
		else begin
			all_IO <= next_all_IO;
			blue_LED_IO <= next_blue_LED_IO;
			yellow_LED_IO <= next_yellow_LED_IO;
		end
	end
	
	assign next_all_IO = (shutdown == 1'b1)? !all_IO : all_IO;
	assign next_blue_LED_IO = (headlight == 1'b1)? !blue_LED_IO : blue_LED_IO;
	assign next_yellow_LED_IO = (yellow_flash == 1'b1)? !yellow_LED_IO : yellow_LED_IO;
	
	//sparkle
	always@(posedge clk_sparkle)begin
		if(reset)begin
			sparkle_on <= 1'b0;
		end
		else begin
			sparkle_on <= next_sparkle_on;
		end
	end
	
	always@(posedge beatFreq)begin
		if(below_reset)begin
			beat_on <= 1'b0;
		end
		else begin
			beat_on <= next_beat_on;
		end
	end
	
	assign next_sparkle_on = !sparkle_on;
	assign next_beat_on = !beat_on;
	
	//status
	assign stop =  ( car_mode == 4'b0000 ) ? 1'b1 : 1'b0;
	assign back =  ( car_mode[3:2] == 2'b01 ) ? 1'b1 : 1'b0;
	assign left =  ( car_mode[1:0] == 2'b10 ) ? 1'b1 : 1'b0;
	assign right = ( car_mode[1:0] == 2'b01 ) ? 1'b1 : 1'b0;
	//NC
	assign NC_LED[0] = ( all_IO == 1'b0 ) ? 1'b0 : 1'b1;
	assign NC_LED[1] = ( all_IO == 1'b0 ) ? 1'b0 : ( blue_LED_IO == 1'b1) ? 1'b1 : 1'b0;
	assign NC_LED[2] = ( all_IO == 1'b0 ) ? 1'b0 : ( stop == 1'b1 || back == 1'b1 ) ? 1'b1 : 1'b0;
	assign NC_LED[3] = ( all_IO == 1'b0 ) ? 1'b0 : ( yellow_LED_IO == 1'b1 || left == 1'b1 ) ? sparkle_on : 1'b0;
	assign NC_LED[4] = ( all_IO == 1'b0 ) ? 1'b0 : ( yellow_LED_IO == 1'b1 || right == 1'b1 ) ? sparkle_on : 1'b0;
	//DM
	assign DM_LED = { beat_on, !beat_on, beat_on, !beat_on, beat_on };
	//choose according to car_state
	assign LED = ( car_state == 2'b11 ) ? DM_LED : NC_LED; // car_state == 2'b11 means dance mode
endmodule