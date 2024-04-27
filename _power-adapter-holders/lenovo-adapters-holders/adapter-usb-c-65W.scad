include<../../solidpp/cylinderpp.scad>
include<../../solidpp/cubepp.scad>
include<../../solidpp/spherepp.scad>

include<../../solidpp/transforms/transform_to_spp.scad>

include<shaft-constants.scad>
include<power-cord-constants.scad>

use<shaft-hook.scad>

w65_clrn = 0.2;

// adapter parameters
w65_l_c = 109  + 2*w65_clrn;
// '-> length
w65_h_c = 47   + 2*w65_clrn;
// '-> height
w65_t_c = 30 + 2*w65_clrn;
// '-> thickness

w65_wt_c = 2;
// '-> wall thickness

// adapter (hole) dimensions
a_65w_x_c = w65_h_c;
a_65w_y_c = w65_t_c;
a_65w_z_c = w65_l_c+2*w65_wt_c;
a_65w_size_c = [a_65w_x_c, a_65w_y_c, a_65w_z_c];

// holder dimensions
h_65w_x_c = w65_h_c + 2* w65_wt_c; 
h_65w_y_c = w65_t_c + 2* w65_wt_c;
h_65w_z_c = w65_l_c +    w65_wt_c; 
h_65w_size_c = [h_65w_x_c, h_65w_y_c, h_65w_z_c];

$fn = $preview ? 30 : 60;

module __hook_65w_usb_c(is_up=true, clearance=0.5)
{
    shaft_hook( length=w65_l_c,
                width=h_65w_y_c,
                wall_thickness=w65_wt_c,
                shaft_diameter=shaft_d,
                clearance=clearance,
                is_up=is_up);
}

module holder_65w_usb_c(has_hooks=true)
{

    // main body
    difference()
    {
        // holder
        _mods = [round_edges(r=w65_wt_c,axes="xy")];
        cubepp(h_65w_size_c, align="", mod_list=_mods);

        // inner space
        translate([0, 0, w65_wt_c])
            cubepp(a_65w_size_c, align="");

        // hole for the power coord
        transform_to_spp(a_65w_size_c, align="", pos="z")
            translate([0, 0, 2*w65_wt_c])
                cubepp([pc_w+2*w65_clrn, pc_t+2*w65_clrn, 3*w65_wt_c], align="Z");

    }

    if(has_hooks)
    {
        // lower hook
        transform_to_spp(h_65w_size_c, align="", pos="xz")
            __hook_65w_usb_c(false);

        // upper hook
        transform_to_spp(h_65w_size_c, align="", pos="xZ")
            __hook_65w_usb_c();
    }

}

//holder_65w_usb_c();

//__hook_65w_usb_c();