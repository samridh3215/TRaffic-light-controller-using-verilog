
// Creating module for a FIXED-TIME traffic lights contorller for a 4 way intersection:

// Light change order: N, S, E, W.
// Here green light stays on for 8 clock cycles and turns yellow for 4 clock cycles
// and then turns red till the next time it becomes green again.
// Lights foloow the following encoding: GREEN:001, YELOW:010, RED:100 

module traffic_control(n_lights,s_lights,e_lights,w_lights,clk,rst_a);

   output reg [2:0] n_lights,s_lights,e_lights,w_lights; 
   input      clk;
   input      rst_a;
 
   reg [2:0] state;
 
   // Encoding for traffic light signals:
   parameter [2:0] north=3'b000;
   parameter [2:0] north_y=3'b001;
   parameter [2:0] south=3'b010;
   parameter [2:0] south_y=3'b011;
   parameter [2:0] east=3'b100;
   parameter [2:0] east_y=3'b101;
   parameter [2:0] west=3'b110;
   parameter [2:0] west_y=3'b111;

   // For counting the clock cycles:
   reg [2:0] count;
 
   always @(posedge clk, posedge rst_a)
     begin

         // On reset signal north shall have green light and counter starts from 0
        if (rst_a)
            begin
                state=north;
                count =3'b000;
            end

        else
            begin
                case (state)
                north :
                    begin
                        // if 8 clock signals have passed switch to yellow and reset count
                        if (count==3'b111)
                            begin
                            count=3'b000;
                            state=north_y;
                            end
                        // otherwise increment count and stay green
                        else
                            begin
                            count=count+3'b001;
                            state=north;
                            end
                    end

                north_y :
                    begin
                        // if 4 clock signals have passed switch to next green and reset count
                        if (count==3'b011)
                            begin
                            count=3'b000;
                            state=south;
                            end
                        // otherwise increment count and stay yellow
                        else
                            begin
                            count=count+3'b001;
                            state=north_y;
                            end
                    end

               south :
                    begin
                        // if 8 clock signals have passed switch to yellow and reset count
                        if (count==3'b111)
                            begin
                            count=3'b0;
                            state=south_y;
                            end
                        // otherwise increment count and stay green
                        else
                            begin
                            count=count+3'b001;
                            state=south;
                            end
                    end

            south_y :
                begin
                     // if 4 clock signals have passed switch to next green and reset count
                    if (count==3'b011)
                        begin
                        count=3'b0;
                        state=east;
                        end
                     // otherwise increment count and stay yellow
                    else
                        begin
                        count=count+3'b001;
                        state=south_y;
                        end
                    end

            east :
                begin
                     // if 8 clock signals have passed switch to yellow and reset count
                    if (count==3'b111)
                        begin
                        count=3'b0;
                        state=east_y;
                        end
                     // otherwise increment count and stay green
                    else
                        begin
                        count=count+3'b001;
                        state=east;
                        end
                    end

            east_y :
                begin
                     // if 4 clock signals have passed switch to next green and reset count
                    if (count==3'b011)
                        begin
                        count=3'b0;
                        state=west;
                        end
                     // otherwise increment count and stay yellow
                    else
                        begin
                        count=count+3'b001;
                        state=east_y;
                        end
                    end

            west :
                begin
                     // if 8 clock signals have passed switch to yellow and reset count
                    if (count==3'b111)
                        begin
                        state=west_y;
                        count=3'b0;
                        end
                     // otherwise increment count and stay green
                    else
                        begin
                        count=count+3'b001;
                        state=west;
                        end
                    end

            west_y :
                begin
                     // if 4 clock signals have passed switch to next green and reset count
                    if (count==3'b011)
                        begin
                        state=north;
                        count=3'b0;
                        end
                     // otherwise increment count and stay yellow
                    else
                        begin
                        count=count+3'b001;
                        state=west_y;
                        end
                    end
            endcase // case (state)
        end // else block
    end // always @ (posedge clk, posedge rst_a)


always @(state)
     begin
         case (state)
            
            north : // north G rest R
                begin
                    n_lights = 3'b001;
                    s_lights = 3'b100;
                    e_lights = 3'b100;
                    w_lights = 3'b100;
                end // case: north

            north_y : // north Y rest R
                begin
                    n_lights = 3'b010;
                    s_lights = 3'b100;
                    e_lights = 3'b100;
                    w_lights = 3'b100;
                end // case: north_y

            south : // south G rest R
                begin
                    n_lights = 3'b100;
                    s_lights = 3'b001;
                    e_lights = 3'b100;
                    w_lights = 3'b100;
                end // case: south

            south_y : // south Y rest R
                begin
                    n_lights = 3'b100;
                    s_lights = 3'b010;
                    e_lights = 3'b100;
                    w_lights = 3'b100;
                end // case: south_y

            west : // west G rest R
                begin
                    n_lights = 3'b100;
                    s_lights = 3'b100;
                    e_lights = 3'b100;
                    w_lights = 3'b001;
                end // case: west

            west_y : // west Y rest R
                begin
                    n_lights = 3'b100;
                    s_lights = 3'b100;
                    e_lights = 3'b100;
                    w_lights = 3'b010;
                end // case: west_y

            east : // east G rest R
                begin
                    n_lights = 3'b100;
                    s_lights = 3'b100;
                    e_lights = 3'b001;
                    w_lights = 3'b100;
                end // case: east

            east_y : // east Y rest R
                begin
                    n_lights = 3'b100;
                    s_lights = 3'b100;
                    e_lights = 3'b010;
                    w_lights = 3'b100;
                end // case: east_y
            endcase // case (state)
     end // always @ (state)
endmodule