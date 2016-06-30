$fn=50;

L = 25;         // V7700W
//L = 37.5;       // V7700X

difference () {
    union() {    
        // main body
        translate ([0,0,2.5]) cube ([L,16,5],center=true);
        translate ([0,0,2.75]) cube ([L,5,5.5],center=true);
        // fins
        translate ([0,7.5,0]) fin ();
        translate ([0,2.5,0]) fin ();
        translate ([0,-2.5,0]) fin ();
        translate ([0,-7.5,0]) fin ();       
    }
    grooves();
    translate ([20+L/-2,0,0]) cylinder (d=2.5,h=100,center=true);
}

 
module fin(){
    // rectangle
    union(){
        translate ([L/-2,-0.55,0]) cube ([L,1.1,15.5]);
        translate ([0,0,15.5]) rotate ([0,90,0]) cylinder (r=0.5,h=L,center = true);
    }
}

module grooves(){
    translate ([0,0,3.5]) rotate ([0,90,0]) cylinder (d=2.15,h=L,center=true); 
    translate ([0,5,3.5]) rotate ([0,90,0]) cylinder (d=1.3,h=L,center=true); 
    translate ([0,-5,3.5]) rotate ([0,90,0]) cylinder (d=1.3,h=L,center=true);
    difference () {
        translate ([0,0,6]) cube ([L,2.15,5],center=true);
        translate ([0,1.5,4.5]) rotate ([0,90,0]) cylinder (d=2.15,h=L,center=true); 
        translate ([0,-1.5,4.5]) rotate ([0,90,0]) cylinder (d=2.15,h=L,center=true); 
    }
    difference () {
        translate ([0,5,6]) cube ([L,1.3,5],center=true);
        translate ([0,6,4.5]) rotate ([0,90,0]) cylinder (d=1.3,h=L,center=true); 
        translate ([0,4,4.5]) rotate ([0,90,0]) cylinder (d=1,3,h=L,center=true); 
    }
    difference () {
        translate ([0,-5,6]) cube ([L,1.3,5],center=true);
        translate ([0,-6,4.5]) rotate ([0,90,0]) cylinder (d=1.3,h=L,center=true); 
        translate ([0,-4,4.5]) rotate ([0,90,0]) cylinder (d=1,3,h=L,center=true); 
    }
}