class cclu_monitor extends uvm_monitor;
  `uvm_component_utils(cclu_monitor);
  //virtual interface
  virtual cclu_interface vif;
  // declare analysis port that transmits seq items
  uvm_analysis_port#(cclu_sequence_item) item_collected_port;
  // placeholder for seq item 
  cclu_sequence_item trans_collected;
  //constructor
  function void new ( string name, uvm_component parent)
    super.new(name,parent);
    trans_collected=new(); //create sequence item inside placeholder
    item_collected_port=new("item_collected_port",this)//instance of analysis port
  endfunction:new
  //build phase 
  function build_pahse(uvm_pahse phase)
    super.build_phase(phase);
  endfunction: build_phase
  //run phase
  virtual task run_phase(uvm_phase phase)
    item_collected_port.write(trans_collected);// write the transsaction into the port
  endtask:run_phase
endclass: cclu_monitor