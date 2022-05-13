eps =0.1;

////the big block
//
////  consists of three chambers; suitor left, suitor right, center stage
//
//side_chamber_rad = 25;
//central_chamber_rad = 50;
//chamber_spacing=5;
//
//// as well as two slot rails for the tabs to slide in
//
//rail_enclosure_length = 100;
//rail_enclosure_width = 10;
//
//block_height = 75;
module bigBlock(block_height = 75,side_chamber_rad = 25, central_chamber_rad = 50,chamber_spacing=5, rail_enclosure_length = 100, rail_enclosure_width = 10){
    linear_extrude(height = block_height){

    offset(r=5){
        translate([-side_chamber_rad-central_chamber_rad - chamber_spacing,0,0])circle(r=side_chamber_rad);
        translate([side_chamber_rad +central_chamber_rad + chamber_spacing,0,0])circle(r=side_chamber_rad);
        circle(r=central_chamber_rad);
    } // the chambers

    translate([-central_chamber_rad - chamber_spacing/2-rail_enclosure_width/2,-rail_enclosure_length/2,0])square(size=[rail_enclosure_width, rail_enclosure_length]); //enclosure 1
    
    translate([central_chamber_rad + chamber_spacing/2 -rail_enclosure_width/2,-rail_enclosure_length/2,0])square(size=[rail_enclosure_width, rail_enclosure_length]);//enclosure 2
    }
}
bigBlock();

