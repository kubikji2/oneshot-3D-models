include<../../solidpp/cylinderpp.scad>
include<../../solidpp/cubepp.scad>
include<../../solidpp/spherepp.scad>

include<../../solidpp/transforms/transform_to_spp.scad>

include<shaft-constants.scad>
include<power-cord-constants.scad>

w65_clrn = 0.2;

// adapter parameters
w65_l_l = 128  + 2*w65_clrn;
// '-> length
w65_h_l = 53   + 2*w65_clrn;
// '-> height
w65_t_l = 30   + 2*w65_clrn;
// '-> thickness

w65_wt_l = 2;
// '-> wall thickness

// adapter (hole) dimensions
a_65w_x_l = w65_h_l;
a_65w_y_l = w65_t_l;
a_65w_z_l = w65_l_l+2*w65_wt_l;
a_65w_size_l = [a_65w_x_l, a_65w_y_l, a_65w_z_l];

// holder dimensions
h_65w_x_l = w65_h_l + 2* w65_wt_l; 
h_65w_y_l = w65_t_l + 2* w65_wt_l;
h_65w_z_l = w65_l_l +    w65_wt_l; 
h_65w_size_l = [h_65w_x_l, h_65w_y_l, h_65w_z_l];

$fn = $preview ? 30 : 60;

// power coord parameters
pc_off_l = 7;
// '-> offset

module __hook_65w_lenovo(is_up=true)
{
    _h = w65_l_l/4;
    _H = _h+w65_wt_l;
    _hd = _H-_h;
    _d = shaft_d+2*w65_wt_l;
    _a = is_up ? "Z" : "z";
    
    translate([w65_wt_l,0,0])
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
                cubepp([w65_wt_l,h_65w_y_l,_h], align="X");

        }

        translate([0,0,(is_up ? 1 : -1)*_hd/2])
        {
            // shaft hole
            translate([-lgn_wt,0,0])
                cylinderpp(d=shaft_d, h=_H, align=_a);

            // assembly shaft hole
            _hole_d = 3*shaft_d/4; //shaft_d-2*w65_wt_l;
            cubepp([_d, _hole_d , _H], align=str(_a,"X"));
        }
    }
}

module holder_65w_lenovo(has_hooks=true)
{

    // main body
    difference()
    {
        // holder
        _mods = [round_edges(r=w65_wt_l,axes="xy")];
        cubepp(h_65w_size_l, align="", mod_list=_mods);

        // inner space
        translate([0, 0, w65_wt_l])
            cubepp(a_65w_size_l, align="");

        // hole for the power coord
        transform_to_spp(a_65w_size_l, align="", pos="xz")
            translate([pc_off_l, 0, 2*w65_wt_l])
                cubepp([pc_w+2*w65_clrn, pc_t+2*w65_clrn, 3*w65_wt_l], align="xZ");

    }

    if(has_hooks)
    {
        // lower hook
        transform_to_spp(h_65w_size_l, align="", pos="xz")
            __hook_65w_lenovo(false);

        // upper hook
        transform_to_spp(h_65w_size_l, align="", pos="xZ")
            __hook_65w_lenovo();
    }

}

//holder_65w_lenovo();

//__hook_65w_lenovo();