$fn = 90;
eps = 0.01;
tol = 0.25;

// wheel parameters
// '-> wheel diameters
w_d = 49;
// '-> wheel thickness
w_h = 10;
// '-> wheel inner hole diameter
w_id = w_d-2*7.5;
// '-> wheel inner hole depth
w_ih = 6;
// '-> wheel dome width
w_dh = 5;
// '-> inner axis height/length
w_ah = 2.5;
// '-> inner axis diameter
w_ad = 12;

// M6 parameters
// '-> diameter
m6_d = 6;
// '-> head thickness
m6_ht = 4;
// '-> head diameter
m6_hd = 11.2;
// '-> nut thickness
m6_nt = 8;
// '-> nut diameter
m6_nd = 11.2;

module wheel()
{
    // main cylinder
    difference()
    {
        // main geometry
        cylinder(d=w_d, h=w_h);
        // drilling hole
        translate([0,0,w_h-w_ih+eps])
            cylinder(d=w_id, h=w_ih);
    }
    
    // adding central axis
    translate([0,0,w_h-w_ih])
        cylinder(h=w_ah+w_ih,d=w_ad);
    
    // adding reinforcement
    translate([0,0,w_h-w_ih])
    hull()
    {
        // lower plate
        translate([0,0,-eps])
            cylinder(h=eps,d=(w_id-w_ad)/2+w_ad);
        cylinder(h=w_ih/2+w_ah,d=w_ad);
    } 
    
}

module right_wheel()
{
    difference()
    {
        // wheel body
        wheel();
        // hole for the bolt body
        translate([0,0,-eps])
            cylinder(d=m6_d+tol, h=w_h+w_ah+2*eps);
        // hole for the bolt head/nut
        translate([0,0,-eps])
            cylinder(d=m6_nd+tol, h=w_h-w_ih+tol, $fn=6);
    }
}

right_wheel();