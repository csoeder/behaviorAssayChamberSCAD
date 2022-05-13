eps=0.1;
//duv_length =10;
//duv_width=10;
//duv_height=10;
//duv_bite = 3

//
//clp_length =20;//rail_enclosure_width + duv_length
//clp_width =duv_width;
//clp_height=10;

module duvTail(length= 10, width= 10, height=10, inbite = 4){

intersection(){

    linear_extrude(height=height){

        union(){
        translate([-width/2,0,0]) square([width, length]);
        translate([0,-inbite,0])polygon([[0,sqrt(3)*width/2],[width/2, 0],[-width/2, 0]]);
            }
        }
    color([1,0,0]) translate([-width/2,-inbite,0]) cube([width, length+inbite, height]);
    }



}



module flatTail(length= 5, width= 10, height=10, inbite = 5, biteWidth=3){


    linear_extrude(height=height){

        union(){
        translate([-width/2,0,0]) square([width, length]);
        translate([-biteWidth/2,-inbite+eps,0])square([biteWidth, inbite]);
            }
        }



}



module assemblyClip(side_length=10, side_width=5, side_height=10, clip_len = 20, clip_width=5, clip_height=5, inbite=5,biteWidth=1.5){
    
        union(){
            flatTail(length=side_length, width=side_width, height=side_height, inbite = inbite, biteWidth=biteWidth);
            translate([-clip_width/2,side_length-clip_len-inbite,eps-clip_height])cube([clip_width,clip_len+inbite, clip_height]);
        }

    


    
}


//flatTail();



assemblyClip( );