
// dist units: mm

//global config
parts_sep = 40; // how much to separate the top and base
eps =0.1; // nudge amount
hewn=250; // how fine should the models be? small for protyping, large for rending
//
//  base config
//
//  //  well config
well_dia = 40.5; // diameter of the food well. Currently set to contain a 3.5 cm petri dish & allow for a 3.8 cm cover to be added while in well
well_rad = well_dia/2; // r: radius of the food well
well_depth=11; // depth of the food well. Currently set to fit flush against the top of a 1.1 cm petri dish.

//
//  //  wall config
wall_thick = 3; // wt: wall thickness between wells
bottom_thick = 6.05;//wall_thick; // the thickness of the bottom of the disk
//
//  //  lip config
lip_thick = 2; // lt: how far past the base does the lip extend?
lip_overhang = 2; // lo: how far down the base does the lip extend?
//
//  stage config
rad_cont = 0.6; // rc: how much smaller is the entry port than the well? Also controls the under-well access spots atm
//
//  // groove config
grv_rad = 45.8; // radius of groove
//grv_dpth = lip_overhang/2; // depth of groove (in this case, also half the width of the groove)
grv_wdth =4;
grv_dpth = grv_wdth/2;

// define a well
module well(x,y,d,r){
     translate([x,y,0]) cylinder(r=r, h=d, $fn = hewn);//, center=true) ;
}

// define four evenly spaced wells
module allswell(d,r, wt){
    cntr = (r + wt/2)*sqrt(2.0); // calculate the centering coord
    union(){
    well(0,cntr,d,r);
    well(0,-cntr,d,r);
    well(cntr,0,d,r);
    well(-cntr,0,d,r);}
   translate([0,0,-(bottom_thick+2*eps)]) union() {
       well(-cntr,0,d,rad_cont*r);
       well(cntr,0,d,rad_cont*r);
       well(0,-cntr,d,rad_cont*r);
       well(0,cntr,d,rad_cont*r);
   }
}

// define the Big Disk holding the wells
module metawell(d, r, wt, bt, lt, lo){

    translate([0,0,-(bt+eps)]) cylinder(d=(2+2*sqrt(2.0))*r + (2+sqrt(2.0))*wt + 2*lt , h=d+bt+lo, $fn = hewn) ;

    }

module stage(r,wt,lo){
    cylinder(d=(2+2*sqrt(2.0))*r + (2+sqrt(2.0))*wt, h=lo+2*eps, $fn = hewn) ;
}


module punches(d,r,wt,rc){
    cntr = (r + wt/2)*sqrt(2.0); // calculate the centering coord
    well(0,cntr,d,r*rc);
    well(0,-cntr,d,r*rc);
}

//well(0,0,well_depth, well_rad);

//allswell(well_depth, well_rad, wall_thick);

//metawell(well_depth, well_rad, wall_thick, bottom_thick);
    
module allYourBase(d, r, wt, bt, lt, lo){

    difference(){
        difference(){
            metawell(d, r, wt, bt, lt, lo);
            allswell(d, r, wt);// scoop the food wells out
    }

        translate([0,0,well_depth-eps]) stage( r, wt+2*eps, lo); // scoop out the stage pit

    }
}
       

module punchedStage(r,wt,lo,rc){
    difference(){
    stage(r, wt, lo);
    translate([0,0,-0.5*eps]) punches(lo+3*eps, r, wt,rc);
    }
}


module groove(gr, gd, gw){
    rotate_extrude() translate([gr, 0, 0]) scale([gw,gd,1]) circle(r = 1/2, $fn = hewn);
}


module groovyPunchedStage(r,wt,lo,rc,gr,gd,gw){

    difference(){
        punchedStage(r, wt, lo, rc);
        translate([0,0,lo]) groove(gr, gd,gw);
    }
    
    
}



translate([parts_sep,parts_sep,bottom_thick+eps])  allYourBase(well_depth, well_rad, wall_thick, bottom_thick, lip_thick, lip_overhang);

 translate([-parts_sep,-parts_sep,0])groovyPunchedStage(well_rad,wall_thick,lip_overhang, rad_cont, grv_rad, grv_dpth, grv_wdth);


