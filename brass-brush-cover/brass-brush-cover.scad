include<../solidpp/cylinderpp.scad>
include<../solidpp/cubepp.scad>
include<../solidpp/spherepp.scad>

include<../solidpp/transforms/transform_to_spp.scad>

brsh_l = 40+5;
// '-> relevant brush area length

c_clrn = 0.2;
// '-> clearance

plst_h = 6.5 + 2*c_clrn;
// '-> plastic height
plst_w = 12.5 + 2*c_clrn;
// '-> plastic width

wrs_h = 14 + 2*c_clrn;
// '-> wires height
wrs_w = 9 + 2*c_clrn;
// '-> wires width

// cover parameters
c_wt = 2;
// '-> cover wall thickness
c_x = brsh_l + c_wt;
c_y = max(wrs_w,plst_w) + 2*c_wt;
c_z = wrs_h+plst_h + 2*c_wt;
c_size = [c_x,c_y,c_z];


module cover()
{
    difference()
    {
        // main shape
        _eps = $preview ? 0.001 : 0;
        _a = "xz";
        _mods = [bevel_corners(4)];
        cubepp(c_size, align=_a, mod_list=_mods);

        translate([-_eps, 0, 0])
        {
            // plastic hole
            translate([0,0,c_wt])
                cubepp([brsh_l,plst_w, plst_h], align=_a);    
            
            // wires hole
            translate([0,0,c_wt+plst_h-_eps])        
                hull()
                {
                    _size = [brsh_l,wrs_w, wrs_h+_eps]; 
                    cubepp(_size, align=_a);
                    
                    transform_to_spp(_size,align=_a, pos="xZ")
                        cubepp([brsh_l, plst_w, 0.001],align=_a);
                }    
        }

    }

}

cover();