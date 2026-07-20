use<../../solidpp/solidpp.scad>
use<../../deez-nuts/deez-nuts.scad>

include<ouster-interface-box-holder-parameters.scad>
include<ouster-interface-box-dimensions.scad>

include<item-20-dimensions.scad>


module ouster_interface_box_holder()
{

    // monolith
    _mx = oib_fastener_g_x+oibh_hi_d+2*oibh_wt;
    _mz = oib_z;//oib_fastener_g_z+oibh_hi_d+2*oibh_wt;

    difference()
    {
        union()
        {
            //item interface
            cubepp([oib_x,item20_a,oibh_bt],
                    align="z",
                    mod_list=[round_edges(d=item20_a, axes="xy")]);



            cubepp([_mx, item20_a, _mz],
                    align="z",
                    mod_list=[round_edges(r=oibh_wt, axes="xz")]);
        }

        // item bolt gauge
        _ibg = oib_x - item20_a;
        mirrorpp([1,0,0], true)
            translate([_ibg/2,0,oibh_bt])
                //coordinate_frame()
                    bolt_hole(
                        descriptor=oibh_bolt_descriptor,
                        standard=oibh_bolt_standard,
                        align="t");

        // holes for the head inserts
        translate([0,0,_mz/2])
            mirrorpp([1,0,0], true)
                mirrorpp([0,1,0], true)
                    mirrorpp([0,0,1], true)
                        translate([oib_fastener_g_x/2, item20_a/2, oib_fastener_g_z/2])
                            cylinderpp(h=oibh_hi_h, d=oibh_hi_d, align="Y", zet="y");


    }
}

$fa = $preview ? 10 : 5;
$fs = $preview ? 0.1: 0.05;

ouster_interface_box_holder();