include <../../../solidpp/solidpp.scad>

// electric tester
et_l = 127;
// '-> length
et_t = 11;
// '-> thickness
et_w = 19.2;
// '-> width

et_body_l = 65;
// '-> body length
et_tip_d = 6;
// '-> tip diameter
et_clip_w = 12;
// '-> clip width

// case
c_wt = 2;
// '-> wall thickness
c_cr = 2;
// '-> corner radius
clrn = 0.2;

$fn = 60;
eps = $preview ? 0.01 : 0;


module electric_tester_holes()
{
    translate([0,0,-eps])
    {
        hull()
        {
            // basic hole
            cubepp([et_w,et_t,et_body_l], align="z");
            // add cuts off
            cubepp([et_w+2*clrn, et_t+2*clrn, 0.1], align="z");
            // add tip
            translate([0,0,et_l])
                cylinderpp(d=et_tip_d+2*clrn,h=0.1,align="Z");
            
        }

        // add side hole
        translate([0,0,-c_wt])
        cubepp([et_clip_w, et_t+c_wt, et_body_l+2*c_wt+eps], align="yz",
                            mod_list=[round_edges(r=c_cr, axes="xz")]);
    }
}


module electric_tester_case()
{

    difference()
    {
        hull()
        {
            cubepp( [et_w+2*c_wt, et_t+2*c_wt, et_body_l+c_wt],
                    align="z",
                    mod_list=[round_edges(r=c_cr)]);
            
            translate([0,0,et_l+2*c_wt])
                cylinderpp( d=et_tip_d+2*c_wt,
                            h=3*c_cr,
                            mod_list=[round_bases(r=c_cr)],
                            align="Z");
        }

        electric_tester_holes();
    }

    //cylinder(d=10,h=et_l+2*c_wt);


}

electric_tester_case();