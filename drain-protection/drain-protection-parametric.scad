d_out = 115.6;
r_out = d_out/2;
d_in = 112.6;
r_in = d_in/2;
h = 7;
// t = 34;
// t2 = 35;

t = r_out-r_in;

$fn = 60;

module circle(){
    for(phi = [0 : 4 : 360]){
        translate([r_in*cos(phi), r_in*sin(phi), 0]){
        cylinder(h = h, r = t, center = true);
        }
    }
}

module upanddown(){
    difference(){
        cylinder(h = 0.5, r = r_out, center = true);
        cylinder(h = 1, r = r_in-t, center = true);
    }
}

union(){
    circle($fn=18);
    translate([0, 0, (h/2)-0.25]){
        upanddown();
    }
    translate([0, 0, (-h/2)+0.25]){
        upanddown();
    }
}