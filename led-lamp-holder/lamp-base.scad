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

module lamp_holder()
{
    //_h_tmp = 3;
    //_d_tmp = 20;
    //cylinder(d=_d_tmp, h=_h_tmp);
    //translate([0,0,_h_tmp])
    peg();
    base();
}

lamp_holder();
