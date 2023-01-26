`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2023 01:52:56 PM
// Design Name: 
// Module Name: simple_dual_port_ram_tb
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


module simple_dual_port_ram_tb();
   localparam clk_period =1000;
   logic clk;
   logic rst;
  logic [9:0] addra;
  logic [9:0] addrb;
  logic [31:0] dina;
  logic [31:0] doutb;
    logic wena;
    logic renb;
    logic dvalb;

 dual_port_ram  dut(
    .clk(clk),
    .rst(rst),
   . addra(addra),
   .addrb(addrb),
   .dina(dina),
   .doutb(doutb),
   .wena(wena),
   .renb(renb),
   .dvalb(dvalb)
);

  initial begin
    clk = 1'b1;
end

always begin
    #(clk_period/2) clk = ~clk;
end

            
     initial begin
       assign dina= 32'h 55;
       assign addra= 10'h 01;
       assign wena =1;//the size of write enable
       #1500;
       //@(posedge clk)begin
       assign renb=1;
       assign addrb =10'h 01;
      end
  initial begin
  #2500
  assign dina=32'h 22;
  assign addra =10'h 01;
  assign wena =1;
  #3500;
  
  assign renb =1;
  assign addrb =10'h 01;
    
  end

  initial begin
    
    $dumpvars;
    $dumpfile("dumps.vcd");
   end
   initial begin
     #20000
     $finish;
   end
    
  
endmodule
