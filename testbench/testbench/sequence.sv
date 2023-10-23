class cclu_sequence extends uvm_sequence#(cclu_sequence_item);
  
  `uvm_object_utils(cclu_sequence);//allows series of operations to register and configure a UVM object
  
  // contructor 
  function new(string name="cclu_sequence");
    super.new(name);
  endfunction: new
  
  virtual task body();
    req = cclu_sequence_item::type_id::create("req");// create sequence item
    wait_for_grant();//blokck until grant
    assert(item.randomize());//randomize sequence item
    send_request(req);//sequence item->sequencer->driver
    wait_for_item_done();//block until response from driver
    get_respone(rsp);//receiving responce from driver 
  endtask: body
  
endclass