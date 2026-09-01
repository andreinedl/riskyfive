// Based on Computer Organization and Design RISC-V Edition

import riscv_pkg::*;

module alu_control (
    input alu_opcode_e     alu_opcode_i, 
    input [3 - 1:0]        inst_funct3_i,
    input [7 - 1:0]        inst_funct7_i,
    output alu_op_e        alu_operation_o
);

wire second_op_bit = inst_funct7_i[5];

always_comb begin
    case (alu_opcode_i)
        ALU_OPCODE_ADD:        alu_operation_o = ALU_OP_ADD;
        ALU_OPCODE_SUB_BRANCH: alu_operation_o = ALU_OP_SUB;

        ALU_OPCODE_OP: begin
            case (inst_funct3_i) 
                FUNCT3_ALU_ADD_SUB: 
                    if(second_op_bit) alu_operation_o = ALU_OP_SUB; else
                                      alu_operation_o = ALU_OP_ADD;

                FUNCT3_ALU_SRL_SRA:
                    if(second_op_bit) alu_operation_o = ALU_OP_SRA; else
                                      alu_operation_o = ALU_OP_SRL;
                
                FUNCT3_ALU_SLL:      alu_operation_o = ALU_OP_SLL;
                FUNCT3_ALU_SLT:      alu_operation_o = ALU_OP_SLT;
                FUNCT3_ALU_SLTU:     alu_operation_o = ALU_OP_SLTU;
                FUNCT3_ALU_XOR:      alu_operation_o = ALU_OP_XOR;
                FUNCT3_ALU_AND:      alu_operation_o = ALU_OP_AND;
                FUNCT3_ALU_OR:       alu_operation_o = ALU_OP_OR;

                default: alu_operation_o = 4'bxxxx;
            endcase
        end

        ALU_OPCODE_OP_IMM: begin
            case (inst_funct3_i) 
                FUNCT3_ALU_ADD_SUB:  alu_operation_o = ALU_OP_ADD;
                
                FUNCT3_ALU_SRL_SRA:
                    if(second_op_bit) alu_operation_o = ALU_OP_SRA; else
                                      alu_operation_o = ALU_OP_SRL;

                FUNCT3_ALU_SLL:      alu_operation_o = ALU_OP_SLL;
                FUNCT3_ALU_SLT:      alu_operation_o = ALU_OP_SLT;
                FUNCT3_ALU_SLTU:     alu_operation_o = ALU_OP_SLTU;
                FUNCT3_ALU_XOR:      alu_operation_o = ALU_OP_XOR;
                FUNCT3_ALU_AND:      alu_operation_o = ALU_OP_AND;
                FUNCT3_ALU_OR:       alu_operation_o = ALU_OP_OR;

                default: alu_operation_o = 4'bxxxx;
            endcase
        end

        default: alu_operation_o = 4'bxxxx;
    endcase
end
    
endmodule