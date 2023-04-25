$fn = 120;
p_len = 22; 
h_cyl = 3;


translate([-p_len, 0, 0]){
    rotate([0, 90, 0]){
        cylinder(h = h_cyl, r = 4, center = true);
    }
    translate([2.3+4, 0, 0]){
        rotate([0, 90, 0]){
            cylinder(h = h_cyl, r = 4, center = true);
        }
    }
    translate([0, -3.5, -1.5]){
        cube([p_len, 7, 3]);
    }
}
translate([0, -3.5, -10.5+2]){
cube([3, 7, 12-2]);
}
translate([-6, -3.5, -10.5+2]){
cube([6, 7, 3]);
}
