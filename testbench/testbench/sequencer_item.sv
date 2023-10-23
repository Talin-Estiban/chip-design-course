class cclu_sequence_item extends uvm_sequence_item ;
  
  //control/payload information
  rand bit [1:0] command;
  rand int [31:0] unsigned address;
  rand int [31:0] unsigned counter;
  rand int [31:0] unsigned inTarget;
  rand bit reset;
  
  //analysis information
  int [31:0] unsigned outTarget;
  bit valid;
  bit full;
  bit eroor;
  
  //constructor for initializing variables
  function new ( string name ="cclu_sequence_item")
    super.new(name)
  endfunction: new
  
endclass: cclu_sequence_item