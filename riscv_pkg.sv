package riscv_pkg;

    // ALU OPCODES
    typedef enum logic [2 - 1:0] { 
        ALU_OPCODE_ADD        = 2'b00,
        ALU_OPCODE_SUB_BRANCH = 2'b01,
        ALU_OPCODE_OP         = 2'b10,
        ALU_OPCODE_OP_IMM     = 2'b11
    } alu_opcode_e;

    // ALU Funct3
    typedef enum logic [2 - 1:0] {
        FUNCT3_ALU_ADD_SUB    = 3'b000,
        FUNCT3_ALU_SLL        = 3'b001,
        FUNCT3_ALU_SLT        = 3'b010,
        FUNCT3_ALU_SLTU       = 3'b011,
        FUNCT3_ALU_XOR        = 3'b100,
        FUNCT3_ALU_SRL_SRA    = 3'b101,
        FUNCT3_ALU_OR         = 3'b110,
        FUNCT3_ALU_AND        = 3'b111
    } funct3_alu_e;

    // ALU Operations
    typedef enum logic [4 - 1:0] {
        ALU_OP_ADD            = 4'b0001,
        ALU_OP_SUB            = 4'b0010,
        ALU_OP_SLL            = 4'b0011,
        ALU_OP_SLT            = 4'b0100,
        ALU_OP_SLTU           = 4'b0101,
        ALU_OP_XOR            = 4'b0110,
        ALU_OP_SRL            = 4'b0111,
        ALU_OP_SRA            = 4'b1000,
        ALU_OP_OR             = 4'b1001,
        ALU_OP_AND            = 4'b1010
    } alu_op_e;

    // RISC-V Instruction types
    typedef enum logic [7 - 1:0] {
        R_TYPE_OPCODE       = 7'b0110011,
        I_TYPE_OPCODE       = 7'b0010011,
        S_TYPE_OPCODE       = 7'b0100011,
        B_TYPE_OPCODE       = 7'b1100011,
        U_TYPE_OPCODE_LUI   = 7'b0110111,
        U_TYPE_OPCODE_AUIPC = 7'b0010111,
        J_TYPE_OPCODE       = 7'b1101111,
        I_TYPE_OPCODE_JALR  = 7'b1100111,
        I_TYPE_OPCODE_LOAD  = 7'b0000011
    } opcode_e;

    //ALU MUX entries
    typedef enum logic [2 - 1:0] { 
        ALU_SRC_A_RS1  = 2'b00,
        ALU_SRC_A_PC   = 2'b01,
        ALU_SRC_A_ZERO = 2'b10
    } alu_a_src_e;

    typedef enum logic { 
        ALU_SRC_B_RS2 = 1'b0,
        ALU_SRC_B_IMM = 1'b1
    } alu_b_src_e;

    //rd register mux 
    typedef enum logic [2 - 1:0] {
        RD_RESULT_SRC_ALU = 2'b00,
        RD_RESULT_SRC_MEM = 2'b01,
        RD_RESULT_SRC_PC4 = 2'b10
    } rd_result_src_e;

endpackage