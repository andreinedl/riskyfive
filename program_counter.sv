module program_counter(
    input logic             clk_i,
    input logic             rst_ni,
    input logic             pc_src_i, // 0 - PC + 4, 1 - Address from ALU
    input logic  [32 - 1:0] jump_addr_i,
    output logic [32 - 1:0] pc_o
);

wire [32 - 1:0] pc_next = (pc_src_i) ? jump_addr_i : (pc_o + 4); 

always_ff @( posedge clk_i or negedge rst_ni )
    if(!rst_ni) pc_o <= 32'b0; else
                pc_o <= pc_next;

endmodule
