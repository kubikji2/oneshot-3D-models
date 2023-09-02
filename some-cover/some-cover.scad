// include threads
use<../external/threads.scad>
include<../solidpp/solidpp.scad>

// CUSTOMIZABLE parameters

// general parameters
d_o = 134.5;
// '-> outer diameter
d_i = 130.0;
// '-> inner diameter
t_d = 127;
// '-> thread diameter
h_o = 20;
// '-> outer height
h_i = 18;
// '-> inner height
clearance = 0.5;
// '-> clearance

$fn = $preview ? 30 : 60;

module cover()
{   
    mod_list = [round_bases(r_bottom = 2)];
    /*
    // body without the thread
    difference()
    {
        cylinderpp(d=d_o, h=h_o, mod_list=mod_list);

        translate([0,0,h_o-h_i-clearance])
            cylinder(d=d_i+2*clearance, h=h_i+2*clearance);
    }
    */

    //ScrewHole(outer_diam=d_i, height=h_i, position=[0, 0, h_o-h_i], pitch=4.5, tooth_height=(d_i-t_d)/2)
        //cylinderpp(d=d_o, h=h_o, mod_list=mod_list);
    // thread

    // grip
}

cover();

