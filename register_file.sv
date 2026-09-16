module register_file(
    input  logic                 clk_i,
    input  logic    [5 - 1:0]    rs1_addr_i,
    input  logic    [5 - 1:0]    rs2_addr_i,
    input  logic    [5 - 1:0]    rd_addr_i,
    input  logic    [32 - 1:0]   rd_data_i,
    input  logic                 reg_write_en_i,

    output logic    [32 - 1:0]   rs1_data_o,
    output logic    [32 - 1:0]   rs2_data_o
);

logic [32 - 1:0] reg_file [0:31];

always_comb begin : rs1_read
    if(~|rs1_addr_i)    rs1_data_o = 32'b0; else
                        rs1_data_o = reg_file[rs1_addr_i];
end : rs1_read

always_comb begin : rs2_read
    if(~|rs2_addr_i)    rs2_data_o = 32'b0; else
                        rs2_data_o = reg_file[rs2_addr_i];
end : rs2_read

always_ff @(posedge clk_i) begin : rd_write
    if(|rd_addr_i && reg_write_en_i)  
        reg_file[rd_addr_i] <= rd_data_i;  
end

endmodule
