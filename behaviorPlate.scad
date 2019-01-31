well_dia = 10;
well_rad = well_dia/2; // radius of the food well
well_depth=2; // depth of the food well
wall_thick = 0.5; // wall thickness between wells
bottom_thick = wall_thick; // the thickness of the bottom of the disk
eps =0.01; // nudge amount

// define a well
module well(x,y,d,r){
     translate([x,y,0]) cylinder(r=r, h=d);//, center=true) ;
}

// define four evenly spaced wells
module allswell(d,r, wt){
    cntr = (r + wt/2)*sqrt(2.0); // calculate the centering coord
    well(0,cntr,d,r);
    well(0,-cntr,d,r);
    well(cntr,0,d,r);
    well(-cntr,0,d,r);
}

// define the Big Disk holding the wells
module metawell(d, r, wt, bt){

    translate([0,0,-(bt+eps)]) cylinder(d=(2+2*sqrt(2.0))*r + (2+sqrt(2.0))*wt , h=d+bt) ;

    }



//well(0,0,well_depth, well_rad);

//allswell(well_depth, well_rad, wall_thick);

//metawell(well_depth, well_rad, wall_thick, bottom_thick);

module allYourBase(d, r, wt, bt){
    difference(){
        metawell(d, r, wt, bt);
        allswell(d, r, wt);
    }    
}

allYourBase(well_depth, well_rad, wall_thick, bottom_thick);


