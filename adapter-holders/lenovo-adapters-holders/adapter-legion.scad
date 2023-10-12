include<../../solidpp/cylinderpp.scad>
include<../../solidpp/cubepp.scad>
include<../../solidpp/spherepp.scad>

include<../../solidpp/transforms/transform_to_spp.scad>

include<shaft-constants.scad>
include<power-cord-constants.scad>
use<shaft-hook.scad>

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

module __hook_lgn(is_up=true, clearance=0.5)
{
    shaft_hook( length=lgn_l,
                width=h_lgn_y,
                wall_thickness=lgn_wt,
                shaft_diameter=shaft_d,
                clearance=clearance,
                is_up=is_up);
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