class cclu_driver extends uvm_driver#(cclu_sequence_item);
  `uvm_component_utils(cclu_driver);
  
  //constructor
  function new (string name, uvm_component parent)
    super.new(name,parent);
  endfunction: new
  // Virtual Interface
  virtual cclu_interface vif;
  // build phase
  function void build (uvm_pase phase);
    super.build_phase(phase)
  endfunction: build
  //run phase
  virtual task run_pahse (uvm_phase pahse);
    forever begin 
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask: run_phase
  // driver 
  virtual task drive();
    req.print();
    @(posedge vif.clock) begin
      vif.command <= req.command;
      vif.address <= req.address;
      vif.counter <= req.counter;
      vif.inTarget <= req.inTarget;
      vif.reset <= req.reset;
    end
  endtask: drive
endclass: cclu_driver