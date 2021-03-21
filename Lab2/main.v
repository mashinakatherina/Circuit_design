`timescale 1ns / 1ps

module main(
input clk_i,
input rst_i,
input [7:0] a_bi,
input [7:0] b_bi,
input start_i,
output busy_o,
output [23:0] y_bo);

localparam IDLE = 2'b00;
localparam WAIT_MULT = 2'b01;
localparam WAIT_MULT_1 = 2'b10;
localparam WAIT_SQRT = 2'b11;
    
reg [1:0]state;
reg [7:0] a, b;
reg s_i;
wire [23:0] a_cube1;
//wire [16:0] square_sum;
//reg [7:0] sqrt;
wire [7:0] result;
reg [23:0] answer;    
wire a_wait, sqrt_wait;
    
reg start_multiplying;
reg start_sqrt;

sqrt sqrt_calc (.clk_i(clk_i), .rst_i(rst_i),
                .x_bi (b_bi), .start_i(start_sqrt), 
                .busy_o(sqrt_wait), .y_bo(result));


mult multip (.clk_i(clk_i), .rst_i(rst_i), 
             .a_bi(a), .b_bi(a),
             .start_i(start_multiplying), 
             .busy_o(a_wait), .y_bo(a_cube1));

initial begin
answer <= 0;
state <= IDLE;
start_multiplying <= 0;
start_sqrt <= 0;
end
             
assign busy_o = (state > 0);
assign y_bo = answer;
//assign s_i = start_i = s_;

always @ (posedge clk_i)
    if (rst_i) begin
        answer <= 0;
       // start_multiplying <= 0;
        // start_sqrt <= 0;
        a <= a_bi;
        b <= b_bi;
        state <= IDLE;
    end else begin
        case (state)
            IDLE:
            if(start_i)
                begin    
                    start_multiplying <=1; 
                    answer <= 0;
                    state <= WAIT_MULT;
                end
            WAIT_MULT:
                begin 
                    start_multiplying <= 0;
                    if (!a_wait) begin
                        answer <= answer + a_cube1;
                        //answer <= 124;
                        //answer <= a_cube;
                        state <= WAIT_MULT_1;
                       start_multiplying <= 1;
                     // a_wait <= 0;
                    end
                 end
            WAIT_MULT_1:
            begin 
                    start_multiplying <= 0;
                    //if (!a_wait) 
                    begin
                        answer <= answer  + a_cube1;
                        //answer <= a_cube;
                        //start_sqrt <= 1;
                        //answer <=125;
                        state <= WAIT_SQRT;
                        start_sqrt <= 1;
                    end
                 end
             WAIT_SQRT:
                begin
                    start_sqrt <= 0;
                    if (!sqrt_wait) 
                    begin
                        //answer <= result;
                        //answer <= 126;
                        answer <= answer + result;
                       // s_i <= 0;
                      // start_sqrt <= 1;
                        state <= IDLE;
                    end
                end
        endcase
   end            
            

endmodule
