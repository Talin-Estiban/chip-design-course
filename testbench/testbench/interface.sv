interface cclu_interface (input logic clk)
  logic [1:0] command;
  logic [31:0] address;
  logic [31:0] counter;
  logic [31:0] inTarget;
  logic reset;
  
  logic [31:0] outTarget;
  logic valid;
  logic full;
  logic error;
  
endinterface: cclu_interface