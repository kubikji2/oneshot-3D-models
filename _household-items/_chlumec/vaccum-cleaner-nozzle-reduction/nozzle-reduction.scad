include <../../../solidpp/solidpp.scad>

// general paramers
wt = 2.5;
WT = 3;
l = 30;

// input (closer to the vacuum cleaner)
d_i = 32.4;
D_i = 39;

// output (further from the vacuum cleaner)
d_o = 31.8;
D_o = 35.5;

// stopper
s_t = 2;
// '-> thickness
s_h = 4;
// '-> height

$fn = $preview ? 30 : 120;

module nozzle_reduction()
{
    _s_d = max(D_i, D_o) + 2*s_t;
    _d_o = d_o - 2*WT;
    _d_i = d_i - 2*WT;
    difference()
    {
        union()
        {
            // lower interface
            cylinderpp(d1=_d_i+2*wt, d2=_d_i+2*WT, h=l);

            // stopper
            translate([0,0,l])
                cylinderpp(d=_s_d, h=s_h);
            
            // upper interface
            translate([0,0,l+s_h])
                cylinderpp(d1=_d_o+2*WT, d2=_d_o+2*wt, h=l);
            
            translate([0,0,l+s_h+l])
                toruspp(t=2*wt, D=_d_o+2*wt);
        }

        //hull()
        //{
            cylinderpp(d=_d_i, h=2*l, align="");
            translate([0,0,l])
                cylinderpp(d1=_d_i, d2=_d_o, h=s_h);
            translate([0,0,l+s_h])
                cylinderpp(d=_d_o, h=2*l);
        //}
        //translate

    }
}


nozzle_reduction();