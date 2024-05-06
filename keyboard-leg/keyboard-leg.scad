// general purpose parameters
eps = 0.01;
$fn = 90;


// main shape parameters
/*
kl_d = 5.8;
kl_x = 20;
kl_y = 22.5;
kl_t = 2;
*/
kl_d = 2.75;
kl_x = 16.5;
kl_y = 21.6;
kl_t = 2.7;

// cut parameters
// cut width
c_w = 2.5;
// cut lenfth
c_l = 10;

// hinge parameters
/*
h_h = 3;
h_d = 2.3;
*/
h_h = 2;
h_d = 2.75;

// lock parameters
l_z = 1;
l_y = 2;
l_x = 0.5;

module cut()
{
    hull()
    {
        cylinder(h=kl_d+2*eps,d=c_w);
        translate([0,c_l,0])
            cylinder(h=kl_d+2*eps,d=c_w);
    }
}
    

module hinge()
{
    difference()
    {
        cylinder(d=h_d,h=h_h);
        translate([-h_d/2,-h_d/2,h_h/4+eps])
        hull()
        {
            cube([eps,h_d,3*h_h/4]);
            translate([0,0,3*h_h/4-eps])
                cube([h_d/2,h_d,eps]);
        }
    }
}


module keyboard_leg()
{
    difference()
    {
        union()
        {
            // main shape
            translate([0,kl_t,0])
                cube([kl_x,kl_y-kl_t-kl_d/2,kl_t]);
            // front slope
            hull()
            {
                cube([kl_x,kl_t,eps]);
                translate([0,kl_t-eps,0])
                    cube([kl_x,eps,kl_t]);
            }
            // back area
            hull()
            {
                translate([0,kl_y-kl_d/2,kl_d/2])
                    rotate([0,90,0])
                        cylinder(d=kl_d,h=kl_x);
                translate([0,kl_y/2-kl_d/2,0])
                    cube([kl_x,kl_y/2-kl_d/2,kl_t]);
            }
        }
        
        // springing cut
        translate([1.5*c_w,kl_y-c_l,-eps])
            cut();
        translate([kl_x-1.5*c_w,kl_y-c_l,-eps])
            cut();
            
    }
    // adding side cylinders
    translate([0,kl_y-kl_d/2,kl_d/2])
        rotate([90,0,-90])
            hinge();
    
    translate([kl_x,kl_y-kl_d/2,kl_d/2])
        rotate([-90,0,-90])
            hinge();
    
    // adding obscure locks to the hinges
    translate([-l_x,kl_y-h_d-l_y,kl_t/2-l_z/2])
        cube([l_x,l_y+h_d/2,l_z]);
    
    translate([kl_x,kl_y-h_d-l_y,kl_t/2-l_z/2])
        cube([l_x,l_y+h_d/2,l_z]);
    
    

    
}

keyboard_leg();