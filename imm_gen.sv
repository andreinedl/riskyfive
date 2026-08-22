`include "constants.sv"

module imm_gen(
    input        [32 - 1:0] instr_i,
    output logic [32 - 1:0] imm_o
);

wire [7 - 1:0] opcode = instr_i[6:0];

always_comb
    case (opcode)
        `I_TYPE_OPCODE:      
            imm_o = { {20{instr_i[31]}}, instr_i[31:20] };

        `S_TYPE_OPCODE:      
            imm_o = { {20{instr_i[31]}}, instr_i[31:25], instr_i[11:7] };

        `B_TYPE_OPCODE:      
            imm_o = { {19{instr_i[31]}}, instr_i[31], instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0 };

        `U_TYPE_OPCODE:      
            imm_o = { instr_i[31:12], 12'b0 };

        `J_TYPE_OPCODE:      
            imm_o = { {11{instr_i[31]}}, instr_i[31], instr_i[19:12], instr_i[20], instr_i[30:21], 1'b0 };

        `I_TYPE_OPCODE_JALR: 
            imm_o = { {20{instr_i[31]}}, instr_i[31:20] };

        default: imm_o = 32'd0;
    endcase

endmodule 