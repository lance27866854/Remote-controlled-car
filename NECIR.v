module NECIR_interface(clk, reset, LED, sig, AN, SEG, sig_out);
	input clk, reset;
	input sig;
	output [15:0]LED;
	output [3:0]AN;
	output reg[6:0]SEG;
	
	output [16:0]sig_out;
	wire [2:0]state;
	
	NECIR_decode DD0(
		.clk(clk),
		.rst(reset),
		.sig(sig),
		.state(state),
		.sig_out(sig_out)
	);
	assign AN = 4'b1110;
	assign LED = sig_out[16:1];
	
	always@(*)begin
		case(state)
			3'd0: SEG = 7'b0001000;
			3'd1: SEG = 7'b1011011;
			3'd2: SEG = 7'b0100010;
			3'd3: SEG = 7'b0010010;
			3'd4: SEG = 7'b1010001;
			3'd5: SEG = 7'b0010100;
			3'd6: SEG = 7'b0000100;
			3'd7: SEG = 7'b1011010;
		endcase
	end
	
endmodule

module NECIR_decode(clk, rst, sig, sig_out, state);
	///state parameter.
    parameter Waiting = 3'b000;
    parameter lderCode1 = 3'b001;
	parameter lderCode2 = 3'b010;
    parameter AddressCode = 3'b011;
    parameter CommandCode = 3'b100;
    parameter StopBit = 3'b101;
	parameter Debug = 3'b110; 
	///inacurracy tolerance.
	parameter lder_AVG1 = 16'd9000;
	parameter lder_AVG2 = 16'd4500;
	parameter lder_ERROR = 16'd128;
	///I/O.
    input clk, sig, rst;
	output [16:0]sig_out;
	///DFF.
	output reg [2:0] state;
	reg [2:0] next_state;
    reg [15:0] cnt, next_cnt;
	reg [15:0]decode_num, next_decode_num;
	reg below_reset, next_below_reset;
	///condition wires.
	wire clk_d;
	//lder
	wire [15:0]lder_up_lim, lder_down_lim;
	wire lder_inRange;
	assign lder_up_lim = (state == lderCode1)? lder_AVG1 + lder_ERROR : lder_AVG2 + lder_ERROR;
	assign lder_down_lim = (state == lderCode1)? lder_AVG1 - lder_ERROR : lder_AVG2 - lder_ERROR;
	assign lder_inRange = (cnt > lder_down_lim && cnt < lder_up_lim)? 1'b1 : 1'b0;
	//Decoding
	wire det_done0, det_error0;
	wire det_done1, det_error1;
	wire done, error;
	wire [15:0]renew_decode_num;
	wire addr_error;
	assign renew_decode_num = {decode_num[14:0], det_done1} ;
	assign done = det_done0|det_done1;
	assign addr_error = (state == AddressCode && done && cnt == 16'd15 && renew_decode_num != 16'd511)? 1'b0 : 1'b1;
	
	///Machines.
	Clk_div CD0(
		.clk(clk),
		.clk_d(clk_d)
	);
	detect_zero DZ0(
		.clk(clk_d),
		.reset(below_reset),
		.sig(sig),
		.done(det_done0),
		.error(det_error0)
	);
	detect_one DO0(
		.clk(clk_d),
		.reset(below_reset),
		.sig(sig),
		.done(det_done1),
		.error(det_error1)
	);
	signal_control SC0(
		.state(state),
		.decode_num(decode_num),
		.sig_out(sig_out)
	);
	
    always@(posedge clk_d) begin
        if( rst ) begin
            state <= Waiting;
            cnt <= 16'd0;
			below_reset <= 1'b0;
			decode_num <= 16'd0;
        end else begin
            state <= next_state;
            cnt <= next_cnt;
			below_reset <= next_below_reset;
			decode_num <= next_decode_num;
        end
    end

    always@(*) begin
        case(state)
            Waiting: begin
                next_state = (sig == 1'b0) ? lderCode1 : Waiting;
                next_cnt = 16'd0;
				next_below_reset = 1'b0;
				next_decode_num = 16'd0;
            end
            lderCode1: begin
                next_state = (sig == 1'b0)? lderCode1 : (lder_inRange == 1'b1)? lderCode2 : Waiting;
                next_cnt = (sig == 1'b0)? cnt+1 : 16'd0;
				next_below_reset = 1'b0;
				next_decode_num = 16'd0;
            end
			lderCode2: begin
                next_state = (sig == 1'b1)? lderCode2 : (lder_inRange == 1'b1)? AddressCode : Waiting;
                next_cnt = (sig == 1'b1)? cnt+1 : 16'd0;
				next_below_reset = (sig == 1'b0 && lder_inRange == 1'b1)? 1'b1 : 1'b0;
				next_decode_num = 16'd0;
            end
			AddressCode: begin //00FF
                next_state = (done && cnt == 16'd15)? CommandCode : (error)? Waiting : AddressCode;
                next_cnt = (!done)? cnt : (cnt == 16'd15)? 16'd0 : cnt+1;
				next_below_reset = (done)? 1'b1 : 1'b0;
				next_decode_num = (done)? {decode_num[14:0], det_done1} : decode_num;
            end
			CommandCode: begin
                next_state = (done && cnt == 16'd15)? StopBit : CommandCode;
                next_cnt = (!done)? cnt : (cnt == 16'd15)? 16'd0 : cnt+1;
				next_below_reset = (done)? 1'b1 : 1'b0;
				next_decode_num = (done)? renew_decode_num : decode_num;
            end
            StopBit: begin
                next_state = (sig == 1'b0)? StopBit : Waiting;
                next_cnt = 16'd0;
				next_below_reset = 1'b0;
				next_decode_num = decode_num;
            end
			default: begin
				next_state = state;
                next_cnt = 16'd0;
				next_below_reset = 1'b0;
				next_decode_num = decode_num;
			end
        endcase
    end
endmodule

module signal_control(state, decode_num, sig_out);
	input [15:0]decode_num;
	input [2:0]state;
	output [16:0]sig_out;	
	reg [16:0]sig;
	
	always@(*)begin
		case(decode_num)
			16'h9867: sig = 17'b1000_0000_0000_00000; // 0
            16'hA25D: sig = 17'b0100_0000_0000_00000; // 1
            16'h629D: sig = 17'b0010_0000_0000_00000; // 2
            16'hE21D: sig = 17'b0001_0000_0000_00000; // 3
            16'h22DD: sig = 17'b0000_1000_0000_00000; // 4
            16'h02FD: sig = 17'b0000_0100_0000_00000; // 5
            16'hC23D: sig = 17'b0000_0010_0000_00000; // 6
            16'hE01F: sig = 17'b0000_0001_0000_00000; // 7
            16'hA857: sig = 17'b0000_0000_1000_00000; // 8
            16'h906F: sig = 17'b0000_0000_0100_00000; // 9
            16'h38C7: sig = 17'b0000_0000_0010_00000; // ok
            16'h18E7: sig = 17'b0000_0000_0001_00000; // up
            16'h4AB5: sig = 17'b0000_0000_0000_10000; // down
            16'h10EF: sig = 17'b0000_0000_0000_01000; // left
            16'h5AA5: sig = 17'b0000_0000_0000_00100; // right
            16'h6897: sig = 17'b0000_0000_0000_00010; // '*' mark 
            16'hB04F: sig = 17'b0000_0000_0000_00001; // '#' mark
            default:  sig = 17'b0000_0000_0000_00000; // nothing or wrong signal
		endcase
	end
	
	assign sig_out = (state == 3'b101)? sig : 17'd0;

endmodule

module detect_one(clk, reset, sig, done, error);
	///state.
	parameter lderCode = 2'b00;
	parameter detectNum = 2'b01;
	parameter errorOccur = 2'b10;
	parameter successGet = 2'b11;
	///inacurracy tolerance.
	parameter lder_AVG = 11'd560;
	parameter lder_ERROR = 11'd64;
	parameter dect_AVG = 11'd1690;
	parameter dect_ERROR = 11'd128;
	
	///I/O.
	input clk, reset, sig;
	output done, error;
	//DFF
    reg [10:0] cnt, next_cnt;
	reg [1:0] state, next_state;
	///condition wires.
	//lderCode
	wire [10:0]lder_up_lim, lder_down_lim;
	wire lder_inRange;
	assign lder_up_lim = lder_AVG + lder_ERROR;
	assign lder_down_lim = lder_AVG - lder_ERROR;
	assign lder_inRange = (cnt > lder_down_lim && cnt < lder_up_lim)? 1'b1 : 1'b0;
	//detectNum
	wire [10:0]dect_up_lim, dect_down_lim;
	wire dect_inRange;
	assign dect_up_lim = dect_AVG + dect_ERROR;
	assign dect_down_lim = dect_AVG - dect_ERROR;
	assign dect_inRange = (cnt > dect_down_lim && cnt < dect_up_lim)? 1'b1 : 1'b0;
	
	wire err1, err2;
	
    always@(posedge clk) begin
        if(reset)begin
			cnt <= 11'd0;
			state <= lderCode;
		end
		else begin
			cnt <= next_cnt;
			state <= next_state;
		end
    end
	
	always@(*)begin
		case(state)
			lderCode:begin
				next_state = (sig == 1'b0)? lderCode : (lder_inRange == 1'b1)? detectNum : lderCode;
				next_cnt = (sig == 1'b0)? cnt+1 : 11'd0;
			end
			detectNum:begin
				next_state = (sig == 1'b1)? detectNum : lderCode;//(dect_inRange == 1'b1)? lderCode : errorOccur;
				next_cnt = (sig == 1'b1)? cnt+1 : 11'd0;
			end
		endcase
	end
	assign err1 = (state == lderCode && sig == 1'b1 && lder_inRange == 1'b0)? 1'b1 : 1'b0;
	assign err2 = (state == detectNum && sig == 1'b0 && lder_inRange == 1'b0)? 1'b1 : 1'b0;
	assign error = err1|err2;
	assign done = (state == detectNum && sig == 1'b0 && dect_inRange == 1'b1)? 1'b1 : 1'b0;
endmodule

module detect_zero(clk, reset, sig, done, error);
	///state.
	parameter lderCode = 2'b00;
	parameter detectNum = 2'b01;
	///inacurracy tolerance.
	parameter lder_AVG = 11'd560;
	parameter lder_ERROR = 11'd64;
	parameter dect_AVG = 11'd560;
	parameter dect_ERROR = 11'd64;
	
	///I/O.
	input clk, reset, sig;
	output done, error;
	//DFF
    reg [10:0] cnt, next_cnt;
	reg [1:0] state, next_state;
	///condition wires.
	//lderCode
	wire [10:0]lder_up_lim, lder_down_lim;
	wire lder_inRange;
	assign lder_up_lim = lder_AVG + lder_ERROR;
	assign lder_down_lim = lder_AVG - lder_ERROR;
	assign lder_inRange = (cnt > lder_down_lim && cnt < lder_up_lim)? 1'b1 : 1'b0;
	//detectNum
	wire [10:0]dect_up_lim, dect_down_lim;
	wire dect_inRange;
	assign dect_up_lim = dect_AVG + dect_ERROR;
	assign dect_down_lim = dect_AVG - dect_ERROR;
	assign dect_inRange = (cnt > dect_down_lim && cnt < dect_up_lim)? 1'b1 : 1'b0;
	
	wire err1, err2;
	
    always@(posedge clk) begin
        if(reset)begin
			cnt <= 11'd0;
			state <= lderCode;
		end
		else begin
			cnt <= next_cnt;
			state <= next_state;
		end
    end
	
	always@(*)begin
		case(state)
			lderCode:begin
				next_state = (sig == 1'b0)? lderCode : (lder_inRange == 1'b1)? detectNum : lderCode;
				next_cnt = (sig == 1'b0)? cnt+1 : 11'd0;
			end
			detectNum:begin
				next_state = (sig == 1'b1)? detectNum : lderCode;//(dect_inRange == 1'b1)? lderCode : errorOccur;
				next_cnt = (sig == 1'b1)? cnt+1 : 11'd0;
			end
		endcase
	end
	assign err1 = (state == lderCode && sig == 1'b1 && lder_inRange == 1'b0)? 1'b1 : 1'b0;
	assign err2 = (state == detectNum && sig == 1'b0 && lder_inRange == 1'b0)? 1'b1 : 1'b0;
	assign error = err1|err2;
	assign done = (state == detectNum && sig == 1'b0 && dect_inRange == 1'b1)? 1'b1 : 1'b0;
endmodule

module Clk_div(clk, clk_d); //div 100
    input clk;
    output clk_d;
	reg out, next_out;
    reg [6:0] cnt, next_cnt;

    always@(posedge clk)begin
        out <= next_out;
        cnt <= next_cnt;
    end
	
    always@(*) begin
        next_out = (cnt == 7'd49) ? ~out : out;
        next_cnt = (cnt == 7'd49) ? 7'd0 : cnt + 1'b1;
    end
	assign clk_d = out;
endmodule
