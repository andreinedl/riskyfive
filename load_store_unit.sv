module load_store_unit(
    input  ls_unit_op_e      ls_unit_opcode_i,
    input  logic [32 - 1:0]  addr_i,

    input  logic [32 - 1:0]  reg_data_i,
    output logic [32 - 1:0]  reg_data_o,

    input  logic [32 - 1:0]  mem_data_i,
    output logic [32 - 1:0]  mem_data_o,
    output logic [4 - 1:0]   mem_write_byte_sel_o
);

logic [8 - 1:0]  data_byte;
logic [16 - 1:0] data_half;

// Byte selection based on LSU OPCODE
always_comb begin
    case(ls_unit_opcode_i)
        LS_S_LOAD_BYTE, LS_U_LOAD_BYTE: begin
            data_byte = mem_data_i[(addr_i[1:0] * 8) +: 8];
        end

        LS_STORE_BYTE: begin
            data_byte = reg_data_i[7:0];
        end

        default: data_byte = 'X;
    endcase
end

// Half selection based on LSU OPCODE
always_comb begin
    case(ls_unit_opcode_i)
        LS_S_LOAD_HALF, LS_U_LOAD_HALF: begin
            data_half = mem_data_i[(addr_i[1] * 16) +: 16];
        end

        LS_STORE_HALF: begin
            data_half = reg_data_i[15:0];
        end

        default: data_half = 'X;
    endcase
end

// reg data output
always_comb begin
    case(ls_unit_opcode_i)
        LS_S_LOAD_BYTE: reg_data_o = {{24{data_byte[7]}}, data_byte};
        LS_U_LOAD_BYTE: reg_data_o = {24'd0, data_byte};

        LS_S_LOAD_HALF: reg_data_o = {{16{data_half[15]}}, data_half};
        LS_U_LOAD_HALF: reg_data_o = {16'd0, data_half};

        LS_LOAD_WORD:   reg_data_o = mem_data_i;
        default:        reg_data_o = 32'bx;
    endcase
end

// mem data output
always_comb begin
    case(ls_unit_opcode_i)
        LS_STORE_BYTE:  mem_data_o = {4{data_byte}};
        LS_STORE_HALF:  mem_data_o = {2{data_half}};
        LS_STORE_WORD:  mem_data_o = reg_data_i;
        default:        mem_data_o = 32'bx;
    endcase
end

// Mem write mask output
always_comb begin
    case(ls_unit_opcode_i)
        LS_STORE_BYTE: mem_write_byte_sel_o = 4'b0001 << addr_i[1:0];
        LS_STORE_HALF: mem_write_byte_sel_o = 4'b0011 << (addr_i[1] * 2);
        LS_STORE_WORD: mem_write_byte_sel_o = 4'b1111;
        default:       mem_write_byte_sel_o = 4'bxxxx;
    endcase
end

endmodule