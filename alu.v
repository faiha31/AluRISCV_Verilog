module alu(ALUControl, A, B, ALUResult, Zero);

    input   [3:0]   ALUControl;   // control bits for ALU operation
    input   [31:0]  A, B;         // inputs
    integer         temp, i, x;
    reg     [31:0]  y;
    reg             sign;
    output  reg     [31:0]  ALUResult;  // answer
    output  reg     Zero;               // Zero=1 if ALUResult == 0

    always @(ALUControl, A, B) begin
        case (ALUControl)
            4'b0000: // AND
                ALUResult <= A & B;
            4'b0001: // OR
                ALUResult <= A | B;
            4'b0010: // ADD
                ALUResult <= A + B;
            4'b0110: // SUB
                ALUResult <= A + (~B + 1);
            4'b0111: begin // SLT
                if (A[31] != B[31]) begin
                    if (A[31] > B[31])
                        ALUResult <= 1;
                    else
                        ALUResult <= 0;
                end else begin
                    if (A < B)
                        ALUResult <= 1;
                    else
                        ALUResult <= 0;
                end
            end
            4'b0011: // NOR
                ALUResult <= ~(A | B);
            4'b1001: // MUL
                ALUResult <= A * B;
            4'b1010: // SLL
                ALUResult <= A << B;
            4'b1011: begin // SGT - Set Greater Than
                if (A[31] != B[31]) begin
                    if (A[31] > B[31])
                        ALUResult <= 0;
                    else
                        ALUResult <= 1;
                end else begin
                    if (A <= B)
                        ALUResult <= 0;
                    else
                        ALUResult <= 1;
                end
            end
            4'b1100: begin // CLO/CLZ
                x = B;
                temp = 32;
                for (i = 31; i >= 0; i = i - 1) begin
                    if (A[i] == x) begin
                        temp = 31 - i;
                        i = -2;
                    end
                end
                ALUResult <= temp;
            end
            4'b1101: begin // ROTR & SRL
                y = A;
                for (i = B[4:0]; i > 0; i = i - 1) begin
                    if (B[5] == 1)
                        y = {y[0], y[31:1]};
                    else
                        y = {1'b0, y[31:1]};
                end
                ALUResult <= y;
            end
            4'b0100: // XOR
                ALUResult <= A ^ B;
            4'b1110: // SLTU
                ALUResult <= A < B;
            4'b0101: begin // Sign Extension
                if (B == 0) begin // Byte 
                    if (A[7] == 1)
                        ALUResult <= {24'hffffff , A};
                    else
                        ALUResult <= A;
                end else if (B == 1) begin // Half word
                    if (A[15] == 1)
                        ALUResult <= {16'hffff , A};
                    else
                        ALUResult <= A;
                end
            end
            4'b1111: begin // SRA
                y = A;
                for (i = B; i > 0; i = i - 1) begin
                    y = {y[31], y[31:1]};
                end
                ALUResult <= y;
            end
        endcase
    end

    always @(ALUResult) begin
        if (ALUResult == 0)
            Zero <= 1;
        else
            Zero <= 0;
    end

endmodule
