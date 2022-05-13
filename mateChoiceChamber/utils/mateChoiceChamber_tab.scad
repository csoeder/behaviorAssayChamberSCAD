eps =0.1;



//slider_height = 10;
//rail_height=15;
//rail_width = 2;
//rail_length=100;
//synchole_rad = 2;




//window_length = 10;
//window_height=12.5;
//
//window_location = 0.8 * rail_length; // later set this in relation to the chamber location
//
//tailhook_length = 7.5;
//tailhook_height = 7.5; // how far above does the tailhook protrude?




module slider(rail_height=15,rail_width =2,rail_length=100, synchole_rad = 2, window_length = 10, window_height=12.5, window_location = 80, tailhook_length = 7.5, tailhook_height = 7.5){

        difference(){
        
        union(){
            hull()
            {cube([rail_width, rail_length, rail_height]);
            translate([0,-rail_height/2,rail_height/2])rotate([0,90,0]) cylinder(h=rail_width, r=rail_height/2);


            } // the base form of the slider

            color(c=[0,0,1]) translate([0,rail_length-tailhook_length,(rail_height-eps)]) cube([rail_width, tailhook_length, tailhook_height+eps]);

            
        }



            color(c=[1,0,0])translate([-rail_width/2,-rail_height/2,rail_height/2])rotate([0,90,0]) cylinder(h=rail_width*2, r=synchole_rad);//cutout hole for grip, or to put a skewer through to pull both out at once

            color(c=[0,1,0]) translate([-rail_width/2,window_location,(rail_height-window_height)/2]) cube([rail_width*2, window_length, window_height]);//cutout window for the flies to go through
        }
}

slider();


