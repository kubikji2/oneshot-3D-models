d_out = 115.6;
r_out = d_out/2;
d_in = 112.6;
r_in = d_in/2;
h = 5.5;
// t = 34;
// t2 = 35;
fn = 60;

$fn = 60;

module circle(){
<<<<<<< HEAD
    for(phi = [0 : 4 : 360]){
        translate([r_in*cos(phi), r_in*sin(phi), 0]){
        cylinder(h = h, r = 1.3, center = true);
        }
=======
    for(phi = [0 : 2 : 360])
    {
        rotate([0,0,phi])
            translate([r_in+0.5, 0, 0])
                cylinder(h = h, r = 0.5, center = true);
        
>>>>>>> 9c5765072e1d5a0e38d5fd2c8bb859f646edc49b
    }
}

module upanddown(){
    difference(){
        cylinder(h = 0.5, r = r_out, center = true);
        cylinder(h = 1, r = r_in-2, center = true);
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