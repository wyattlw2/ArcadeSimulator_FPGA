//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
							  input					vga_clk,
							  input blank,
                       output logic [7:0]  Red, Green, Blue );
    
    logic ball_on;
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*Ball_Size, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 12 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	
	
    int DistX, DistY, Size, Sizex, Sizey;
	 
	 //new
	 logic [3:0] palette_red, palette_green, palette_blue;
	 logic [3:0] palette2_red, palette2_green, palette2_blue;

	 
	  
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;
	 
	 
	  
    always_comb
    begin:Ball_on_proc
        if ( ( DistX*DistX + DistY*DistY) <= (Size * Size) ) 
            ball_on = 1'b1;
        else 
            ball_on = 1'b0;
     end 
       
    always_comb
    begin:RGB_Display
        if ((ball_on == 1'b1) && (palette2_red < 4'b1111) && (palette2_green < 4'b1111) && (palette2_blue < 4'b1111)) 
        begin 
		  
			
				Red[7:4] = palette2_red;
				Red[3:0] = palette2_red;
				
					
				
            Green[7:4] = palette2_green;
				Green[3:0] = palette2_green;
				
					
				
            Blue[7:4] = palette2_blue;
				Blue[3:0] = palette2_blue;
	
			end       
        else 
        begin 
            Red[7:4] = palette_red;
				Red[3:0] = palette_red;
            Green[7:4] = palette_green;
				Green[3:0] = palette_green;
            Blue[7:4] = palette_blue;
				Blue[3:0] = palette_blue;
				
				
				
        end      
    end 
	

// sprite rendering for background/mario/enemies is all here

mahrio_example backgrnd ( // background sprites
	.vga_clk (vga_clk),
	.DrawX   (DrawX), 
	.DrawY   (DrawY),
	.blank   (blank),
	.red     (palette_red),
	.green   (palette_green),
	.blue    (palette_blue)
);

mario_example mario ( // mario sprite
	.vga_clk (vga_clk),
	.DrawX   (DrawX), 
	.DrawY   (DrawY),
	.XOffset (320 - DrawX),
	.blank   (blank),
	.red     (palette2_red),
	.green   (palette2_green),
	.blue    (palette2_blue)
);

    
endmodule
