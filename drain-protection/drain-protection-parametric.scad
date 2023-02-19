r = 34/3*sqrt(3) + 30;
h = 3;
// t = 34;
// t2 = 35;

module circle(){
    for(phi = [0 : 2 : 360]){
        translate([r*cos(phi), r*sin(phi), 0]){
        cylinder(h = h, r = 0.5, center = true);
        }
    }
}

module upanddown(){
    difference(){
        cylinder(h = 0.5, r = r + 0.5, center = true);
        cylinder(h = 1, r = r, center = true);
    }
}

union(){
    circle();
    translate([0, 0, h/2]){
        upanddown();
    }
    translate([0, 0, -h/2]){
        upanddown();
    }
}