class cclu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(cclu_scoreboard)
  
  //constructor
  function new (string name, uvm_component parent)
    super.new(name,parent);
  endfunction: new
  
  //creating scoreboard export port
  uvm_analysis_imp#(cclu_sequence_item, cclu_scoreboard) item_collected_export;
   
  //build pahse
  function void build_phase(uvm_phase phase)
    super.build_phase(phase);
    item_collected_export=new("item_collected_export",this);
  endfunction:build_phase
  
  //write 
  virtual function void write(cclu_sequence_item pkt)
    pkt.print();
  endfunction: write
endclass: cclu_scoreboard