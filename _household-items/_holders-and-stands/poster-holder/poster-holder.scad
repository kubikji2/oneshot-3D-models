eps = 0.01;
$fn=180;

// inner space dimensions
i_x = 250;
i_y = 40;
i_z = 56;

// wall thickness
t = 3;

// box dimensions
b_x = i_x + 2*t;
b_y = i_y + 2*t;
b_z = i_z + t;

b_off = 20;

// hook dimension
h_off = 15.5;
h_peak = 3;

// main bozx for holding both posters and wrapping papers
module poster_box()
{
    difference()
    {
        hull()
        {
            cube([b_x,b_y,b_z-b_off]);
            translate([0,b_y-t,0]) cube([b_x,t,b_z+t]);
        }
        translate([t,t,t+eps]) cube([i_x, i_y, i_z+t]);
    }
}

// hook to the shelf
module hook(w=30)
{
    translate([0,b_y-t,0])
    {
        h_y = h_off+2*t;
        // upper connector
        translate([0,0,b_z-eps]) cube([w,h_y,t]);
        // vertical wall
        translate([0,h_off+t,0]) cube([w,t,b_z+t]);
        // lower lock
        translate([0,h_off+t-h_peak,0]) cube([w,t+h_peak,t]);
    }
}

// loop for holding upper parts of the posters and wrapping papers
module poster_loop()
{
    
    // basic box for holder
    difference()
    {
        hull()
        {
            cube([b_x,b_y,b_z-b_off]);
            translate([0,b_y-t,0]) cube([b_x,t,b_z+t]);
        }
        translate([t,t,-eps]) cube([i_x, i_y, i_z+2*t]);
    }
    // left hook
    hook();
    // right hook
    translate([b_x-30,0,0]) hook();
    
}

//poster_loop();

// lower part of poster holder
module poster_holder()
{
    // basic box for holder
    poster_box();
    // left hook
    hook();
    // right hook
    translate([b_x-30,0,0]) hook();
}

//poster_holder();

// fallout poster holder diameter
fp_d = 46.5;

module fph(off = 0)
{
    b_off2 = 20;
    difference()
    {
        union()
        {
            // basic shape
            cylinder(d=fp_d+2*t,h=b_z+t-b_off2);
            
            hull()
            {
                // inner support
                translate([-w/2,0,0]) cube([w,fp_d/2+t,b_z+t-b_off2]);
                translate([-w/2,fp_d/2,0]) cube([w,t,b_z+t]);
                
            }
            
            w=30;
            h_y = fp_d/2+ h_off+2*t;

            translate([-w/2,fp_d/2,0])
            {
                // upper connector
                translate([0,0,b_z-eps]) cube([w,h_off+2*t,t]);
                // vertical wall
                translate([0,h_off+t,0]) cube([w,t,b_z+t]);
                // lower lock
                translate([0,h_off+t-h_peak,0]) cube([w,t+h_peak,t]);
            }
        }

        translate([0,0,off-eps]) cylinder(d=fp_d,h=b_z+t+2*eps);

    }   
}

module fallout_poster_looper()
{
    fph();
}

// fallout_poster_looper();

module fallout_poster_holder()
{
    fph(off=t);
}

// fallout_poster_holder();