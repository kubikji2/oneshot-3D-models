include<../../solidpp/solidpp.scad>

// include other models
include<shaft-constants.scad>
include<power-cord-constants.scad>

include<adapter-legion.scad>
include<adapter-lenovo-65W.scad>
include<adapter-usb-c-65W.scad>

$fn = $preview ? 30 : 120;

// arm params
arm_w = 20.5;
// '-> width
arm_h = 30;
// '-> height
arm_wt = 2;

// cable
pc_d = 6.5;
// '-> power cable hook
pc_h = 7;
// '-> height
pc_wt = 2;
pc_h_wt = 1.5;
// '-> wall thickness
pc_clrn = 0.2;
// ' -> clearance

module cable_hook()
{

}


// legion sleeve
module legion_sleeve()
{
    translate([lgn_h/2 + lgn_wt,lgn_t/2 + lgn_wt, lgn_l/2 + lgn_wt/2])
        holder_lgn(false);
}


// usb c sleeve
module usb_c_sleeve()
{
    translate([w65_h_c/2 + w65_wt_c/2, -w65_t_c/2 - w65_wt_c, w65_l_c/2 + w65_wt_c/2])
        holder_65w_usb_c(false);
}


// legion sleeve
module lenovo_sleeve()
{
    translate([-w65_h_l/2 - w65_wt_l/2, -w65_t_l/2 - w65_wt_l, w65_l_l/2 + w65_wt_l/2])
        holder_65w_lenovo(false);
}


// cable hook
module cable_hook()
{   
    _d = pc_d + pc_clrn;
    _D = pc_d + 2*pc_h_wt;
    _h = pc_h;

    translate([0, _D/2 + pc_wt, 0])
    difference()
    {
        hull()
        {
            cylinderpp(d=_D, h=_h, align="z");
            
            transform_to_spp([_D,_D,_h], align="z", pos="yz")
                cubepp([_D,pc_wt,_h],align="Yz");
        }

        // middle hole
        cylinderpp(d=_d, h=3*_h, align="");

        // entry hole
        cubepp([3*_d/4,_D,3*_h], align="y");
    }
}


module cable_holder(w)
{
    cubepp([w, pc_wt, arm_h], align="XyZ");
    
    _D = pc_d+2*pc_wt;
    _odd_d = (w-lgn_wt-3*_D)/3;
    for(i=[0:2])
    {
        _off = _odd_d/2 +  _D/2 + i*(_D + _odd_d);
        translate([-_off,0,-pc_h])
            cable_hook();
    }
    
}


module adapters_arm_holder()
{
    _x = w65_h_c + w65_h_l + 3*w65_wt_c;
    _z = min([lgn_l, w65_l_c, w65_l_l]);
    difference()
    {
        union()
        {
            // legion region
            translate([-_x/2,arm_w/2,0])
            {
                legion_sleeve();
            }

            // add cable holders
            translate([_x/2, arm_w/2, _z])
                cable_holder(w=_x-lgn_h-lgn_wt);

            _65w_off = w65_h_l - w65_h_c;
            translate([_65w_off/2,-arm_w/2,0])
            {
                // 65W adapters area
                // USB-C 65W adapter
                usb_c_sleeve();
                // lenovo 65W adapter
                lenovo_sleeve();
                // middle wall
                _wb_x = max(w65_wt_c, w65_wt_l);
                _wb_y = w65_t_c + 2*w65_wt_c;
                _wb_z = min(w65_l_c, w65_l_l) + w65_wt_l;
                cubepp([_wb_x, _wb_y, _wb_z], align="zY");
            }

            // top plane
            translate([0,0,_z])
                cubepp([_x, arm_w + 2*arm_wt, arm_wt], align="Z", mod_list=[round_edges(r=arm_wt)]);
        }

        // cut
        translate([0,0,_z])
            cubepp([150, 150, 150], align="z");
        //%cubepp([_x, arm_w, arm_h], align="z");
    }
    
   


    
}

adapters_arm_holder();
