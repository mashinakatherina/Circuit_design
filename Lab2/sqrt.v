`timescale 1ns / 1ps

module sqrt (
    input clk_i,
    input rst_i,
    
    input [16:0] x_bi,
    input start_i,
    output busy_o,
    output reg [7:0] y_bo
);
    localparam IDLE = 1'b0;
    localparam WORK = 1'b1;
    
    localparam start_m = 1 << (16 - 2);
    
    reg state;
    reg [15:0] x, b, y;
    reg [15:0] m; // number of bits?
    
    assign finished = (m == 0);
    assign busy_o = state;
    
    always @(posedge clk_i)
    if (rst_i) begin
        m <= start_m;
        y <= 0;
        y_bo <= 0;
        state <= IDLE;
    end else begin
        case (state)
            IDLE:
                if (start_i) begin
                    state <= WORK;
                    m <= start_m;
                    x <= x_bi;
                end
            WORK:
                begin
                    if (finished) begin
                        state <= IDLE;
                        y_bo <= y;
                    end 

                    b = y | m;
                    y = y >> 1;

                    if (x >= b) begin
                        x <= x - b;
                        y <= y | m;
                    end

                    m = m >> 2;
                end
        endcase
    end
endmodule
