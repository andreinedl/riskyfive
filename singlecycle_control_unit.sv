import riscv_pkg::*;

module singlecycle_control_unit(
    input  logic           clk_i,
    input  logic           rst_ni,

    input  logic [7 - 1:0] instr_i,
    output alu_a_src_e     alu_a_src_o, // 2'b00 - rs1, 2'b01 - PC, 2'b10 - 0
    output alu_b_src_e     alu_b_src_o, // 1'b0 - rs2, 1'b1 - imm
    output alu_opcode_e    ALUOp_o, // 2'b00 - ADD, 2'b01 - SUB, 2'b10 - OP, 2'b11 - OP-IMM
    output logic           reg_write_en_o,
    output rd_result_src_e rd_result_src_o, // 2'b00 - ALU, 2'b01 - Memory, 2'b10 - PC + 4     
    output logic           jump_o,
    output logic           branch_o, // if branch_o = 1 - is a branch instruction, so we should jump to a instruction
    output logic           mem_write_en_o
);

always_comb begin
    case (instr_i)
        R_TYPE_OPCODE: begin
            ALUOp_o         = 2'b10;
            alu_a_src_o     = 1'b0;
            alu_b_src_o     = 1'b0;
            reg_write_en_o  = 1'b1;
            rd_result_src_o = 2'b00;
            jump_o          = 1'b0;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b0;
        end

        I_TYPE_OPCODE: begin
            ALUOp_o         = 2'b11;
            alu_a_src_o     = 1'b0;
            alu_b_src_o     = 1'b1;
            reg_write_en_o  = 1'b1;
            rd_result_src_o = 2'b00;
            jump_o          = 1'b0;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b0;
        end

        J_TYPE_OPCODE: begin
            ALUOp_o         = 2'b00;
            alu_a_src_o     = 1'b1;
            alu_b_src_o     = 1'b1;
            reg_write_en_o  = 1'b1;
            rd_result_src_o = 2'b10;
            jump_o          = 1'b1;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b0;
        end

        B_TYPE_OPCODE: begin
            ALUOp_o         = 2'b01;
            alu_a_src_o     = 1'b0;
            alu_b_src_o     = 1'b0;
            reg_write_en_o  = 1'b0;
            rd_result_src_o = 2'b00;
            jump_o          = 1'b0;
            branch_o        = 1'b1;
            mem_write_en_o  = 1'b0;
        end

        U_TYPE_OPCODE_AUIPC: begin
            ALUOp_o         = 2'b00;
            alu_a_src_o     = 2'b01;
            alu_b_src_o     = 1'b1;
            reg_write_en_o  = 1'b1;
            rd_result_src_o = 2'b00;
            jump_o          = 1'b0;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b0;
        end

        U_TYPE_OPCODE_LUI: begin
            ALUOp_o         = 2'b00;
            alu_a_src_o     = 2'b10;
            alu_b_src_o     = 1'b1;
            reg_write_en_o  = 1'b1;
            rd_result_src_o = 2'b00;
            jump_o          = 1'b0;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b0;
        end

        S_TYPE_OPCODE: begin
            ALUOp_o         = 2'b00;
            alu_a_src_o     = 2'b00;
            alu_b_src_o     = 1'b1;
            reg_write_en_o  = 1'b0;
            rd_result_src_o = 2'b00;
            jump_o          = 1'b0;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b1;
        end

        I_TYPE_OPCODE_JALR: begin
            ALUOp_o         = 2'b00;
            alu_a_src_o     = 2'b00;
            alu_b_src_o     = 1'b1;
            reg_write_en_o  = 1'b1;
            rd_result_src_o = 2'b10;
            jump_o          = 1'b1;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b0;
        end

        I_TYPE_OPCODE_LOAD: begin
            ALUOp_o         = 2'b00;
            alu_a_src_o     = 2'b00;
            alu_b_src_o     = 1'b1;
            reg_write_en_o  = 1'b1;
            rd_result_src_o = 2'b01;
            jump_o          = 1'b0;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b0;
        end

        default: begin
            ALUOp_o         = 2'b00;
            alu_a_src_o     = 2'b10;
            alu_b_src_o     = 1'b1;
            reg_write_en_o  = 1'b0;
            rd_result_src_o = 2'b00;
            jump_o          = 1'b0;
            branch_o        = 1'b0;
            mem_write_en_o  = 1'b0;
        end
    endcase
end

endmodule