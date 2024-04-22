// solidpp
include<../solidpp/solidpp.scad>

// bolts
include<../deez-nuts/deez-nuts.scad>

// motor parameters
mot_d = 27.7;
// '-> motor diameter
mot_b_h = 38;
// '-> motor body heights
mot_s_d = 10;
// '-> motor stud diameter
mot_s_h = 3.3;
// '-> motor stud height
mot_c_h = 7;
// '-> motor contacts height

// switch paramters
sw_l = 20;
// '-> switch length
sw_w = 13;
// '-> switch width
sw_h = 18;
// '-> switch height including the contacts
sw_off = 1;
// '-> switch offset

// mount points
mnt_g = 15.2;
// '-> mount gauge
mnt_d = 2;
// '-> mount diameters 

// fastener parameters
fst_l = 6;
// '-> fastener length
fst_d = mnt_d;
// '-> fastener diameter
fst_h_d = 4;
// '-> fastener head diameter
fst_h_h = 0.5;
// '-> fastener head height

$fn = $preview ? 30 : 120;

// fastener hole
module fastener_hole(clearance=0.25, align="t")
{
    basic_bolt_hole(hh=fst_h_h,
                    hd=fst_h_d,
                    sh=fst_l,
                    sd=fst_d,
                    clearance=clearance,
                    align=align);
}

// decided parameters
wt = 3;
// '-> wall thickness
erg_r = 50;
// '-> erg radius
erg_depth = wt;
// '-> erg depth
erg_z_off = 20;
// '-> erg z_off
erg_rounding = 2.5;
// '-> erg rounding

// lid fasteners
lf_bolt_standard = "DIN84A";
lf_bolt_descriptor = "M3x10"; 
lf_nut_standard = "DIN562";
lf_nut_d = 3;

lid_tf_z = mot_b_h + mot_c_h + sw_off + sw_w/2;
lid_mount_off = -3;
lid_mount_x = 10+lid_mount_off;
lid_mount_y = 8;
lid_mount_z_off = wt;
lid_mount_z = mot_b_h + mot_c_h + 2*sw_off + sw_w + wt - lid_tf_z + lid_mount_z_off;

// cable hole
cbl_x = 4;
cbl_y = 2;


lf_tf = [   mot_d/2+wt, 
            -get_bolt_head_diameter(descriptor=lf_bolt_descriptor, standard=lf_bolt_standard),
            lid_tf_z];

module motor(clearance = 0.5, additional_space = 10)
{
    // stud hole
    translate([0,0,clearance])
        cylinderpp(d=mot_s_d+2*clearance, h=additional_space+mot_s_h+clearance, align="Z");
    // motor hole
    translate([0,0,-clearance])
        cylinderpp(d=mot_d+2*clearance, h=mot_b_h+clearance+additional_space);

}

module lid_mount()
{
    rotate([180,0,0])
    {
        difference()
        {
            // main body
            union()
            {
                translate([0, 0, lid_mount_z_off])
                {
                    cubepp([lid_mount_x, lid_mount_y, lid_mount_z], align="XZ");
                
                    translate([-lid_mount_x, 0, -lid_mount_z])
                            cubepp([lid_mount_z/2, lid_mount_y, lid_mount_z/2], align="Xz");
                }
            }

            // rounding 
            translate([-lid_mount_x, 0, lid_mount_z_off-lid_mount_z/2])
                cylinderpp(r=lid_mount_z/2,h=2*lid_mount_y,zet="y", align="X");

            // mounting hole
            rotate([0,90,0])
            {
                bolt_hole(descriptor=lf_bolt_descriptor, standard=lf_bolt_standard, align="t");

                translate([0,0,-5])
                    rotate([0,0,180])
                        nut_hole(d=lf_nut_d, standard=lf_nut_standard, s_off=10, clearance=0.25, align="m");
            }


        }   
    }
}

// body shape
module body(clearance=0.25)
{

    _wt = wt - erg_rounding;
    _d = 2*_wt+mot_d;
    _h_off = mot_c_h + sw_w+2*sw_off;
    _h = mot_b_h + _h_off + 2*_wt;
    sw_tf = [0, _d/2, mot_b_h + mot_c_h + sw_off + sw_w/2-erg_rounding];

    difference()
    {   
        
        render(10)
        minkowski()
        {
            translate([0,0,erg_rounding])            
                //union()
                //{
                    // main shape with ergnonomic pertrusion
                    difference()
                    {
                        // main shape
                        hull()
                        {
                            cyl_mod_list=[round_bases(r=wt-erg_rounding)];
                            cylinderpp(d=_d,h=_h,mod_list=cyl_mod_list);
                            
                            // swich part
                            cub_mod_list = [round_edges(r=sw_off, axes="xz")];
                            _x = 2*sw_off + sw_l;
                            _z = 2*sw_off + sw_w;
                            translate(sw_tf)
                                cubepp([_x, wt,_z], align="Y", mod_list=cub_mod_list);
                        }

                        // ergonomic hole
                        mirrorpp([1,0,0], true)
                            translate([_d/2-erg_depth+clearance, 0, erg_z_off])
                                difference()
                                {
                                    cylinderpp(r=erg_r, h=_h, zet="y", align="x");
                                    translate([erg_r,0,0])
                                    for(i=[-3:3])
                                    {   
                                        rotate([0,i*5,0])
                                            translate([-erg_r-2,0,0])
                                                cylinderpp(d=erg_depth, h=_h, zet="y",align="x");
                                    }
                                }
                    }

                //}
        
            // make it smoother
            spherepp(r=erg_rounding);
        
        }

        // motor hole
        translate([0,0,wt])
            motor(additional_space=_h_off);
   

        // fastener holes
        mirrorpp([1,0,0], true)
            translate([mnt_g/2,0,0])
                rotate([180,0,0])
                    fastener_hole();

        // switch hole
        translate(sw_tf+[0,erg_rounding+0.1,0])
            cubepp([sw_l, sw_h, sw_w], align="Y");

        // cut top off
        translate([0,0,mot_b_h+_h_off])
        {
            // outer cut
            tubepp(D=2*mot_d,d=mot_d+wt,h=clearance, align="z");
            
            // vertical cut
            tubepp(D=mot_d+wt,d=mot_d+wt-2*clearance, h=1, align="z");

            // inner cut
            translate([0,0,1])
                cylinderpp(d=mot_d+wt, h=clearance, align="z");   
        }

        // lid mounting holes
        mirrorpp([1,0,0], true)
            translate(lf_tf)
                rotate([0,90,0])
                    bolt_hole(descriptor=lf_bolt_descriptor, standard=lf_bolt_standard, align="t");
        
        // top hole
        cubepp([cbl_x+2*clearance, cbl_y+2*clearance, 2*_h], align="z", mod_list=[round_edges(r=cbl_y/2)]);
    }

    // add mount to the lid
    intersection()
    {
        mirrorpp([1,0,0], true)
            translate(lf_tf+[lid_mount_off,0,0])
                lid_mount();

        translate([0,0,wt])
            motor(additional_space=2*_h_off, clearance=0);
    }
}


body();