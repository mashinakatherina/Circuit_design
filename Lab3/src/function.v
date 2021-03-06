`timescale 1ns / 1ps


module main_function(
    input clk_i,    
    input [15:0] sw_i,
    input start_i,
    input rst_i,
    output reg [15:0] result_bo,
    output busy_o
);
    localparam IDLE = 1'b0;
    localparam WORK = 1'b1; 
   
    wire [7:0] a_bi;
    wire [7:0] b_bi;
    reg [7:0] a;
    reg [7:0] b;
    reg [15:0] part_result;
    reg state;
    reg start_cube;
    reg start_root;
    wire [15:0] cube_result;
    wire [3:0] root_result;
    wire [1:0] cube_busy;
    wire [1:0] root_busy;
    wire done;
    
    assign a_bi = sw_i[15:8];
    assign b_bi = sw_i[7:0];
    cube cube1(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .a_bi(a),
        .start_i(start_cube),
        .busy_o(cube_busy),
        .y_bo(cube_result)
    );
    root root1 (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .start_i(start_root),
        .x_bi(b),
        .busy_o(root_busy),
        .y_bo(root_result)
    );
    assign busy_o = state;
    assign done = root_busy == 0 && cube_busy == 0 && 
    (root_result != 0 && b!=0 || root_result == 0 && b==0 ) && 
    (cube_result != 0 && a!= 0 || cube_result == 0 && a== 0);
    always @(posedge clk_i) begin
    if(root_busy == 1) start_root <= 0;
    if(cube_busy == 1) start_cube <= 0;
        if(rst_i) begin
            state <= IDLE;
            result_bo <= 0;
        end else begin
            case(state)
                IDLE:
                    if(start_i) begin
                        part_result <= 0;
                        a <= a_bi;
                        b <= b_bi;
                        state <= WORK;
                        start_cube <= 1;
                        start_root <= 1;
                    end
                WORK:
                    begin
                        if(done) begin
                            state <= IDLE;
                            result_bo <= cube_result + root_result;
                        end 
                        
                    end      
            endcase
        end
    end
//    always @(root_busy) begin
//        if(root_busy == 1) start_root <= 0;
//    end
//    always @(cube_busy) begin
//        if(cube_busy == 1) start_cube <= 0;
//    end
endmodule
