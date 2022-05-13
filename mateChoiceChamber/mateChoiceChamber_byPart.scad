eps =0.1;
$fn=250;

module dish(outer_dia = 100, wall_thk = 1, height = 10) {
    
    difference(){
    cylinder(h = height, r = outer_dia/2);

    translate([0,0,wall_thk])cylinder(h = height + wall_thk, r = outer_dia/2-wall_thk);
    
    }
}





slider_height = 10;
rail_height=15;
rail_width = 2;
rail_length=100;
synchole_rad = 2;

window_length = 10;
window_height=12.5;
window_location = 0.6 * rail_length; // later set this in relation to the chamber location

tailhook_length = 7.5;
tailhook_height = 7.5; // how far above does the tailhook protrude?

side_chamber_rad = 37.0/2;
central_chamber_rad = 56.0/2;
chamber_spacing=3;

// as well as two slot rails for the tabs to slide in

rail_enclosure_length = 100;
rail_enclosure_width = 10;

floor_thick = 5;

//block_height = 33;

bottom_bowl_depth_side = 11;
ledge_height= 2.5; 
bottom_bowl_depth_center = 15;
//ledge_height_center = 2.5; 
flyzone = window_height;
ledge_rad_side = 40.0/2;
ledge_rad_center = 59.5/2;

window_offset = window_length/2;

block_height = max(bottom_bowl_depth_side, bottom_bowl_depth_center) +floor_thick  + window_height + ledge_height;

punchrad = 10; // radius of punch thru bottom 

duv_length =5;
duv_width=3;
bite_width=1.5;
duv_height=10;
duv_bite = 5;

clp_length =rail_enclosure_width+duv_length-duv_bite;//20;//rail_enclosure_width + duv_length
clp_width =duv_width;
clp_height=5;


use <utils/mateChoiceChamber_assClip.scad>;

//translate([duv_width+ central_chamber_rad+rail_enclosure_width/2-duv_bite,25,0])rotate([0,0,-90])color([0,0,1])assemblyClip(side_length=duv_length, side_width=duv_width, side_height=duv_height, clip_len = clp_length, clip_width=clp_width, clip_height=clp_height, inbite = duv_bite);


use <utils/mateChoiceChamber_tab.scad>;

//slider(rail_height=rail_height,rail_width = rail_width,rail_length = rail_length, synchole_rad=synchole_rad,window_length=window_length,window_height=window_height, window_location=window_location, tailhook_length=tailhook_length,tailhook_height=tailhook_height);


//the big block

//  consists of three chambers; suitor left, suitor right, center stage


use <utils/mateChoiceChamber_bigBlock.scad>;
//bigBlock();
//translate([0,0,333])bigBlock(block_height = block_height,side_chamber_rad = side_chamber_rad , central_chamber_rad = central_chamber_rad , chamber_spacing=chamber_spacing, rail_enclosure_length = rail_enclosure_length, rail_enclosure_width = rail_enclosure_width );




module cutout(side_chamber_rad=25,central_chamber_rad=50, chamber_spacing=5,bottom_bowl_depth_side=12.5, bottom_bowl_depth_center = 15,ledge_height= 2.5, flyzone=12.5, window_length= 10, window_offset=5,rail_height=15,rail_width = 2,rail_length = 100, window_location = 80, punchrad = 10, floor_thick=3){

    total_side_depth = bottom_bowl_depth_side + flyzone+ledge_height;

    total_center_depth = bottom_bowl_depth_center + flyzone+ledge_height;

    union(){
    translate([0,0,ledge_height])union(){
    translate([-side_chamber_rad-central_chamber_rad - chamber_spacing,0,0])cylinder(r=side_chamber_rad+eps, h=total_side_depth +eps);

    translate([side_chamber_rad +central_chamber_rad + chamber_spacing,0,0])cylinder(r=side_chamber_rad+eps,h=total_side_depth+eps);

    translate([0,0,0])cylinder(r=central_chamber_rad+eps,h=total_center_depth +eps);
    }
    //wells where the dishes sit

    translate([0,0,0])union(){
    translate([-side_chamber_rad-central_chamber_rad - chamber_spacing,0,0])cylinder(r=ledge_rad_side+eps, h=ledge_height+eps);
    translate([side_chamber_rad +central_chamber_rad + chamber_spacing,0,0])cylinder(r=ledge_rad_side+eps, h=ledge_height+eps);
    translate([0,0,0])cylinder(r=ledge_rad_center+eps, h=ledge_height+eps);
    }
    // ledges where the lids sit

    
    translate([0,0,ledge_height])union(){
    translate([-rail_width/2 + central_chamber_rad + chamber_spacing/2 - eps,-window_location+window_offset,-ledge_height])cube([rail_width+2*eps,rail_length,rail_height+ledge_height]);


       translate([eps-rail_width/2 - central_chamber_rad - chamber_spacing/2,-window_location+window_offset,-ledge_height])cube([rail_width+2*eps,rail_length,rail_height+ledge_height]);
        } 
        // cutout the slots where the rails will slide....


    color([1,0,0])translate([-side_chamber_rad-central_chamber_rad,-window_length/2,(rail_height-window_height)/2])cube([2*side_chamber_rad+2*central_chamber_rad,window_length,ledge_height+window_height]);
    // make sure there's ample walkway for the varmints
     

    union(){
     
    translate([duv_width+ central_chamber_rad+rail_enclosure_width/2-duv_bite,rail_length-window_location-window_offset-tailhook_length-clp_width/2,ledge_height])rotate([0,0,-90])color([0,0,1])assemblyClip(side_length=duv_length, side_width=duv_width, side_height=duv_height, clip_len = clp_length, clip_width=clp_width, clip_height=clp_height, inbite = duv_bite); 
    
    translate([duv_width+ central_chamber_rad+rail_enclosure_width/2-duv_bite,-(rail_length-window_location-window_offset-tailhook_length-clp_width/2),ledge_height])rotate([0,0,-90])color([0,0,1])assemblyClip(side_length=duv_length, side_width=duv_width, side_height=duv_height, clip_len = clp_length, clip_width=clp_width, clip_height=clp_height, inbite = duv_bite); 
    
    translate([-(duv_width+ central_chamber_rad+rail_enclosure_width/2-duv_bite),-(rail_length-window_location-window_offset-tailhook_length-clp_width/2),ledge_height])rotate([0,0,90])color([0,0,1])assemblyClip(side_length=duv_length, side_width=duv_width, side_height=duv_height, clip_len = clp_length, clip_width=clp_width, clip_height=clp_height, inbite = duv_bite); 
    
    translate([-(duv_width+ central_chamber_rad+rail_enclosure_width/2-duv_bite),(rail_length-window_location-window_offset-tailhook_length-clp_width/2),ledge_height])rotate([0,0,90])color([0,0,1])assemblyClip(side_length=duv_length, side_width=duv_width, side_height=duv_height, clip_len = clp_length, clip_width=clp_width, clip_height=clp_height, inbite = duv_bite);     
    }
    //cut out the clip slots


    center_punch_height = floor_thick+2*eps;
    center_punch_depth = ledge_height+bottom_bowl_depth_center+flyzone+eps;

    side_punch_height = bottom_bowl_depth_center - bottom_bowl_depth_side + floor_thick+2*eps;
    side_punch_depth = flyzone+bottom_bowl_depth_side+ledge_height-eps;

    union(){
    translate([0,0, center_punch_depth])cylinder(r=punchrad, h = center_punch_height);

    translate([0,0,0])translate([central_chamber_rad+side_chamber_rad+chamber_spacing,0,side_punch_depth+eps])cylinder(r=punchrad, h = side_punch_height);

    translate([-(central_chamber_rad+side_chamber_rad+chamber_spacing),0,side_punch_depth+eps])cylinder(r=punchrad, h = side_punch_height);

    }
    // punches for the finger holes

    }



}









module mainBody(){
difference(){
translate([0,0,0])color([0,1,0])bigBlock(block_height = block_height,side_chamber_rad = side_chamber_rad , central_chamber_rad = central_chamber_rad , chamber_spacing=chamber_spacing, rail_enclosure_length = rail_enclosure_length, rail_enclosure_width = rail_enclosure_width );


translate([0,0,-eps])  cutout(side_chamber_rad=side_chamber_rad,central_chamber_rad=central_chamber_rad, chamber_spacing=chamber_spacing,rail_height=rail_height,rail_width = rail_width,rail_length = rail_length, window_location=window_location, window_offset = window_offset,bottom_bowl_depth_side=bottom_bowl_depth_side, bottom_bowl_depth_center = bottom_bowl_depth_center , punchrad = punchrad , floor_thick = floor_thick);

}}
    
//main body of the chamber
mainBody();

// four assembly clips
translate([-75,75,0])rotate([0,90,0])assemblyClip(side_length=duv_length, side_width=duv_width, side_height=duv_height, clip_len = clp_length, clip_width=clp_width, clip_height=clp_height, inbite = duv_bite, biteWidth = bite_width);

translate([-75,50,0])rotate([0,90,0])assemblyClip(side_length=duv_length, side_width=duv_width, side_height=duv_height, clip_len = clp_length, clip_width=clp_width, clip_height=clp_height, inbite = duv_bite, biteWidth = bite_width);

translate([75,-50,0])rotate([180,90,0])assemblyClip(side_length=duv_length, side_width=duv_width, side_height=duv_height, clip_len = clp_length, clip_width=clp_width, clip_height=clp_height, inbite = duv_bite, biteWidth = bite_width);

translate([75,-75,0])rotate([180,90,0])assemblyClip(side_length=duv_length, side_width=duv_width, side_height=duv_height, clip_len = clp_length, clip_width=clp_width, clip_height=clp_height, inbite = duv_bite, biteWidth = bite_width);


// two sliders

translate([0,-75,0])rotate([0,90,90])slider(rail_height=rail_height,rail_width = 0.9*rail_width,rail_length = rail_length, synchole_rad=synchole_rad,window_length=window_length,window_height=window_height, window_location=window_location, tailhook_length=tailhook_length,tailhook_height=tailhook_height);

translate([0,75,0])rotate([0,90,-90])slider(rail_height=rail_height,rail_width = 0.9*rail_width,rail_length = rail_length, synchole_rad=synchole_rad,window_length=window_length,window_height=window_height, window_location=window_location, tailhook_length=tailhook_length,tailhook_height=tailhook_height);