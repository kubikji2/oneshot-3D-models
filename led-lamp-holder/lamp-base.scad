include <../qpp_all.scad>

// peg parameters
peg_D = 11.5;
peg_d = 8;
peg_H = 16;
peg_h = 5;
peg_h_off = peg_H - peg_h - 6.5;

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


module lamp_holder()
{
    _h_tmp = 3;
    _d_tmp = 20;
    cylinder(d=_d_tmp, h=_h_tmp);
    translate([0,0,_h_tmp])
        peg();
}

lamp_holder();
