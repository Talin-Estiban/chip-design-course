// CCL
`define CCLUDepth 'd16 // this is the size of the stack
module CCLU	 ( input [1:0] command,
              input [31:0] address,
              input [31:0] counter, 
              input [31:0] inTarget,
              input reset,
              input clock,
              output reg [31:0] outTarget,
              output reg valid, 
              output reg full, 
              output reg error);
  
  // define stack 
  reg [31:0] CCladdress [`CCLUDepth];
  reg [31:0] count [`CCLUDepth];
  
  // define stack index/pointer
  reg [3:0] index=0;
  
  // main design
  always @ (posedge clock) begin
    
    // reset bit is 1 
    if (reset == 1) begin
      if (command == 2'b01 || command == 2'b10 || command == 2'b11) begin
        error <= 1;
        full<=0;
      	valid <= 0;
      end 

      else begin
        // empty the stack 
        index <= 0;
        error<=0;
      	outTarget <= 0;
        full<=0;
      	valid <= 0;
      end 
    end

        
    // reset bit is 0
    else if (reset == 0) begin
      if (command == 2'b00) begin
        valid<=0;
        error<=0;
        full <=0;
      end 
      else if ( command == 2'b11) begin
        error = 1;
      	valid <= 0;
        full=0;
      end
      else if ( command == 2'b01) begin
        // examine  top element and call task continue / task ccl
        if ( address == CCladdress[index] )
          continueTask;
        else if ( address != CCladdress[index] && !full)
          CCLTask;
      end
      else if (command == 2'b10) begin
        //call break task
        breakTask;
      end
       
    end
  end
  
  // continue task
  task automatic continueTask();
    full <= 0;
    valid <= 1;
    error<=0;
    outTarget <= inTarget;
    if ( count[index] == 1)begin
      index <= index-1;
      full<=0;
    end
    else begin
      count[index] <= count[index]-1;
      if (index == (`CLLUDepth-1))
        full<=1;
    end
  endtask: continueTask
  
  //CCL task
  task automatic CCLTask();
    if (index == (`CCLUDepth-1)) begin //examining if the stack is full before adding
      full <=1;
      error<=0;
    end
    else begin
      full<=0;
      if (counter == 0) begin
        error <=1;
      end
      else if ( counter ==1) begin
        outTarget<=inTarget;
        error <=0;
        valid<=1;
      end
      else begin
        CCladdress[index] <=address;
        count[index] <=counter-1;
        valid<=1;
        outTarget<=inTarget;
        error<=0;
        index<=index+1;
      end
    end
  endtask: CCLTask
  
  // break task
  task automatic breakTask();
    if (index==0) begin
      full<=0;
      error<=1;
      valid<=0;
    end
    else begin
      full<=0;
      valid<=0;
      outTarget<=inTarget;
      error<=0;
      index<=index-1;
    end
  endtask: breakTask

endmodule: CCLU

      
         
    