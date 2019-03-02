module musicbox(clk, reset, ibeatNum, beatFreq, music_out);
	input clk;
	input reset;
	output [9:0] ibeatNum;
	output beatFreq;
	output [2:0]music_out;
	
	parameter BEAT_FREQ = 32'd16;	//one beat = 0.00625sec
	parameter DUTY_BEST = 10'd512;	//duty cycle = 50%

	wire [31:0] tone, beat;
	wire freq1, freq2, music;
	assign music = (clk == 1'b1)? freq2 : freq1;
	assign music_out = {music, 1'b1, 1'b1}; //music, gain, turn_on.
	
	PWM_gen PG0(
		.clk(clk), 
	    .reset(reset),
	    .freq(BEAT_FREQ),
	    .duty(DUTY_BEST), 
		.PWM(beatFreq)
	);
	
	player_control PC0(
		.clk(beatFreq),
		.reset(reset),
    	.ibeat(ibeatNum)
	);
		
	music MS0(
		.ibeatNum(ibeatNum),
		.tone(tone),
		.beat(beat)
	);

	PWM_gen PG1( 
		.clk(clk), 
		.reset(reset), 
		.freq(tone),
		.duty(DUTY_BEST), 
		.PWM(freq1)
	);
	PWM_gen PG2( 
		.clk(clk), 
		.reset(reset), 
		.freq(beat),
		.duty(DUTY_BEST), 
		.PWM(freq2)
	);
	
endmodule

module player_control(clk, reset, ibeat);	
	input clk;
	input reset;
	output reg [9:0] ibeat;
	parameter BEATLEAGTH = 660;

	always @(posedge clk) begin
		if (reset==1'b1)begin
			ibeat <= 10'd0;
		end
		else begin
			if(ibeat == BEATLEAGTH) ibeat <= 10'd0;
			else ibeat <= ibeat + 1;
		end
	end

endmodule