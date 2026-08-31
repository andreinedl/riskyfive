`ifndef RISCV_CONSTANTS
`define RISCV_CONSTANTS

// #### ALU #### //

`define ALU_OPCODE_ADD              2'b00  // used for load and store instructions
`define ALU_OPCODE_SUB_BRANCH       2'b01  // used for bne and beq instructions
`define ALU_OPCODE_OP               2'b10  
`define ALU_OPCODE_OP_IMM           2'b11

`define FUNCT3_ALU_ADD_SUB          3'b000
`define FUNCT3_ALU_SLL              3'b001
`define FUNCT3_ALU_SLT              3'b010
`define FUNCT3_ALU_SLTU             3'b011
`define FUNCT3_ALU_XOR              3'b100
`define FUNCT3_ALU_SRL_SRA          3'b101
`define FUNCT3_ALU_OR               3'b110
`define FUNCT3_ALU_AND              3'b111

/*
`define FUNCT7_ALU_ADD              7'b0000000
`define FUNCT7_ALU_SUB              7'b0100000
`define FUNCT7_ALU_SRL              7'b0000000
`define FUNCT7_ALU_SRA              7'b0100000
*/

`define ALU_OP_ADD                  4'b0001
`define ALU_OP_SUB                  4'b0010
`define ALU_OP_SLL                  4'b0011
`define ALU_OP_SLT                  4'b0100
`define ALU_OP_SLTU                 4'b0101
`define ALU_OP_XOR                  4'b0110
`define ALU_OP_SRL                  4'b0111
`define ALU_OP_SRA                  4'b1000
`define ALU_OP_OR                   4'b1001
`define ALU_OP_AND                  4'b1010

// ##### OPCODES #####
`define R_TYPE_OPCODE               7'b0110011
`define I_TYPE_OPCODE               7'b0010011
`define S_TYPE_OPCODE               7'b0100011
`define B_TYPE_OPCODE               7'b1100011
`define U_TYPE_OPCODE_LUI           7'b0110111
`define U_TYPE_OPCODE_AUIPC         7'b0010111
`define J_TYPE_OPCODE               7'b1101111
`define I_TYPE_OPCODE_JALR          7'b1100111
`define I_TYPE_OPCODE_LOAD          7'b0000011

`endif RISCV_CONSTANTS