d_out = 115.6;
r_out = d_out/2;
d_in = 112.6;
r_in = d_in/2;
h = 5.5;
// t = 34;
// t2 = 35;

module circle(){
    for(phi = [0 : 2 : 360]){
        translate([r_in*cos(phi), r_in*sin(phi), 0]){
        cylinder(h = h, r = 0.5, center = true);
        }
    }
}

module upanddown(){
    difference(){
        cylinder(h = 0.5, r = r_out, center = true);
        cylinder(h = 1, r = r_in, center = true);
    }
}

union(){
    circle();
    translate([0, 0, (h/2)-0.25]){
        upanddown();
    }
    translate([0, 0, (-h/2)+0.25]){
        upanddown();
    }
}