`timescale 1ns / 1ps

module Clock_divisor(
    input clk,
    input rst,
    output reg Stp_motor_clk,
    output reg DC_motor_clk,
    output reg LED_clk
    );

    // The constant that defines the clock speed. Since the system clock is 100MHZ, 
    // define_speed = 100MHz / ( 2 * desired_clock_frequency )
    localparam STEPPER_SPEED = 26'd120000;
    localparam LED_SPEED = 26'd10000000;
    localparam DC_SPEED = 17'd10000; // DC motor needs 500 Hz but for producing PWM easily I need to divide 1 cycle into 10: 5000Hz
    //localparam LED_SPEED = 26'd50;
    
    reg [25:0] count_stepper;
    reg [25:0] count_LED;
    reg [13 : 0] count_DC;
    // ==================================================================================== //
    // motor
    always@(posedge clk, posedge rst) begin
        if (rst == 1'b1) count_stepper = 26'b0;
        else if (count_stepper < STEPPER_SPEED ) count_stepper = count_stepper + 1'b1;
        else count_stepper = 26'b0;
    end
    always@(posedge clk, posedge rst) begin
        if (rst == 1'b1) Stp_motor_clk = 1'b0; 
        else if ( count_stepper < STEPPER_SPEED ) Stp_motor_clk = Stp_motor_clk;
        else Stp_motor_clk = ~Stp_motor_clk;
    end
    // ==================================================================================== //
    always@(posedge clk, posedge rst) begin
        if(rst == 1'b1) count_DC = 14'd0;
        else if(count_DC < DC_SPEED) count_DC = count_DC + 1'b1;
        else count_DC = 14'd0;
    end
    always@(posedge clk, posedge rst) begin
        if(rst == 1'b1) DC_motor_clk = 1'b0;
        else if(count_DC < DC_SPEED) DC_motor_clk = DC_motor_clk;
        else DC_motor_clk = ~DC_motor_clk;
    end
    // ==================================================================================== //
    // LED
    always@(posedge clk, posedge rst) begin
        if (rst == 1'b1) count_LED = 26'b0;   
        else if (count_LED < LED_SPEED ) count_LED = count_LED + 1'b1;
        else count_LED = 26'b0;
    end
    always@(posedge clk, posedge rst) begin
        if (rst == 1'b1) LED_clk = 1'b0; 
        else if ( count_LED < LED_SPEED ) LED_clk = LED_clk;
        else LED_clk = ~LED_clk;
    end
    // ==================================================================================== //
endmodule
