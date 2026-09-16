import riscv_pkg::*;

module singlecycle_control_unit(
    input  logic           clk_i,
    input  logic           rst_ni,

    input  logic [7 - 1:0] instr_opcode_i,
    input  logic [3 - 1:0] instr_funct3_i,
    output alu_a_src_e     alu_a_src_o, // 2'b00 - rs1, 2'b01 - PC, 2'b10 - 0
    output alu_b_src_e     alu_b_src_o, // 1'b0 - rs2, 1'b1 - imm
    output alu_opcode_e    ALUOp_o, // 2'b00 - ADD, 2'b01 - SUB, 2'b10 - OP, 2'b11 - OP-IMM
    output logic           reg_write_en_o,
    output rd_result_src_e rd_result_src_o, // 2'b00 - ALU, 2'b01 - Memory, 2'b10 - PC + 4     
    output logic           jump_o,
    output logic           branch_o, // if branch_o = 1 - is a branch instruction, so we should jump to a instruction
    output logic           mem_write_en_o,
    output logic           load_store_op_o,
    output ls_unit_op_e    ls_unit_op_o
);

always_comb begin
    case (instr_opcode_i)
        R_TYPE_OPCODE: begin
            ALUOp_o         = ALU_OPCODE_OP;
            alu_a_src_o     = ALU_SRC_A_RS1;
            alu_b_src_o     = ALU_SRC_B_RS2;
            reg_write_en_o  = 1'b1;
            rd_result_src_o = RD_RESULT_SRC_ALU;
            jump_o          = 1'b0;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b0;
            load_store_op_o = 1'b0;
            ls_unit_op_o    = ls_unit_op_e'(4'bxxxx);
        end

        I_TYPE_OPCODE: begin
            ALUOp_o         = ALU_OPCODE_OP_IMM;
            alu_a_src_o     = ALU_SRC_A_RS1;
            alu_b_src_o     = ALU_SRC_B_IMM;
            reg_write_en_o  = 1'b1;
            rd_result_src_o = RD_RESULT_SRC_ALU;
            jump_o          = 1'b0;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b0;
            load_store_op_o = 1'b0;
            ls_unit_op_o    = ls_unit_op_e'(4'bxxxx);
        end

        J_TYPE_OPCODE: begin
            ALUOp_o         = ALU_OPCODE_ADD;
            alu_a_src_o     = ALU_SRC_A_PC;
            alu_b_src_o     = ALU_SRC_B_IMM;
            reg_write_en_o  = 1'b1;
            rd_result_src_o = RD_RESULT_SRC_PC4;
            jump_o          = 1'b1;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b0;
            load_store_op_o = 1'b0;
            ls_unit_op_o    = ls_unit_op_e'(4'bxxxx);
        end

        B_TYPE_OPCODE: begin
            ALUOp_o         = ALU_OPCODE_SUB_BRANCH;
            alu_a_src_o     = ALU_SRC_A_RS1;
            alu_b_src_o     = ALU_SRC_B_RS2;
            reg_write_en_o  = 1'b0;
            rd_result_src_o = RD_RESULT_SRC_ALU;
            jump_o          = 1'b0;
            branch_o        = 1'b1;
            mem_write_en_o  = 1'b0;
            load_store_op_o = 1'b0;
            ls_unit_op_o    = ls_unit_op_e'(4'bxxxx);
        end

        U_TYPE_OPCODE_AUIPC: begin
            ALUOp_o         = ALU_OPCODE_ADD;
            alu_a_src_o     = ALU_SRC_A_PC;
            alu_b_src_o     = ALU_SRC_B_IMM;
            reg_write_en_o  = 1'b1;
            rd_result_src_o = RD_RESULT_SRC_ALU;
            jump_o          = 1'b0;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b0;
            load_store_op_o = 1'b0;
            ls_unit_op_o    = ls_unit_op_e'(4'bxxxx);
        end

        U_TYPE_OPCODE_LUI: begin
            ALUOp_o         = ALU_OPCODE_ADD;
            alu_a_src_o     = ALU_SRC_A_ZERO;
            alu_b_src_o     = ALU_SRC_B_IMM;
            reg_write_en_o  = 1'b1;
            rd_result_src_o = RD_RESULT_SRC_ALU;
            jump_o          = 1'b0;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b0;
            load_store_op_o = 1'b0;
            ls_unit_op_o    = ls_unit_op_e'(4'bxxxx);
        end

        S_TYPE_OPCODE: begin
            ALUOp_o         = ALU_OPCODE_ADD;
            alu_a_src_o     = ALU_SRC_A_RS1;
            alu_b_src_o     = ALU_SRC_B_IMM;
            reg_write_en_o  = 1'b0;
            rd_result_src_o = RD_RESULT_SRC_ALU;
            jump_o          = 1'b0;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b1;
            load_store_op_o = 1'b1;
            ls_unit_op_o    = ls_unit_op_e'({instr_opcode_i[5], instr_funct3_i});
        end

        I_TYPE_OPCODE_JALR: begin
            ALUOp_o         = ALU_OPCODE_ADD;
            alu_a_src_o     = ALU_SRC_A_RS1;
            alu_b_src_o     = ALU_SRC_B_IMM;
            reg_write_en_o  = 1'b1;
            rd_result_src_o = RD_RESULT_SRC_PC4;
            jump_o          = 1'b1;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b0;
            load_store_op_o = 1'b0;
            ls_unit_op_o    = ls_unit_op_e'(4'bxxxx);
        end

        I_TYPE_OPCODE_LOAD: begin
            ALUOp_o         = ALU_OPCODE_ADD;
            alu_a_src_o     = ALU_SRC_A_RS1;
            alu_b_src_o     = ALU_SRC_B_IMM;
            reg_write_en_o  = 1'b1;
            rd_result_src_o = RD_RESULT_SRC_MEM;
            jump_o          = 1'b0;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b0;
            load_store_op_o = 1'b1;
            ls_unit_op_o    = ls_unit_op_e'({instr_opcode_i[5], instr_funct3_i});
        end

        default: begin
            ALUOp_o         = ALU_OPCODE_ADD;
            alu_a_src_o     = ALU_SRC_A_ZERO;
            alu_b_src_o     = ALU_SRC_B_IMM;
            reg_write_en_o  = 1'b0;
            rd_result_src_o = RD_RESULT_SRC_ALU;
            jump_o          = 1'b0;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b0;
            load_store_op_o = 1'b0;
            ls_unit_op_o    = ls_unit_op_e'(4'bxxxx);
        end
    endcase
end

endmodule
