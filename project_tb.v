
module traffic_control_tb;

wire [2:0] n_lights,s_lights,e_lights,w_lights;
reg clk,rst_a;

traffic_control DUT (n_lights,s_lights,e_lights,w_lights,clk,rst_a);

always #5 clk = ~clk;

initial
 begin
  $dumpfile ("project.vcd");
  $dumpvars (0, traffic_control_tb );
 end 

initial
 begin
  rst_a=1'b1; clk=1'b1;
  #15;
  rst_a=1'b0;
 end


initial 
    begin 
	$display("	-------------------------------FIXED-TIME traffic lights controller--------------------------------");
	$display("	              Lights folow the following encoding: GREEN:001, YELOW:010, RED:100");
	$display("	    Light change order: N, S, E, W. Lights stay green for 8 clk cycles and yellow for 4 clk cycles.");
	$display("	---------------------------------------------------------------------------------------------------");
   	 $monitor("		Time=%d, clk=%b, reset=%b, NORTH=%b, SOUTH=%b, EAST=%b, WEST=%b", $time,clk,rst_a,n_lights,s_lights,e_lights,w_lights);
  	 #500  $finish;  
   end
endmodule