include <../qpp_all.scad>

// peg parameters
// '-> outer peg diameter
peg_D = 11.5;
// '-> groove diameter
peg_d = 8;
// '-> peg height
peg_H = 16;
// '-> groove height
peg_h = 5;
// '-> groove offset from the base
peg_h_off = peg_H - peg_h - 6.5;

// base parameters
base_d = 31;
base_D = 35.5;
base_wt = 3;
base_h = 30; 

$fn=90;

module peg()
{
    difference()
    {
        cylinder(h=peg_H,d=peg_D);
        translate([0,0,peg_h_off])
            qpp_ring(d=peg_d, D=peg_D+1, h=peg_h);
    }
}

module base()
{
    _D = 2*base_wt + base_D;
    _H = base_wt + base_h;
    translate([0,0,-_H])
    difference()
    {
        cylinder(d=_D,h=_H);
        translate([0,0,-qpp_eps])
            cylinder(d=base_D,h=base_h+qpp_eps);
    }
}

module bolt()
{
    _l = 20;
    _h = 3;
    _d = 3;
    _D = 5.6;
    translate([0,0,peg_H-_h-_l+qpp_eps])
    {
        // shaft
        cylinder(h=_l+qpp_eps,d=_d);
        // head
        translate([0,0,_l])
            cylinder(h=_h,d=_D);
    }
}

module lamp_holder()
{
    difference()
    {
        union()
        {
            peg();
            base();
        }
        #bolt();
    }
}

lamp_holder();
