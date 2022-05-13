// dist units: mm

//whole config
parts_sep = 64; // how much to separate the top and base
eps =0.1; // nudge amount



//base config
well_dia = 39; // diameter of the food well. Currently set to contain a 3.5 cm petri dish & allow for a 3.8 cm cover to be added while in well
well_rad = well_dia/2; // r: radius of the food well
well_depth=11; // depth of the food well. Currently set to fit flush against the top of a 1.1 cm petri dish.
wall_thick = 3; // wt: wall thickness between wells
bottom_thick = wall_thick; // the thickness of the bottom of the disk

//top config
pit_dia = (2+2*sqrt(2.0))*well_rad + (2+sqrt(2.0))*wall_thick+ eps; // pd: size of the hole the base will fit into (ie, base diameter nudged)
lip_thick = 2; // lt: how far past the base does the lip extend?
lip_overhang = 2; // lo: how far down the base does the lip extend?
lid_thick = 2; // dt: how thick is the lid?
rad_cont = 0.75; // rc: how much smaller is the entry port than the well?


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




translate([parts_sep,parts_sep,0]) allYourBase(well_depth, well_rad, wall_thick, bottom_thick);


module lid(pd,lo,lt,dt){
    cylinder(d=pd+2*lt, h=dt+lo);
    }
module pittedLid(pd,lo,lt,dt){
    difference(){
        lid(pd,lo,lt,dt);
        translate([0,0,dt+eps]) cylinder(d=pd, h=lo);
    }
}

//translate([-parts_sep,-parts_sep,0]) pittedLid(pit_dia, lip_overhang, lip_thick, lid_thick);

module punches(d,r, wt, rc){
    cntr = (r + wt/2)*sqrt(2.0); // calculate the centering coord
    well(0,cntr,d,r*rc);
    well(0,-cntr,d,r*rc);
}

//translate([-parts_sep,-parts_sep,0]) punches(lid_thick, well_rad*rad_cont, wall_thick);

module punchedPittedLid(pd,lo,lt,dt,r,rc,wt){
    difference(){
        pittedLid(pd, lo, lt, dt);
        translate([0,0,-0.9*eps]) punches(dt+2.1*eps, r, wt,rc);
    }
}

translate([-parts_sep,-parts_sep,0])  punchedPittedLid(pit_dia, lip_overhang, lip_thick, lid_thick, well_rad, rad_cont, wall_thick);




