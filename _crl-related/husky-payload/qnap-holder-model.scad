
use<../../solidpp/solidpp.scad>
use<../../deez-nuts/deez-nuts.scad>

include<qnap-dimensions.scad>
include<qnap-holder-parameters.scad>

include<item-20-dimensions.scad>

module qnap_holder(clearance=0.2)
{

    // qnap dummy
    _qx = qnap_x + 2*clearance;
    _qy = qnap_y + 2*clearance;
    _qz = qnap_z + 2*clearance;

    difference()
    {

        // main body
        union()
        {
            _x = qnap_x +2*qh_wt;
            _y = qnap_y +2*qh_wt;
            _z = qnap_z +qh_wt + qh_bt;
            // bottom
            cubepp([_x,_y,qh_bt], align="z");
            
            // clip in arms
            difference()
            {
                mirrorpp([1,0,0], true)
                    translate([_x/2,0])
                    {
                        //coordinate_frame();
                        //cubepp([qh_wt, qnap_y-2*clearance, qnap_off], align="Xz");


                        cubepp([qh_grip_w+qh_wt, _y, _z],
                                align="Xz",
                                mod_list=[round_edges(r=qh_wt, axes="yz")]);

                    }

                // qnap hole
                translate([0,0,qh_bt-clearance]) 
                    cubepp([_qx,_qy,_qz], align="z");

                // slide in hole
                translate([0,0,qh_bt+qnap_off]) 
                    cubepp([2*_qx,_qy,_qz-qh_wt], align="z");

                // arm cuts
                translate([0,0,qh_bt+qnap_off]) 
                    cubepp([2*_qx,_qy-2*qh_stopper,2*_qz], align="z");


            }

            // item align
            cubepp([item20_w, _y, 1.5], align="Z");
            //%cubepp([item20_w, _y, item20_d], align="Z");


        }
        

        //translate([0,0,qh_bt-clearance]) 
        //    cubepp([qnap_x,qnap_y,qnap_z], align="z");
        

        //
        translate([0,0,qh_bt]) 
            bolt_hole(
                descriptor=qh_bolt_descriptor,
                standard=qh_bolt_standard,
                align="t");

    }

    

}


$fa = $preview ? 10 : 5;
$fs = $preview ? 0.1: 0.05;

qnap_holder();