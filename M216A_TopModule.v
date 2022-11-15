`timescale 1ns / 100ps

//Do NOT Modify This
module P1_ADD (data_a_i,data_b_i,data_o);

    input [15: 0] data_a_i;
    input [15: 0] data_b_i;
    output  [15: 0] data_o;
    
    assign data_o = data_a_i + data_b_i;

endmodule

//Do NOT Modify This
module P1_Mult (data_a_i,data_b_i,data_o);

    input [15: 0] data_a_i;
    input [15: 0] data_b_i;
    output  [15: 0] data_o;
    
    assign data_o = data_a_i * data_b_i;

endmodule

//Do NOT Modify This
module P1_Reg (DataIn, DataOut, rst, clk);

    input [15: 0] DataIn;
    output [15: 0] DataOut;
    input rst;
    input clk;
    reg [15:0] DataReg;
    
    always @(posedge clk)
        if(rst)
            DataReg  <= 16'b0;
        else
            DataReg <= DataIn;
    assign DataOut = DataReg ;          
endmodule

//Do NOT Modify This
module M216A_TopModule(
    Clk_In,
    D_In1,
    D_In2,
    D_In3,
    D_Out,
    Instruction_In,
    Rst_In);
  input Clk_In;
  input [15:0]D_In1;
  input [15:0]D_In2;
  input [15:0]D_In3;
  output [15:0]D_Out;
  input [15:0]Instruction_In;
  input Rst_In;

  reg [15:0]D_Out;
  
  //----------------------------------------------------------------------------------------
  //Declarations
  
  wire [15:0] reg_in1_0, reg_in1_1, reg_in1_2cc, reg_in1_3, reg_in1_4;
	
  reg [15:0] adder_in1, adder_in2;
  wire [15:0] adder_out;
  reg [15:0] mult_in1, mult_in2;
  wire [15:0] mult_out;

  wire [15:0] Instruction_In;


  //----------------------------------------------------------------------------------------
  //Registers
  P1_Reg R_In1
       (.DataIn(D_In1),
        .DataOut(reg_in1_0),
        .rst(Rst_In),
        .clk(Clk_In)
        );
  P1_Reg R1
       (.DataIn(reg_in1_0),
        .DataOut(reg_in1_1),
        .rst(Rst_In),
        .clk(Clk_In)
        );
  P1_Reg R2
       (.DataIn(reg_in1_1),
        .DataOut(reg_in1_2),
        .rst(Rst_In),
        .clk(Clk_In)
        );
  P1_Reg R3
       (.DataIn(mult_out),
        .DataOut(reg_in1_3),
        .rst(Rst_In),
        .clk(Clk_In)
        );
  P1_Reg R4
       (.DataIn(reg_in1_3),
        .DataOut(reg_in1_4),
        .rst(Rst_In),
        .clk(Clk_In)
        );

  //----------------------------------------------------------------------------------------
  //Combinational Logic
  P1_ADD P1_ADD_0
       (.data_a_i(adder_in1),
        .data_b_i(adder_in2),
        .data_o(adder_out));
  P1_Mult P1_MULT_0
       (.data_a_i(mult_in1),
        .data_b_i(mult_in2),
        .data_o(mult_out));
  

  //----------------------------------------------------------------------------------------
  //Adder MUX
  //INPUT 1
  always @(*) begin
	case(Instruction_In)
		16'b0000000000000010: adder_in1 = 16'b0;
		16'b0000000000000011: adder_in1 = 16'b0;
		default: adder_in1 = 16'b0;
	endcase
  end
  //INPUT 2
  always @(*) begin
	case(Instruction_In)
		16'b0000000000000010: adder_in2 = mult_out;
		16'b0000000000000011: adder_in2 = mult_out;
		default: adder_in2 = 16'b0;
	endcase
  end


  //----------------------------------------------------------------------------------------
  //Mult MUX
  //INPUT 1
  always @(*) begin
	case(Instruction_In)
		16'b0000000000000010: mult_in1 = reg_in1_2;
		16'b0000000000000011: mult_in1 = reg_in1_2;
		default: mult_in1 = 16'b0;
	endcase
  end
  //INPUT 2
  always @(*) begin
	case(Instruction_In)
		16'b0000000000000010: mult_in2 = 16'b1;
		16'b0000000000000011: mult_in2 = 16'b1;
		default: mult_in2 = 16'b0;
	endcase
  end


  //----------------------------------------------------------------------------------------
  //OUTPUT MUX
  always @(*) begin
	case(Instruction_In)
		16'b0000000000000001: D_Out = reg_in1_2;
		16'b0000000000000010: D_Out = reg_in1_4;
		default: D_Out = 16'b0;
	endcase
  end
endmodule