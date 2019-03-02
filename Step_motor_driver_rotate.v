`timescale 1ns / 1ps

module Step_motor_driver_rotate(
    input rst,
    input [1:0] rotate, // 10: turn right, 01: turn left, else go straight
    input clk,
    input en, // en == 1: car can move, en == 0: car should be static
    output reg [3:0] signal
    );

    localparam sig4 = 3'b001;
    localparam sig3 = 3'b011;
    localparam sig2 = 3'b010;
    localparam sig1 = 3'b110;
    localparam sig0 = 3'b000;
    reg [2 : 0] state, next_state;
    wire dont_rotate;
    wire dir;

    assign dont_rotate = (en == 1'b0 || rotate == 2'b00 || rotate == 2'b11) ? 1'b1 : 1'b0;
    assign dir = (rotate == 2'b01) ? 1'b1 : (rotate == 2'b10) ? 1'b0 : 1'b0;

    always@(posedge clk, posedge rst) begin
        if ( rst == 1'b1 ) state <= sig0;
        else state <= next_state;
    end

    always@(posedge clk) begin
        if ( state == sig4 ) signal <= 4'b1100;
        else if ( state == sig3 ) signal <= 4'b0110;
        else if ( state == sig2 ) signal <= 4'b0011;
        else if ( state == sig1 ) signal <= 4'b1001;
        else signal <= 4'b0000;
    end

    // run when the present state, direction or enable signals change.
    always @(state, dir, dont_rotate) begin
        case(state)
        // If the state is sig4, the state where the fourth signal is held high. 
        sig4: begin
            if ( !dir && !dont_rotate ) next_state = sig3;
            else if ( dir && !dont_rotate ) next_state = sig1;
            else next_state = sig0;
        end 
        sig3: begin
            if ( !dir && !dont_rotate ) next_state = sig2;
            else if ( dir && !dont_rotate ) next_state = sig4;
            else next_state = sig0;
        end 
        sig2: begin
            if ( !dir && !dont_rotate ) next_state = sig1;
            else if ( dir && !dont_rotate ) next_state = sig3;
            else next_state = sig0;
        end 
        sig1: begin
            if ( !dir && !dont_rotate ) next_state = sig4;
            else if ( dir && !dont_rotate ) next_state = sig2;
            else next_state = sig0;
        end
        sig0: begin
            if ( !dont_rotate ) next_state = sig1;
            else next_state = sig0;
        end
        default:
            next_state = sig0; 
        endcase
    end 
endmodule
