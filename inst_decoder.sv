module inst_decoder(
    input  logic [32 - 1:0] instr_i,
    output logic [7 - 1:0 ] opcode_o,
    output logic [3 - 1:0 ] funct3_o
    output logic [5 - 1:0 ] rs1_o,
    output logic [5 - 1:0 ] rs2_o,
    output logic [5 - 1:0 ] rd_o,
    output logic [7 - 1:0 ] funct7_o
);

assign opcode_o = instr_i[6:0];
assign rd_o     = instr_i[11:7];
assign funct3_o = instr_i[14:12];
assign rs1_o    = instr_i[19:15];
assign rs2_o    = instr_i[24:20];
assign funct7_o = instr_i[31:25];

endmodule