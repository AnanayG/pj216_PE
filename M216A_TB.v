`timescale 1ns / 100ps

`define function1_instruction 16'b0000000000000001;
`define function2_instruction 16'b0000000000000010;
`define function3_instruction 16'b0000000000000011;
`define function4_instruction 16'b0000000000000100;
`define function5_instruction 16'b0000000000000101;
`define function6_instruction 16'b0000000000000110;
`define function7_instruction 16'b0000000000000111;
`define function8_instruction 16'b0000000000001000;



module M216A_TB();

reg [15:0] D_In1;
reg [15:0] D_In2;
reg [15:0] D_In3;
reg [15:0] Instruction_In;
reg clk;
reg rst;
//reg [4:0] Instruction_In;

wire [15:0] D_Out;

M216A_TopModule uut(
    .Clk_In(clk),
    .D_In1(D_In1),
    .D_In2(D_In2),
    .D_In3(D_In3),
    .D_Out(D_Out),
    .Instruction_In(Instruction_In),
    .Rst_In(rst)
);

always #1 clk = ~clk;
integer i;

initial begin
//Function 1: Out = D_In1; Latency = 2;
    rst = 1'b1;
    clk = 1'b1;
    D_In1 = 0;
    D_In2 = 0;
    D_In3 = 0;
    Instruction_In = `function1_instruction;
    #10;
    rst = 1'b0;
    for(i = 1; i < 12; i = i + 1)
    begin
        #2;
        D_In1 = i;
        D_In2 = i + 3;
        D_In3 = i + 7;
            $display("Function1_Output: %d",D_Out);
    end
    $display("Function1_Answer: 0,0,1,2,3,4,5,6,7,8,9");
    
//Function 2: Out = D_In1; Latency = 4;
    rst = 1'b1;
    clk = 1'b1;
    D_In1 = 0;
    D_In2 = 0;
    D_In3 = 0;
    Instruction_In = `function2_instruction;
    #10;
    rst = 1'b0;
    #1;
    for(i = 1; i < 12; i = i + 1)
    begin
        #2;
        D_In1 = i;
        D_In2 = i + 3;
        D_In3 = i + 7;
            $display("Function2_Output: %d",D_Out);
    end
    $display("Function2_Answer: 0,0,0,0,1,2,3,4,5,6,7");  
    
    //Function 3: Out = D_In2 + D_In3; Latency = 2;
    rst = 1'b1;
    clk = 1'b1;
    D_In1 = 0;
    D_In2 = 0;
    D_In3 = 0;
    Instruction_In = `function3_instruction;
    #10;
    rst = 1'b0;
    #1;
    for(i = 1; i < 12; i = i + 1)
    begin
        #2;
        D_In1 = i;
        D_In2 = i + 3;
        D_In3 = i + 7;
            $display("Function3_Output: %d",D_Out);
    end
    $display("Function3_Answer: 0,0,12,14,16,18,20,22,24,26,28");   
         
    //Function 4: Out = D_In1 * D_In2; Latency = 2;
    rst = 1'b1;
    clk = 1'b1;
    D_In1 = 0;
    D_In2 = 0;
    D_In3 = 0;
    Instruction_In = `function4_instruction;
    #10;
    rst = 1'b0;
    #1;
    for(i = 1; i < 12; i = i + 1)
    begin
        #2;
        D_In1 = i;
        D_In2 = i + 3;
        D_In3 = i + 7;
            $display("Function4_Output: %d",D_Out);
    end
    $display("Function4_Answer: 0,0,4,10,18,28,40,54,70,88,108");   
    

    //Function 5: Out = D_In1 + D_In2 * D_In3; Latency = 2;
    rst = 1'b1;
    clk = 1'b1;
    D_In1 = 0;
    D_In2 = 0;
    D_In3 = 0;
    Instruction_In = `function5_instruction;
    #10;
    rst = 1'b0;
    #1;
    for(i = 1; i < 12; i = i + 1)
    begin
        #2;
        D_In1 = i;
        D_In2 = i + 3;
        D_In3 = i + 7;
            $display("Function5_Output: %d",D_Out);
    end
    $display("Function5_Answer: 0,0,33,47,63,81,101,123,147,173,201");  
    
    
    //Function 6: Out = Out + D_In3 * 7; Latency = 2;
    rst = 1'b1;
    clk = 1'b1;
    D_In1 = 0;
    D_In2 = 0;
    D_In3 = 0;
    Instruction_In = `function6_instruction;
    #10;
    rst = 1'b0;
    #1;
    for(i = 1; i < 12; i = i + 1)
    begin
        #2;
        D_In1 = i;
        D_In2 = i + 3;
        D_In3 = i + 7;
            $display("Function6_Output: %d",D_Out);
    end
    $display("Function6_Answer: 0,0,56,119,189,266,350,441,539,644,756");  
    
    
    
    //Function 7: Out = D_In1[i - 1] * D_In1[i] + D_In1[i + 1]; Latency = 4;
    rst = 1'b1;
    clk = 1'b1;
    D_In1 = 0;
    D_In2 = 0;
    D_In3 = 0;
    Instruction_In = `function7_instruction;
    #10;
    rst = 1'b0;
    #1;
    for(i = 1; i < 12; i = i + 1)
    begin
        #2;
        D_In1 = i;
        D_In2 = i + 3;
        D_In3 = i + 7;
            $display("Function7_Output: %d",D_Out);
    end
    $display("Function7_Answer: 0,0,1,2,5,10,17,26,37,50,65");      
    
    
    //Function 8: temp[i] = D_In1[i] * D_In1[i + 1]; Out = Out + temp[i + 2] Latency = 6;
    rst = 1'b1;
    clk = 1'b1;
    D_In1 = 0;
    D_In2 = 0;
    D_In3 = 0;
    Instruction_In = `function8_instruction;
    #10;
    rst = 1'b0;
    #1;
    for(i = 1; i < 12; i = i + 1)
    begin
        #2;
        D_In1 = i;
        D_In2 = i + 3;
        D_In3 = i + 7;
            $display("Function8_Output: %d",D_Out);
    end
    $display("Function8_Answer: 0,0,0,0,0,0,2,8,20,40,70");  
end
    

endmodule
