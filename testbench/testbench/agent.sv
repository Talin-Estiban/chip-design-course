class cclu_agent extends uvm_agent;
  `uvm_component_utils(cclu_agent);
  
  //constructor
  function new (string name, uvm_component parent)
    super.new(name,parent);
  endfunction:new
  
  // instances of driver+sequencer+monitor
  cclu_driver driver;
  cclu_sequencer sequencer;
  cclu_monitor monitor;
  
  //build phase(creating components)
  function void build_phase (uvm_phase, phase)
    super.build_phase(phase);
    driver=cclu_driver::type_id::create("driver",this);
    sequencer=cclu_sequencer::type_id::create("sequencer",this);
    monitor=cclu_monitor::type_id::create("monitor",this);
  endfunction:build_phase
  
  //connect phase that connects driver to sequencer
  function void connect_phase(uvm_phase phase)
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction:connect_phase
endclass: cclu_agent