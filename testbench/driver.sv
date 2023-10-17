class cclu_driver extends uvm_driver#(cclu_sequence_item);
  `uvm_component_utils(cclu_driver);
  
  //constructor
  function new (string name, uvm_component parent)
    super.new(name,parent);
  endfunction: new
  // Virtual Interface
  virtual cclu_interface vif;
  // build phase
  virtual function void build (uvm_pase phase);
    super.build_phase(phase)
  endfunction: build
  //run phase
  // driver 
endclass: cclu_driver