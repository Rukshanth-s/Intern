class generator;
	parameter DATA_WIDTH = 32;
	parameter MEM_DEPTH  = 1024;      
	parameter BYTE_WRITE = 0;
	localparam ADDR_WIDTH = $clog2(MEM_DEPTH);
	localparam STRB_WIDTH = BYTE_WRITE ? (DATA_WIDTH/8) : 1;
	logic [ADDR_WIDTH-1:0]  addra;   
	logic    wena;
	logic [DATA_WIDTH-1:0]  dina;  
	logic [ADDR_WIDTH-1:0]  addrb;   
	logic   renb;
	logic [DATA_WIDTH-1:0]  doutb;
	logic    dvalb;
endclass
