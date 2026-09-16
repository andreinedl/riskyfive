module instr_mem #
( 
    ADDR_W = 32
) (
    input  logic [ADDR_W - 1:0] addr_i,
    output logic [ADDR_W - 1:0] instr_o
);

logic [ADDR_W - 1:0] inst_mem_array [0:1023]; //4KB 

initial begin
    $readmemh("test.hex", inst_mem_array);
end

assign instr_o = inst_mem_array[addr_i[11:2]];

endmodule