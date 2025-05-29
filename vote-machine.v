module vote(
    input but1, but2, but3, but4, clk, reset, auth_pin, // Authentication PIN for security
    output reg [3:0] votecounta, votecountb, votecountc, votecountd,
    output reg [6:0] displayA, displayB, displayC, displayD, // Display outputs for vote counts
    output reg uart_tx // UART output for serial communication
);

    // Parameters and variables
    parameter VOTE_LIMIT = 4'd1; // One vote per candidate
    parameter MAX_VOTER_TURNOUT = 4'd10; // Max votes allowed across all candidates
    parameter TIMEOUT = 50000000; // 1-second timeout for reset
    reg [3:0] total_votes; // Count total votes for turnout control
    reg [25:0] timer;  // Counter for timeout

    // Debounce and voting control variables
    reg [2:0] debounce_but1, debounce_but2, debounce_but3, debounce_but4;
    reg votedA, votedB, votedC, votedD; // Flags to limit to one vote per candidate
    reg auth_granted; // Flag for authentication status

    initial begin
        votecounta = 4'b0;
        votecountb = 4'b0;
        votecountc = 4'b0;
        votecountd = 4'b0;
        total_votes = 4'b0;
        votedA = 1'b0;
        votedB = 1'b0;
        votedC = 1'b0;
        votedD = 1'b0;
        auth_granted = 1'b0;
    end

    // Authentication Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            auth_granted <= 1'b0;
        end else if (auth_pin == 1'b1) begin // Simple auth condition
            auth_granted <= 1'b1;
        end
    end

    // Debounce Logic for Each Button
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            debounce_but1 <= 3'b000;
            debounce_but2 <= 3'b000;
            debounce_but3 <= 3'b000;
            debounce_but4 <= 3'b000;
        end else begin
            debounce_but1 <= {debounce_but1[1:0], but1};
            debounce_but2 <= {debounce_but2[1:0], but2};
            debounce_but3 <= {debounce_but3[1:0], but3};
            debounce_but4 <= {debounce_but4[1:0], but4};
        end
    end

    // Clean signals from debounce
    wire clean_but1 = (debounce_but1 == 3'b111);
    wire clean_but2 = (debounce_but2 == 3'b111);
    wire clean_but3 = (debounce_but3 == 3'b111);
    wire clean_but4 = (debounce_but4 == 3'b111);

    // Vote Counting and Turnout Control with One-Vote Restriction
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            votecounta <= 4'b0;
            votecountb <= 4'b0;
            votecountc <= 4'b0;
            votecountd <= 4'b0;
            total_votes <= 4'b0;
            timer <= 0;
            votedA <= 1'b0;
            votedB <= 1'b0;
            votedC <= 1'b0;
            votedD <= 1'b0;
        end else if (auth_granted) begin
            timer <= timer + 1;
            
            // Vote for each candidate only if total votes are below the max turnout
            if (clean_but1 && !votedA && total_votes < MAX_VOTER_TURNOUT) begin
                votecounta <= votecounta + 1;
                votedA <= 1'b1;
                total_votes <= total_votes + 1;
            end
            if (clean_but2 && !votedB && total_votes < MAX_VOTER_TURNOUT) begin
                votecountb <= votecountb + 1;
                votedB <= 1'b1;
                total_votes <= total_votes + 1;
            end
            if (clean_but3 && !votedC && total_votes < MAX_VOTER_TURNOUT) begin
                votecountc <= votecountc + 1;
                votedC <= 1'b1;
                total_votes <= total_votes + 1;
            end
            if (clean_but4 && !votedD && total_votes < MAX_VOTER_TURNOUT) begin
                votecountd <= votecountd + 1;
                votedD <= 1'b1;
                total_votes <= total_votes + 1;
            end

            // Timeout reset logic
            if (timer >= TIMEOUT) begin
                votecounta <= 4'b0;
                votecountb <= 4'b0;
                votecountc <= 4'b0;
                votecountd <= 4'b0;
                timer <= 0;
                total_votes <= 4'b0;
                votedA <= 1'b0;
                votedB <= 1'b0;
                votedC <= 1'b0;
                votedD <= 1'b0;
            end
        end
    end

    // Display Logic (Assign counts to displays)
    always @(*) begin
        displayA = votecounta;
        displayB = votecountb;
        displayC = votecountc;
        displayD = votecountd;
    end

    // Serial Communication (UART Transmission of Vote Counts)
    always @(posedge clk) begin
        if (auth_granted) begin
            uart_tx <= votecounta + votecountb + votecountc + votecountd; // Simple UART transmission example
        end
    end

endmodule
