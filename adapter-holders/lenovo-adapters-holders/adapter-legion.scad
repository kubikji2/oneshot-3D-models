include<../../solidpp/cylinderpp.scad>
include<../../solidpp/cubepp.scad>
include<../../solidpp/spherepp.scad>

include<../../solidpp/transforms/transform_to_spp.scad>

include<shaft-constants.scad>
include<power-cord-constants.scad>

lgn_clrn = 0.2;

// adapter parameters
lgn_l = 145  + 2*lgn_clrn;
// '-> length
lgn_h = 65   + 2*lgn_clrn;
// '-> height
lgn_t = 30.5 + 2*lgn_clrn;
// '-> thickness

lgn_wt = 2;
// '-> wall thickness

// adapter (hole) dimensions
a_lgn_x = lgn_h;
a_lgn_y = lgn_t;
a_lgn_z = lgn_l+2*lgn_wt;
a_lgn_size = [a_lgn_x, a_lgn_y, a_lgn_z];

// holder dimensions
h_lgn_x = lgn_h + 2* lgn_wt; 
h_lgn_y = lgn_t + 2* lgn_wt;
h_lgn_z = lgn_l +    lgn_wt; 
h_lgn_size = [h_lgn_x, h_lgn_y, h_lgn_z];

// power coord parameters
pc_off = 7;
// '-> offset

$fn = $preview ? 30 : 60;

module __hook_lgn(is_up=true)
{
    _h = lgn_l/4;
    _H = _h+lgn_wt;
    _hd = _H-_h;
    _d = shaft_d+2*lgn_wt;
    _a = is_up ? "Z" : "z";
    
    translate([lgn_wt,0,0])
    transform_to_spp([_d, _d, _h], align="", pos="x")
    difference()
    {   
        hull()
        {
            // outer shell
            translate([-lgn_wt,0,0])
                cylinderpp(d=_d, h=_h, align=_a);
            // connection to the adapter holder
            transform_to_spp([_d,_d,_h], align=_a,pos="X")
                cubepp([lgn_wt,h_lgn_y,_h], align="X");

        }

        translate([-lgn_wt,0,(is_up ? 1 : -1)*_hd/2])
        {
            // shaft hole
            cylinderpp(d=shaft_d, h=_H, align=_a);

            // assembly shaft hole
            _hole_d = 3*shaft_d/4; //shaft_d-2*lgn_wt;
            cubepp([_d, _hole_d , _H], align=str(_a,"X"));
        }
    }
}

module holder_lgn(has_hooks=true)
{

    // main body
    difference()
    {
        // holder
        _mods = [round_edges(r=lgn_wt,axes="xy")];
        cubepp(h_lgn_size, align="", mod_list=_mods);

        // inner space
        translate([0, 0, lgn_wt])
            cubepp(a_lgn_size, align="");

        // hole for the power coord
        transform_to_spp(a_lgn_size, align="", pos="xz")
            translate([pc_off, 0, 2*lgn_wt])
                cubepp([pc_w+2*lgn_clrn, pc_t+2*lgn_clrn, 3*lgn_wt], align="xZ");

    }

    if(has_hooks)
    {
        // lower hook 
        transform_to_spp(h_lgn_size, align="", pos="xz")
            __hook_lgn(false);

        // upper hook
        transform_to_spp(h_lgn_size, align="", pos="xZ")
            __hook_lgn();
    }
}

//holder_lgn();

//__hook_lgn();