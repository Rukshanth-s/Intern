`include "interface.sv";
`include "generator.sv";
module simple_dual_port_ram_tb();
  logic clk =1'b 1;
  logic rst;
  localparam CLK_PERIOD = 10;
  localparam REPITITIONS =100;
  generator g;
  sdpram_if #(32,1024,0) sdpram_if_inst();
  simple_dual_port_ram  
  simple_dual_port_ram_inst(
	  .clk(clk),
	  .rst(rst),
	  .ifp(sdpram_if_inst)
  );
  
  always #(CLK_PERIOD/2) clk=~clk;
  
    
  logic [sdpram_if_inst.DATA_WIDTH-1:0] mem_chk [sdpram_if_inst.MEM_DEPTH];
  initial begin
  g=new();
  for(int i=0;i<REPITITIONS;i++) begin
  	randomize(g.addra) with {g.addra inside{ [0:2**sdpram_if_inst.ADDR_WIDTH]};};
       //randomize(g.dina) with {g.dina inside{ [0:2**10]};};
 	randomize(g.wena) with {g.wena inside{ [0:2**sdpram_if_inst.STRB_WIDTH]};};
	g.dina = $random;

      	#(CLK_PERIOD *2);
      	sdpram_if_inst.wena = g.wena;
	sdpram_if_inst.addra = g.addra;
	sdpram_if_inst.dina= g.dina;
      	if (g.wena)
        	mem_chk[g.addra] = g.dina;  
    	end
  end
  
  initial begin 
    for(int i=0; i<REPITITIONS;i++) begin
    	randomize(g.addrb) with {g.addrb inside{ [0:2**sdpram_if_inst.ADDR_WIDTH]};};
    	#(CLK_PERIOD *2);
    	sdpram_if_inst.renb=1;
    	sdpram_if_inst.addrb = g.addrb;
    	@(posedge clk);
	# (CLK_PERIOD * 2.5);
      	a1 :assert (mem_chk[g.addrb]===sdpram_if_inst.doutb ) $display("[PASS] Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",g.addrb,mem_chk[g.addrb],sdpram_if_inst.doutb);  //assertion to check whether read data is correct
    else $error("[FAIL] Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",g.addrb,mem_chk[g.addrb],sdpram_if_inst.doutb);
    end
  end
  
   initial begin
   	$dumpvars;
   	$dumpfile("dump.vcd");
   end
   initial begin
    	#60000
     	$finish; 
   end
	
endmodule
