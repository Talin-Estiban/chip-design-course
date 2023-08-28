// CCL
`define CCLUDepth 'd16 // this is the size of the stack
module CCLU	 ( input [1:0] command,
              input [31:0] address,
              input [31:0] counter, 
              input [31:0] inTarget,
              input bit reset,
              input clock,
              output reg [31:0] outTarget,
              output reg valid, 
              output reg full, 
              output reg error)
  
  // define stack 
  reg [31:0] CCladdress [`CCLUDepth];
  reg [31:0] count [`CCLUDepth];
  
  // define stack index/pointer
  reg [3:0] index=0;
  
  // main design
  always @ (posedge clock) begin
    
    // reset bit is 1 
    if (reset == 1'b1) begin
      if (command == 2'b01 || command == 2'b10 || command == 2'b11) begin
        error=1'b1;
      	outTarget <= 32'b0;
        full<=1'b0;
      	valid <= 1'b0;
      end 

      else begin
        // empty the stack 
        index <= 0;
        error<=1'b0;
      	outTarget <= 32'b0;
        full<=1'b0;
      	valid <= 1'b0;
      end 
    end

        
    // reset bit is 0
    else if (reset == 1'b0) begin
      if (command == 2'b00) begin
        valid<=1'b0;
        error<=1'b0;
      end 
      else if ( command == 2'b11) begin
        error = 1'b1;
      	valid <= 1'b0;
      end
      else if ( command == 2'b10) begin
        // examine  top element and call task continue / task ccl
        error <= 1'b0;
        if ( address == CCLaddress[index] && !full)
          continueTask();
        else if ( address != CCLaddress[index])
          CCLTask();
      end
      else if (command == 2'b01) begin
        //call break task
        breakTask();
      end
       
    end
  end
  
  // continue task
  task automatic continueTask ();
    full <= 1'b0;
    valid <= 1'b1;
    outTarget <= inTarget;
    if ( count[index] == 1'b1)
      index<=index-1;
    else 
      count[index] <= count[index]-1;

  endtask
  
  //CCL task
  task automatic CCLTask ();
    if (count[index] == 1'b0) begin
        error = 1'b1;
        valid<= 1'b0;
        full<=1'b0;
      end
    else if (count[index] == 1'b1) begin
        index<=index-1;
        error<=1'b0;
        valid<=1'b1;
        outTarget<=inTarget;
        full<=1'b0;
    end
    else if ( index==16) begin
        full<=1'b1;
        error<=1'b1;
        valid<=1'b0;
    end
    else begin
        count[index+1]<=counter-1;
      	CCLaddress[index+'d1] <= address;
        outTarget<=inTarget;
        valid<=1'b1;
        full<=1'b0;
    end
  endtask
  
  // break task
  task automatic breakTask();
     full<=1'b0;
     valid<=1'b0;
     outTarget<=inTarget;
     error<=1'b0;
     index=index-1;
  endtask

endmodule

      
         
    