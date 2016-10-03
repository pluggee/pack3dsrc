$fn=100;
// This scad designs the bracket for fixing R1000 modules on a R1000A and R1000A-mini boards

// global variables

tsheet = 1.2;       // sheet metal thickness
tbracket = 10;      // bracket thickness

//wbracket = 152;     // bracket width (R1000A)
wbracket = 102;     // bracket width (R1000A-10)


hbracket = 38;      // bracket height
rbend = 2;          // sheet metal bend radius
dscrew = 2.7;       // mounting screws diameter

lscrewl = 2.7;      // distance between left base edge and screw hole center
lscrewr = 2.7;      // distance between right base edge and screw hole center

lbasel = 8;         // left base length
lbaser = 8;         // right base length



difference() {
    // main body
    translate ([-wbracket/2,0,tsheet/2]) rotate ([90,0,0]) translate ([0,0,-tbracket/2]) main_body();
    // mounting screw holes
    translate ([-wbracket/2-lbasel+lscrewl,0,0]) cylinder (d=dscrew, h=1000, center=true);
    translate ([wbracket/2+lbaser-lscrewr,0,0]) cylinder (d=dscrew, h=1000, center=true);
}

module main_body() {
    // left base plate
    translate ([-1*lbasel,tsheet/-2,0]) cube([lbasel-rbend,tsheet,tbracket]);
    // left bottom bend elbow
    translate ([-1*rbend,rbend,0]) rotate ([0,0,-90]) difference() {
        pie_slice_3D(rbend+tsheet/2,0,90,tbracket);
        pie_slice_3D(rbend-tsheet/2,0,90,tbracket);
    }
    //left side plate
    translate ([tsheet/-2,rbend,0]) cube([tsheet,hbracket-2*rbend,tbracket]);
    // left top bend elbow
    translate ([rbend,hbracket-rbend,0]) rotate ([0,0,90]) difference() {
        pie_slice_3D(rbend+tsheet/2,0,90,tbracket);
        pie_slice_3D(rbend-tsheet/2,0,90,tbracket);
    }
    // top plate
    translate ([rbend,hbracket-tsheet/2,0]) cube([wbracket-2*rbend,tsheet,tbracket]);
    // right top bend elbow
    translate ([wbracket-rbend,hbracket-rbend,0]) rotate ([0,0,0]) difference() {
        pie_slice_3D(rbend+tsheet/2,0,90,tbracket);
        pie_slice_3D(rbend-tsheet/2,0,90,tbracket);
    }
    // right side plate
    translate ([wbracket-tsheet/2,rbend,0]) cube([tsheet,hbracket-2*rbend,tbracket]);
    // right bottom bend elbow
    translate ([wbracket+rbend,rbend,0]) rotate ([0,0,180]) difference() {
        pie_slice_3D(rbend+tsheet/2,0,90,tbracket);
        pie_slice_3D(rbend-tsheet/2,0,90,tbracket);
    }
    // right base plate
    translate ([wbracket+rbend,tsheet/-2,0]) cube([lbaser-rbend,tsheet,tbracket]);
}

module pie_slice_2D(r, start_angle, end_angle) {
    // this draws a 2D slice
    // taken from http://forum.openscad.org/Creating-pie-pizza-slice-shape-need-a-dynamic-length-array-td3148.html
    R = r * sqrt(2) + 1;
    a0 = (4 * start_angle + 0 * end_angle) / 4;
    a1 = (3 * start_angle + 1 * end_angle) / 4;
    a2 = (2 * start_angle + 2 * end_angle) / 4;
    a3 = (1 * start_angle + 3 * end_angle) / 4;
    a4 = (0 * start_angle + 4 * end_angle) / 4;
    if(end_angle > start_angle)
        intersection() {
        circle(r);
        polygon([
            [0,0],
            [R * cos(a0), R * sin(a0)],
            [R * cos(a1), R * sin(a1)],
            [R * cos(a2), R * sin(a2)],
            [R * cos(a3), R * sin(a3)],
            [R * cos(a4), R * sin(a4)],
            [0,0]
       ]);
    }
}
module pie_slice_3D(r, start_angle, end_angle, h) {
    // this extrudes a 2D slice linearly
    linear_extrude(height=h) pie_slice_2D(r, start_angle, end_angle);
}
