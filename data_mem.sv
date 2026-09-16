module data_mem(
    input  logic clk_i,
    input  logic write_en_i,
    input  logic [32 - 1:0] addr_i,
    input  logic [32 - 1:0] write_data_i,
    input  logic [4 - 1:0 ] mem_write_byte_sel_i,
    output logic [32 - 1:0] read_data_o
);

logic [32 - 1:0] data_mem_array [0:1023]; //4KB

always_ff @(posedge clk_i)
    if(write_en_i) begin
        if(mem_write_byte_sel_i[0]) data_mem_array[addr_i[11:2]][7:0] <= write_data_i[7:0];
        if(mem_write_byte_sel_i[1]) data_mem_array[addr_i[11:2]][15:8] <= write_data_i[15:8];
        if(mem_write_byte_sel_i[2]) data_mem_array[addr_i[11:2]][23:16] <= write_data_i[23:16];
        if(mem_write_byte_sel_i[3]) data_mem_array[addr_i[11:2]][31:24] <= write_data_i[31:24];
    end

assign read_data_o = data_mem_array[addr_i[11:2]];

endmodule
