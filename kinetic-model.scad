$fn = 120;

dist = 39.3;
d = 5.2;
offset = 0.4;
dist_all = dist + d + offset;

module stick(x)
{
    cylinder(h = x, r = d/2, center = false);
}


module main()
{
    translate([0, -2.5, 0])
    {
        cube([180, 5, 2]);
    }
    for(i = [1 : 1 : 5])
    {
    translate([(i-1) * dist_all, 0, 0])
        {
            stick(7*i);
        }
    }
}

offset_cyl = 0.1;

module cyl()
{
    difference(){
        cylinder(h = 5, r = 4, center = false);
        cylinder(h = 50, r = (d/2) + offset_cyl, center = true);
    }
}

cyl();

/*$fn = 60;

h_draw_stick = 15;
r_draw_stick = 3.1;
r_base = 50;
shift = 5; 
h_grip = 50;
stick_r = 1.5;
a = r_base-shift;

module base(){  
cylinder(h = 5, r = r_base, center = true);
translate([r_base-shift, 0, -h_grip/2]){
    cylinder(h = 50, r = r_draw_stick, center = true);
    }
}


module draw_stick(){
    cylinder(h = 15, r = r_draw_stick, center = true);
    difference(){
        translate([-0.8, -3, (h_draw_stick/2)-2]){
            stick_holder();
        }
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

module stick_holder(){
    a = 12;
    b = 6;
    c = 2;
    difference(){
        cube([a, b, c]);
        translate([a-stick_r, (b/2)-stick_r, -1]) cube([stick_r, stick_r, c+5]);
        }    
}

main();
*/
