include<../solidpp/cylinderpp.scad>
include<../solidpp/cubepp.scad>
include<../solidpp/spherepp.scad>

include<../solidpp/transforms/transform_to_spp.scad>

include<shaft-constants.scad>
include<power-cord-constants.scad>

w65_clrn = 0.2;

// adapter parameters
w65_l = 109  + 2*w65_clrn;
// '-> length
w65_h = 47   + 2*w65_clrn;
// '-> height
w65_t = 30 + 2*w65_clrn;
// '-> thickness

w65_wt = 2;
// '-> wall thickness

// adapter (hole) dimensions
a_65w_x = w65_h;
a_65w_y = w65_t;
a_65w_z = w65_l+2*w65_wt;
a_65w_size = [a_65w_x, a_65w_y, a_65w_z];

// holder dimensions
h_65w_x = w65_h + 2* w65_wt; 
h_65w_y = w65_t + 2* w65_wt;
h_65w_z = w65_l +    w65_wt; 
h_65w_size = [h_65w_x, h_65w_y, h_65w_z];

$fn = $preview ? 30 : 60;

module __hook_65w(is_up=true)
{
    _h = w65_l/4;
    _H = _h+w65_wt;
    _hd = _H-_h;
    _d = shaft_d+2*w65_wt;
    _a = is_up ? "Z" : "z";
    
    translate([w65_wt,0,0])
    transform_to_spp([_d, _d, _h], align="", pos="x")
    difference()
    {   
        hull()
        {
            // outer shell
            cylinderpp(d=_d, h=_h, align=_a);
            // connection to the adapter holder
            transform_to_spp([_d,_d,_h], align=_a,pos="X")
                cubepp([w65_wt,h_65w_y,_h], align="X");

        }

        translate([0,0,(is_up ? 1 : -1)*_hd/2])
        {
            // shaft hole
            cylinderpp(d=shaft_d, h=_H, align=_a);

            // assembly shaft hole
            _hole_d = 3*shaft_d/4; //shaft_d-2*w65_wt;
            cubepp([_d, _hole_d , _H], align=str(_a,"X"));
        }
    }
}

module holder_65w()
{

    // main body
    difference()
    {
        // holder
        _mods = [round_edges(r=w65_wt,axes="xy")];
        cubepp(h_65w_size, align="", mod_list=_mods);

        // inner space
        translate([0, 0, w65_wt])
            cubepp(a_65w_size, align="");

        // hole for the
        transform_to_spp(a_65w_size, align="", pos="z")
            translate([0, 0, 2*w65_wt])
                cubepp([pc_w+2*w65_clrn, pc_t+2*w65_clrn, 3*w65_wt], align="Z");

    }

    transform_to_spp(h_65w_size, align="", pos="xz")
        __hook_65w(false);

    transform_to_spp(h_65w_size, align="", pos="xZ")
        __hook_65w();

}

holder_65w();

//__hook_65w();