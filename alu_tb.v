module alu_tb;

  // Inputs
  reg [3:0] ALUControl;
  reg [31:0] A;
  reg [31:0] B;

  // Outputs
  wire [31:0] ALUResult;
  wire Zero;

  // Instantiate the Unit Under Test (UUT)
  alu uut (
    .ALUControl(ALUControl), 
    .A(A), 
    .B(B), 
    .ALUResult(ALUResult), 
    .Zero(Zero)
  );

  // Test sequence
  initial begin
    // Initialize Inputs
    A = 32'h0;
    B = 32'h0;
    ALUControl = 4'h0;

    // Monitor values for debugging
    $monitor("ALUControl=%h, A=%h, B=%h, ALUResult=%h, Zero=%b", ALUControl, A, B, ALUResult, Zero);

    // Test AND operation (ALUControl = 0)
    A = 32'hFFFFFFFF; B = 32'h0F0F0F0F;
    ALUControl = 4'h0; // AND
    #10;

    // Test OR operation (ALUControl = 1)
    ALUControl = 4'h1; // OR
    #10;

    // Test ADD operation (ALUControl = 2)
    A = 32'h00000010; B = 32'h00000020;
    ALUControl = 4'h2; // ADD
    #10;

    // Test SUB operation (ALUControl = 6)
    A = 32'h00000050; B = 32'h00000020;
    ALUControl = 4'h6; // SUB
    #10;

    // Test SLT operation (ALUControl = 7)
    A = 32'h00000005; B = 32'h00000010;
    ALUControl = 4'h7; // SLT (Set Less Than)
    #10;

    // Test NOR operation (ALUControl = 3)
    A = 32'hFFFFFFFF; B = 32'h0F0F0F0F;
    ALUControl = 4'h3; // NOR
    #10;

    // Test MUL operation (ALUControl = 9)
    A = 32'h00000002; B = 32'h00000004;
    ALUControl = 4'h9; // MUL
    #10;

    // Test SLL operation (ALUControl = 10)
    A = 32'h00000001; B = 32'h00000003;
    ALUControl = 4'hA; // SLL (Shift Left Logical)
    #10;

    // Test SRA operation (ALUControl = 15)
    A = 32'h80000000; B = 32'h00000001;
    ALUControl = 4'hF; // SRA (Shift Right Arithmetic)
    #10;

    // Test XOR operation (ALUControl = 4)
    A = 32'h0F0F0F0F; B = 32'hF0F0F0F0;
    ALUControl = 4'h4; // XOR
    #10;

    // Test SLTU operation (ALUControl = 14)
    A = 32'h00000005; B = 32'h00000010;
    ALUControl = 4'hE; // SLTU (Set Less Than Unsigned)
    #10;

    // End simulation
    $finish;
  end

endmodule

