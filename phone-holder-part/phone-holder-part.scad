$fn = 60;
p_len = 50; 
h_cyl = 5;


translate([-p_len, 0, 0]){
    rotate([0, 90, 0]){
        cylinder(h = h_cyl, r = 4, center = true);
    }
    translate([0, -2.5, -2]){
        cube([p_len, 5, 4]);
    }
}
translate([0, -2.5, -8]){
cube([4, 5, 10]);
}
translate([-p_len/3, -2.5, -8]){
cube([p_len/3, 5, 4]);
}