import riscv_pkg::*;

module datapath(
    input logic clk_i,
    input logic rst_ni,
    
    // instructions memory
    output logic [32 - 1:0] pc_o,
    input  logic [32 - 1:0] instr_i,

    // RAM (WIP)
    output logic [32 - 1:0] ram_addr_o,
    output logic [32 - 1:0] ram_write_data_o,
    input  logic [32 - 1:0] ram_read_data_i,

    // Control Unit
    input  alu_a_src_e      ctrl_alu_a_src_i,
    input  alu_b_src_e      ctrl_alu_b_src_i,
    input  alu_opcode_e     ctrl_ALUOp_i,
    input  logic            ctrl_reg_write_en_i,
    input  logic            ctrl_jump_i,
    input  logic            ctrl_branch_i,
    input  logic            ctrl_mem_write_en_i,
    input  rd_result_src_e  ctrl_rd_result_src_i,
    output logic [32 - 1:0] decoder_opcode_o

);

logic [3 - 1:0 ] decoder_funct3;
logic [5 - 1:0 ] decoder_rs1;
logic [5 - 1:0 ] decoder_rs2;
logic [5 - 1:0 ] decoder_rd;
logic [7 - 1:0 ] decoder_funct7;

logic [32 - 1:0] alu_operand_a;
logic [32 - 1:0] alu_operand_b;

logic [32 - 1:0] imm;

logic            alu_zero_flag;
logic [32 - 1:0] alu_result;

logic pc_src = (ctrl_branch_i & alu_zero_flag) | ctrl_jump_i;

logic [32 - 1:0] reg_rs1_data;
logic [32 - 1:0] reg_rs2_data;
logic [32 - 1:0] reg_rd_data;

logic [32 - 1:0] pc;

always_comb
    case(ctrl_alu_a_src_i)
        ALU_SRC_A_RS1:  alu_operand_a = reg_rs1_data;
        ALU_SRC_A_PC:   alu_operand_a = pc_o;
        ALU_SRC_A_ZERO: alu_operand_a = '0;
        default:        alu_operand_a = 'X;
    endcase

always_comb
    case(ctrl_alu_b_src_i)
        ALU_SRC_B_RS2:  alu_operand_b = reg_rs2_data;
        ALU_SRC_B_IMM:  alu_operand_b = imm;
        default:        alu_operand_b = 'X;
    endcase

always_comb
    case(ctrl_rd_result_src_i)
        RD_RESULT_SRC_ALU:  reg_rd_data = alu_result;
        //RD_RESULT_SRC_MEM:  reg_rd_data = 
        RD_RESULT_SRC_PC4:  reg_rd_data = pc + 4;
        default:            reg_rd_data = 'X;
    endcase

alu alu_inst(
    .alu_operation_i(ctrl_ALUOp_i),
    .operand_a_i    (alu_operand_a),
    .operand_b_i    (alu_operand_b),
    .alu_result_o   (alu_result),
    .zero_flag_o    (alu_zero_flag)
);

inst_decoder inst_decoder_inst(
    .instr_i    (instr_i),
    .opcode_o   (decoder_opcode_o),
    .funct3_o   (decoder_funct3),
    .rs1_o      (decoder_rs1),
    .rs2_o      (decoder_rs2),
    .rd_o       (decoder_rd),
    .funct7_o   (decoder_funct7)
);

imm_gen imm_gen_inst(
    .instr_i(instr_i),
    .imm_o(imm)
);

program_counter pc_inst(
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    .pc_src_i(pc_src), // 0 - PC + 4, 1 - Address from ALU
    .jump_addr_i(alu_result),
    .pc_o(pc)
);

register_file register_file_inst(
    .clk_i(clk_i),
    .rs1_addr_i(decoder_rs1),
    .rs2_addr_i(decoder_rs2),
    .rd_addr_i(decoder_rd),
    .rd_data_i(reg_rd_data),
    .reg_write_en_i(ctrl_reg_write_en_i),
    .rs1_data_o(reg_rs1_data),
    .rs2_data_o(reg_rs2_data)
);

endmodule