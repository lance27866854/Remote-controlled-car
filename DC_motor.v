module DC_motor(rst, dir, clk, outFT, outBK, outPWM);
    input rst, clk;
    input [1 : 0] dir;
    output outFT, outBK;
    output reg outPWM;
    reg [3: 0] cnt_ten, cnt_scale;
    wire [3 : 0] next_cnt_ten, next_cnt_scale;
    reg [15 : 0] adj;
    wire [15 : 0] next_adj;
    wire detect_adj, isStop;

	// <1> MOVE_FORWARD 4'b1000
	// <2> MOVE_BACKWARD 4'b0100
	// <3> TURN_RIGHT 4'b0001
	// <4> TURN_LEFT 4'b0010
	// <5> STOP 4'b0000
	// <6> ...
	// (e.g. 4'b1010->FORWARD_LEFT)

    assign outFT = ( rst == 1'b1 ) ? 1'b0 : ( dir == 2'b10 ) ? 1'b1 : 1'b0; // Forward
    assign outBK = ( rst == 1'b1 ) ? 1'b0 : ( dir == 2'b01 ) ? 1'b1 : 1'b0; // Backward
    always@(*) begin
        if( rst || isStop ) outPWM = 1'b0;
        else begin
            if( cnt_ten < cnt_scale ) outPWM = 1'b1;
            else outPWM = 1'b0;
        end
    end

    always@(posedge clk) begin
        if( rst == 1'b1 || isStop ) begin
            cnt_ten <= 4'd0;
            cnt_scale <= 4'd4; // from 5 to 10 ( 50% one + 50 % zero -> 100% one + 0% zero )
            adj <= 16'd0;
        end else begin
            cnt_ten <= next_cnt_ten;
            cnt_scale <= next_cnt_scale;
            adj <= next_adj;
        end
    end

    assign isStop = ( dir == 2'b00 || dir == 2'b11 ) ? 1'b1 : 1'b0;
    assign detect_adj = ( rst || isStop ) ? 1'b0 :
                        ( adj == 16'd2500 || adj == 16'd5000 || adj == 16'd7500 || adj == 16'd12500 || adj == 16'd17500 || adj == 16'd25000 ) ? 1'b1 : 1'b0;

    assign next_cnt_ten = ( rst || isStop ) ? 4'b0 : ( cnt_ten == 4'd9 ) ? 4'd0 : cnt_ten + 1'b1;
    assign next_cnt_scale = ( rst || isStop ) ? 4'd3 : ( detect_adj == 1'b1 && cnt_scale < 4'd10 ) ? cnt_scale + 1'b1 : cnt_scale;
    assign next_adj = ( rst || isStop ) ? 16'd0 : ( adj == 16'd39999 ) ? 16'd39999 : adj + 1'b1;
endmodule