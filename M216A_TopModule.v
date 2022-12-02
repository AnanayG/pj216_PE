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
  // Declarations
  
  wire [15:0] reg_in1_0, reg_in2_0, reg_in3_0; 
  wire [15:0] reg_in1_1, reg_in1_2, reg_in1_3, reg_in1_4;
  wire [15:0] reg_mult_out_3, reg_mult_out_4;

  wire [15:0] reg_constant1, reg_constant2, reg_constant3;
  reg  [15:0] reg_in1_input;
	
  reg [15:0] adder_in1;
  wire [15:0] adder_out, adder_in2;
  reg [15:0] mult_in1, mult_in2;
  wire [15:0] mult_out;

  wire [15:0] Instruction_In;

  //----------------------------------------------------------------------------------------
  // Parameters

  parameter func1_ins = 16'b0000000000000001;
  parameter func2_ins = 16'b0000000000000010;
  parameter func3_ins = 16'b0000000000000011;
  parameter func4_ins = 16'b0000000000000100;
  parameter func5_ins = 16'b0000000000000101;
  parameter func6_ins = 16'b0000000000000110;
  parameter func7_ins = 16'b0000000000000111;
  parameter func8_ins = 16'b0000000000001000;

  parameter CONSTANT_7  = 16'd7;
  parameter CONSTANT_1  = 16'd1;
  parameter CONSTANT_0  = 16'd0;
  //----------------------------------------------------------------------------------------
  //Stage Registers
  P1_Reg R1
       (.DataIn(reg_in1_input),
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
       (.DataIn(adder_out),
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

  //in1 registers - func8 - THIS FLUSHES OUT THE TWO FIRST VALUES FOR FUNC8
  P1_Reg constant_reg_1
       (.DataIn(16'b1),
        .DataOut(reg_constant1),
        .rst(Rst_In),
        .clk(Clk_In)
        );
  P1_Reg constant_reg_2
       (.DataIn(reg_constant1),
        .DataOut(reg_constant2),
        .rst(Rst_In),
        .clk(Clk_In)
        );
  P1_Reg constant_reg_3
       (.DataIn(reg_constant2),
        .DataOut(reg_constant3),
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
  //Input Lines
  assign reg_in1_0 = D_In1;
  assign reg_in2_0 = D_In2;
  assign reg_in3_0 = D_In3;

  //----------------------------------------------------------------------------------------
  //Adder MUX
  //INPUT 1
  always @(*) begin
	case(Instruction_In)
		func2_ins, func4_ins	: adder_in1 = CONSTANT_0;
		func3_ins		: adder_in1 = reg_in2_0;
		func5_ins, func7_ins	: adder_in1 = reg_in1_0;
		func6_ins, func8_ins    : adder_in1 = reg_in1_3;
		default			: adder_in1 = CONSTANT_0;
	endcase
  end

  //INPUT 2 - always connected to the MULT
  assign  adder_in2 = mult_out;

  //----------------------------------------------------------------------------------------
  //Mult MUX
  //INPUT 1
  always @(*) begin
	case(Instruction_In)
		func2_ins			: mult_in1 = reg_in1_2;
		func4_ins			: mult_in1 = reg_in1_0;
		func5_ins, func6_ins, func3_ins	: mult_in1 = reg_in3_0;
		func7_ins, func8_ins		: mult_in1 = reg_in1_2;
		default			: mult_in1 = CONSTANT_0;
	endcase
  end
  //INPUT 2
  always @(*) begin
	case(Instruction_In)
		func2_ins, func3_ins	: mult_in2 = CONSTANT_1;
		func6_ins		: mult_in2 = CONSTANT_7;
		func4_ins, func5_ins	: mult_in2 = reg_in2_0;
		func7_ins, func8_ins    : mult_in2 = reg_in1_1;
		default			: mult_in2 = CONSTANT_0;
	endcase
  end

  //----------------------------------------------------------------------------------------
  //INPUT1 MUX - func8
  always @(*) begin
	case(reg_constant3)
		1'b1	: reg_in1_input = reg_in1_0;
		default : reg_in1_input = (Instruction_In == func8_ins)? CONSTANT_0: reg_in1_0;
	endcase
  end

  //----------------------------------------------------------------------------------------
  //OUTPUT MUX
  always @(*) begin
	case(Instruction_In)
		func1_ins: D_Out = reg_in1_2;
		default: D_Out = reg_in1_4;
	endcase
  end
endmodule
