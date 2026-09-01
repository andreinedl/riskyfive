import riscv_pkg::*;

module alu(
    input  alu_op_e                 alu_operation_i,
    input                [32 - 1:0] operand_a_i,
    input                [32 - 1:0] operand_b_i,
    output logic         [32 - 1:0] alu_result_o,
    output logic                    zero_flag_o
);

logic [4:0] shamt = operand_b_i[4:0];
assign zero_flag_o = (~|alu_result_o);

always_comb begin
    case (alu_operation_i)
        ALU_OP_ADD:  alu_result_o = operand_a_i + operand_b_i;
        ALU_OP_SUB:  alu_result_o = operand_a_i - operand_b_i;
        ALU_OP_SLL:  alu_result_o = operand_a_i << shamt;
        ALU_OP_SLT:  alu_result_o = ($signed(operand_a_i) < $signed(operand_b_i));
        ALU_OP_SLTU: alu_result_o = (operand_a_i < operand_b_i);
        ALU_OP_XOR:  alu_result_o = operand_a_i ^ operand_b_i;
        ALU_OP_SRL:  alu_result_o = operand_a_i >> shamt;
        ALU_OP_SRA:  alu_result_o = $signed(operand_a_i) >>> shamt;
        ALU_OP_OR:   alu_result_o = operand_a_i | operand_b_i;
        ALU_OP_AND:  alu_result_o = operand_a_i & operand_b_i;

        default:     alu_result_o = 'x;
    endcase
end

endmodule