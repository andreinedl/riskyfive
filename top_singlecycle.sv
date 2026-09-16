import riscv_pkg::*;

module top_singlecycle(
    input clk_i,
    input rst_ni
);

alu_a_src_e      alu_a_src_wire;
alu_b_src_e      alu_b_src_wire;
alu_opcode_e     ALUOp_wire;
logic            reg_write_en_wire;
rd_result_src_e  rd_result_src_wire;
logic            jump_wire;
logic            branch_wire;
logic            mem_write_en_wire;
logic            load_store_op_wire;
ls_unit_op_e     ls_unit_op_wire;

logic [6:0]      opcode_wire;
logic [2:0]      funct3_wire;

datapath datapath_inst (
    .clk_i                  (clk_i),
    .rst_ni                 (rst_ni),
    
    .ctrl_alu_a_src_i       (alu_a_src_wire),
    .ctrl_alu_b_src_i       (alu_b_src_wire),
    .ctrl_ALUOp_i           (ALUOp_wire),
    .ctrl_reg_write_en_i    (reg_write_en_wire),
    .ctrl_jump_i            (jump_wire),
    .ctrl_branch_i          (branch_wire),
    .ctrl_mem_write_en_i    (mem_write_en_wire),
    .ctrl_rd_result_src_i   (rd_result_src_wire),
    .ctrl_ls_unit_op_i      (ls_unit_op_wire),
    .decoder_opcode_o       (opcode_wire),
    .decoder_funct3_o       (funct3_wire)
);

singlecycle_control_unit singlecycle_control_unit_inst(
    .clk_i                  (clk_i),
    .rst_ni                 (rst_ni),
    .instr_opcode_i         (opcode_wire),
    .instr_funct3_i         (funct3_wire),
    .alu_a_src_o            (alu_a_src_wire),
    .alu_b_src_o            (alu_b_src_wire),
    .ALUOp_o                (ALUOp_wire),
    .reg_write_en_o         (reg_write_en_wire),
    .rd_result_src_o        (rd_result_src_wire),
    .jump_o                 (jump_wire),
    .branch_o               (branch_wire),
    .mem_write_en_o         (mem_write_en_wire),
    .load_store_op_o        (load_store_op_wire),
    .ls_unit_op_o           (ls_unit_op_wire)
);

endmodule
