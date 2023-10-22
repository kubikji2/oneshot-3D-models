include<../solidpp/solidpp.scad>

$fn = $preview ? 30 : 120;

// head
head_l = 10;
// '-> length
tip_d = 2;
// '-> tip diameter


// interface between the head/tip and the shaft
interface_d = 4;
interface_h = 7;
interface_clr = 0.2;

connector_d = 2;
connector_h = 16;
connector_xy_clearance = 0.2;
connector_z_clearance = 0.5;

// grip
grip_l = 25;

// shaft
shaft_l = 100;


// stylus parameters
stylus_d = 7;
// '-> inscribed radius
stylus_D = stylus_d/cos(180/6);
// '-> outer radius
stylus_l = head_l + shaft_l;


// stylus head
module head()
{

    difference()
    {
        minkowski()
        {
            union()
            {   
                translate([0,0,grip_l])
                    cylinderpp(d1=stylus_D-tip_d, d2=0, h=head_l, $fn=6);
                cylinderpp(d=stylus_D-tip_d, h=grip_l, $fn=6);
            }
            sphere(d=tip_d);
        }

        // bottom cut
        cylinderpp(r=stylus_D, h=head_l, align="Z");

        // interface
        translate([0,0,-0.01])
            cylinderpp(d=connector_d+connector_xy_clearance, h=connector_h + 2*connector_z_clearance+connector_xy_clearance);
            //cylinderpp(d=interface_d+interface_clr, h=interface_h+interface_clr);
    }

}


// stylus head
module stylus()
{
    difference()
    {
        minkowski()
        {
            cylinderpp(d=stylus_D-tip_d, h=stylus_l, $fn=6);
            sphere(d=tip_d);
        }
        
        /*
        // cutting of the head and the grip
        translate([0,0,shaft_l-grip_l])
        {
            //coordinate_frame();
            translate([0,0,interface_h-2*interface_clr])
                cylinderpp(r=stylus_D,h=stylus_l);
            
            translate([0,0,-interface_clr])
                tubepp(R=stylus_D, d=interface_d-interface_clr, h=2*interface_h);
        }
        */

        translate([0,0,shaft_l-grip_l])
        {
            // cut the tip off
            translate([0,0,-interface_clr])
            cylinderpp(r=stylus_D,h=stylus_l);
            
            // cut the hole for the peg
            cylinderpp(d=connector_d+connector_xy_clearance, h=connector_h+2*connector_z_clearance+connector_xy_clearance, align="");
        }
        // bottom cut
        cylinderpp(r=stylus_D, h=head_l, align="Z");

    }
}


// TESTING
stylus();

///*
translate([0,0,shaft_l-grip_l])
    head();
//*/