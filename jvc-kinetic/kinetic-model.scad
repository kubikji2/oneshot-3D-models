$fn = 60;

h_draw_stick = 15;
r_draw_stick = 3;
r_base = 50;
shift = 5; 
h_grip = 50;
a = r_base-shift;

module base(){  
cylinder(h = 5, r = r_base, center = true);
translate([r_base-shift, 0, -h_grip/2]){
    cylinder(h = 50, r = r_draw_stick, center = true);
    }
}


module draw_stick(){
    cylinder(h = 15, r = r_draw_stick, center = true);
    translate([-2, -3, h_draw_stick/2]){
        cube([12, 6, 2]);
    }
}


module main(){
    base();
    for(i = [0 : 22.5 : 360]){
    translate([a * cos(i), a * sin(i), h_draw_stick/2]){
        rotate([0, 0, i]){
            draw_stick();
            }
        }
    
    }
}

main();