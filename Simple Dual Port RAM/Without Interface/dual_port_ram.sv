`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2023 08:08:00 PM
// Design Name: 
// Module Name: dual_port_ram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dual_port_ram #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10,
    parameter MEM_DEPTH = 1024
    
) (
    input logic clk,
    input logic rst,
    
    input logic [ADDR_WIDTH-1:0] addra,
    input logic [ADDR_WIDTH-1:0] addrb,
    input logic [DATA_WIDTH-1:0] dina,
    output logic [DATA_WIDTH-1:0] doutb,
    input logic wena,
    input logic renb,
    output logic dvalb
);

reg [DATA_WIDTH-1:0] ram [0:MEM_DEPTH-1];
logic [DATA_WIDTH-1:0] doutb_reg;
logic dvalb_reg;
logic [DATA_WIDTH-1:0]doutb_temp;


always @(posedge clk) begin
    if (rst) begin
        for (int i = 0; i < MEM_DEPTH; i++) begin
            ram[i] <= 0;
        end
        doutb_reg <= 0;
        dvalb_reg <= 0;
    end else begin
        if (wena) begin
            ram[addra] <= dina;
        end
        if (renb) begin
            doutb_temp <= ram[addrb];
            doutb_reg <= doutb_temp;
            doutb <= doutb_reg;
            dvalb_reg <= 1;
        end
    end
end

//assign doutb = doutb_reg;
assign dvalb = dvalb_reg;

endmodule
   

