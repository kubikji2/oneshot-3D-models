// general purpose parameters
eps = 0.01;
$fn = 90;

// foot parameters
// height
h = 19;
// outer diameter
D = 20;
// inner diameter 
d = 16;
// center offset
off = 3/2;
// length of the cut
l = 12;

// vertical cylinder parameters
// diameter
vc_d = 4.5;
// height
vc_h = 5.5;

// cylinders increasing friction parameters
cf_d = 1.5;
// cylinders angles
cf_a = 35;

module foot()
{
    difference()
    {
        // main shape
        cylinder(d=D, h=h);
        
        // inner cut
        translate([off,0,-eps])
            cylinder(d=d, h=h+2*eps);
        
        // cut for inserting the dryer leg
        translate([0,-l/2,-eps])
            cube([D/2,l,h+2*eps]);
    }
    
    // vertical cylinder
    translate([-d/2+off,0,D/2])
    rotate([0,90,0])
    translate([0,0,-1])
    {
        // base
        cylinder(h=vc_h-1, d=vc_d);
        // tip
        translate([0,0,vc_h-1])
            cylinder(h=2, d1=vc_d, d2=vc_d-1);
        //%translate([0,0,1])
        //    cylinder(h=vc_h,d=vc_d);
    }
    
    // cylinder increasing friction
    for(a=[-cf_a,0,cf_a])
    {
        rotate([0,0,a])
            translate([-D/2,0,0])
                cylinder(d=cf_d, h=h);
    }
}

foot();
