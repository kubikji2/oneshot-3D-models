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
mot_c_h = 5.6;
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
mnt_g = 15;
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

module faster_bolt()
{

}

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

module motor(clearances = 0.25, additional_space = 10)
{
    // stud hole
    translate([0,0,clearances])
        cylinderpp(d=mot_s_d+2*clearances, h=additional_space+mot_s_h+clearances, align="Z");
    // motor hole
    translate([0,0,-clearances])
        cylinderpp(d=mot_d+2*clearances, h=mot_b_h+clearances+additional_space);

}

module body()
{
    difference()
    {

        _d = 2*wt+mot_d;
        _h = 2*wt+mot_b_h+sw_w+2*sw_off;
        sw_tf = [0, _d/2, mot_b_h + sw_off + sw_w/2];

        hull()
        {
            cyl_mod_list=[round_bases(r=wt)];
            cylinderpp(d=_d,h=_h,mod_list=cyl_mod_list);
            
            // swich part
            cub_mod_list = [round_edges(r=sw_off, axes="xz")];
            _x = 2*sw_off + sw_l;
            _z = 2*sw_off + sw_w;
            translate(sw_tf)
                cubepp([_x, wt,_z], align="Y", mod_list=cub_mod_list);
        }
        // motor hole
        translate([0,0,wt])
            motor(additional_space=20);
   

        // fastener holes
        mirrorpp([1,0,0], true)
            translate([mnt_g/2,0,0])
                rotate([180,0,0])
                    fastener_hole();

        // switch hole
        translate(sw_tf+[0,0.1,0])
            cubepp([sw_l, sw_h, sw_w], align="Y");

        // cut top off
        translate([0,0,_h-wt])
            cylinderpp(d=2*_d,h=_h);
    }
}


body();