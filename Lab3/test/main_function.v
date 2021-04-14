`timescale 1ns / 1ps

module main_function_tb();
    reg clk;
    reg rst;
    reg [7:0] a;
    reg [7:0] b;
    reg start;
    wire busy;
    wire [23:0] result;
    main_function main1 (
        .clk_i(clk),
        .rst_i(rst),
        .a_bi(a),
        .b_bi(b),
        .start_i(start),
        .busy_o(busy),
        .result_bo(result)
    );
    initial begin
        clk=1; rst=1;
        #1
        clk=0; rst=0;
        #1
        a=8'd3; b=8'd169; clk=1; start=1;
        #1 clk=0; #1 clk=1; start=0;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
        #1 clk=0; #1 clk=1;
    end
endmodule
