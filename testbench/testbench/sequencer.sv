class cclu_sequencer extends uvm_sequencer#(cclu_sequence_item);
  `uvm_sequencer_utils(cclu_sequencer)
  //constructor
  function new ( string name, uvm_component parent)
    super.new(name,parent);
  endfunction: new
  
endclass: cclu_sequencer