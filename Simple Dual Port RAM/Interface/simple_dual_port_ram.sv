`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2023 11:03:43 PM
// Design Name: 
// Module Name: simple_dual_port_ram
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


 

module simple_dual_port_ram (

    input wire clk,
    input wire rst,
    sdpram_if.sdp_s ifp

    );

 

//---------------------------------------------------------------------------------------------------------------------
// Parameter / Headers

//---------------------------------------------------------------------------------------------------------------------
reg [ifp.DATA_WIDTH-1:0] ram [0:ifp.MEM_DEPTH-1];
logic [ifp.DATA_WIDTH-1:0] doutb_reg;
logic dvalb_reg;
logic  [ifp.DATA_WIDTH-1:0] doutb_temp;

 

//---------------------------------------------------------------------------------------------------------------------

// I/O signals

//---------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------

// Implementation

//---------------------------------------------------------------------------------------------------------------------

 always @(posedge clk) begin
    if (ifp.wena) begin
            ram[ifp.addra] <= ifp.dina;
    end
        
          	//address <= ifp.addrb;
     doutb_temp <= ram[ifp.addrb];
     doutb_reg <= doutb_temp;
     ifp.doutb <= doutb_reg;
     dvalb_reg <= 1;
     if (ram[ifp.addrb] == doutb_temp) begin
     ifp.dvalb <= 1;
     #10; 
     ifp.dvalb <= 0;
     end
     else ifp.dvalb <= 0;
 end

//assign ifp.doutb = doutb_reg;
assign ifp.dvalb = dvalb_reg;

endmodule
 

                                                           


