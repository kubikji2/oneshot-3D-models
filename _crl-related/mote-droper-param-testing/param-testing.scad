size = 6;
height = 2.9;
experimental= 0.9;

d_inner = 4.0;
d_outer = 5.5;

$fn = 60;

module nonlego(){
    difference(){
        translate([0, 0, -height/2]){cube([size, size, height], center = true);}
        translate([0, 0, -height/2]){cylinder(h = height+1, r = d_inner/2, center = true);}
    cylinder(h = 2*experimental, r = d_outer/2, center = true);    
    }
}


module hole(){
    difference(){
        cube([4, 4, 7], center = true);
        translate([0, 0, 0.5]){
            cylinder(h = 6, r = 0.9, center = true);
        }
    }
}

union(){
    nonlego();
    translate([0, size, 0]){nonlego();}
    translate([0, 2*size, 0]){nonlego();}
