include<../../solidpp/cylinderpp.scad>
include<../../solidpp/cubepp.scad>
include<../../solidpp/spherepp.scad>

include<../../solidpp/transforms/transform_to_spp.scad>

include<shaft-constants.scad>
include<power-cord-constants.scad>

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

module __hook_65w_usb_c(is_up=true)
{
    _h = w65_l_c/4;
    _H = _h+w65_wt_c;
    _hd = _H-_h;
    _d = shaft_d+2*w65_wt_c;
    _a = is_up ? "Z" : "z";
    
    translate([w65_wt_c,0,0])
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
                cubepp([w65_wt_c,h_65w_y_c,_h], align="X");

        }

        translate([0,0,(is_up ? 1 : -1)*_hd/2])
        {
            // shaft hole
            translate([-lgn_wt,0,0])
                cylinderpp(d=shaft_d, h=_H, align=_a);

            // assembly shaft hole
            _hole_d = 3*shaft_d/4; //shaft_d-2*w65_wt_c;
            cubepp([_d, _hole_d , _H], align=str(_a,"X"));
        }
    }
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