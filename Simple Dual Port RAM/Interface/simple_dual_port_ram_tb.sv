`include "interface.sv";

module simple_dual_port_ram_tb();
   logic clk;
   logic rst;
  localparam clk_period =1000;
   //sdpram_if #(32, 1024, 0) sdpram_inst(.clk(clk),.rst(rst),.sdp_s(ifp));
  sdpram_if #(32,1024,0) sdpram_if_inst();

 simple_dual_port_ram  dut(
    .clk(clk),
    .rst(rst),
         .ifp(sdpram_if_inst)
);
/* initial begin
       clk=1'b1;
       forever #5 clk=~clk;
     end*/
  initial begin
    clk = 1'b1;
end

always begin
    #(clk_period/2) clk = ~clk;
end

            
     initial begin
       sdpram_if_inst.dina= 32'h 55;
       sdpram_if_inst.addra= 10'h 01;
       sdpram_if_inst.wena =1;
       sdpram_if_inst.renb =1;
       sdpram_if_inst.addrb =10'h 01;
     end
  
  initial begin
    $dumpvars;
    $dumpfile("dump.vcd");
    
  end
    initial begin
    #6000
    $finish; 
    end
    
  
endmodule
