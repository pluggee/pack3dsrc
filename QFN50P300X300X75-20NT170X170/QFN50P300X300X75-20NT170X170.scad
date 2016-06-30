// refer to packaging dimensions in 
// http://www.silabs.com/Support%20Documents/TechnicalDocs/EFM8BB1-DataSheet.pdf

D = 3;
E = 3;
A = 0.75;
D2 = 1.7;
E2 = 1.7;
A1 = 0.05;
A3 = 0.2;
c = 0.3;
f = 2.5;
R = 0.125;
L = 0.4;
b = 0.25;
e = 0.5;

$fn=50;

union (){
        
    body();
    tp();
    cornerpads();
    side4leads();
    rotate ([0,0,90]) side4leads();
    rotate ([0,0,180]) side4leads();
    rotate ([0,0,270]) side4leads();
    marking();
}

module body()
{
    // main package body
    translate ([0,0,A/2+A1]) cube ([D,E,A],center=true);
}

module tp()
{
    // bottom thermal pad
    translate ([0,0,A1/2]) cube ([D2,E2,A1],center=true);
}

module cornerpads()
{
    // small corner pad
    translate ([f/2,f/2,0]) cent_mink(d=c,e=c,r=R/2, h=A1);
    translate ([f/2,f/-2,0]) cent_mink(d=c,e=c,r=R/2, h=A1);
    translate ([f/-2,f/-2,0]) cent_mink(d=c,e=c,r=R/2, h=A1);
    translate ([f/-2,f/2,0]) cent_mink(d=c,e=c,r=R/2, h=A1);
}

module cent_mink(d=20,e=20,r=2,h=1)
{
    dd = d-2*r;
    ee = e-2*r;
    translate ([dd/-2,ee/-2,0]) minkowski()
    {
         cube([dd,ee,h/2]);
         cylinder(r=r,h=h/2);
    }
}

module sidelead()
{
    // right angled side lead
    // bottom part
    union () {
        translate ([0,L/-2,0]) cent_mink(d=b,e=L,r=R/2,h=A1);
        translate ([0,L/-4,A1/2]) cube([b,L/2,A1],center=true);
        translate ([0,A1/2,A3/2]) cube ([b,A1,A3],center=true);
    }
}

module side4leads()
{
    translate([-1.5*e,E/2,0]) sidelead();
    translate([-0.5*e,E/2,0]) sidelead();
    translate([0.5*e,E/2,0]) sidelead();
    translate([1.5*e,E/2,0]) sidelead();
}

module marking(){
    // this adds pin 1 mark and text
    translate ([-1,-1,A+1.5*A1]) cylinder (r=0.2,h=A1, center=true);
    translate ([0.25,-1.25,A+A1]) rotate([0,0,90]) linear_extrude (height = A1) text("QFN 20",0.5);
}