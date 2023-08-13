include<../../solidpp/cubepp.scad>
include<../../solidpp/cylinderpp.scad>
include<../../solidpp/spherepp.scad>
include<../../solidpp/modifiers/modifiers.scad>

// fn
$fn=60;

EPS = $preview ? 0.01 : 0;

// clearances
clrn_free = 0.2;

// based on datasheet at:
// https://www.meanwell-web.com/content/files/pdfs/productPdfs/MW/Rs-150/RS-150-spec.pdf

// PSU dimensions
psu_x = 98;
psu_y = 38;
psu_z = 199;
psu_off = 61;

// spacer parameters
spacer_t = 2.5;
// '-> spacer thickness guided by existing print
spacer_wt = 2;
// '-> spacer wall thickness

// bolt parameters
bolt_d = 3;
// '-> bolt diameter
bolt_h = 8;
// '-> bold height

// bolt positions
bp_1 = [psu_x-7-85.5, 0, psu_z-4.5];
// '-> top most bolt
bp_2 = [psu_x-9-80, 0, psu_z-4.5-57.5];
// '-> middle left bolt
bp_3 = [psu_x-9, 0, psu_z-4.5-57.5];
// '-> middle left bolt
bp_4 = [psu_x-9-80, 0, psu_z-4.5-57.5-120];
// '-> middle left bolt
bp_5 = [psu_x-9, 0, psu_z-4.5-57.5-120];
// plate parameters
plt_t = 3;
// '-> plate thickness

// cable-holder wall thickness
wall_t = 10;

// table thickness
table_t = 40;

// free space size
space_h = 40;

module hullify(pts)
{
    for(i=[0:len(pts)-2])
    {
        hull()
        {
            translate(pts[i])
                children();
            translate(pts[i+1])
                children();
        }
    }
}

module hook(l=psu_z/5, t=wall_t+plt_t, off=2)
{   
    points = [  [  0, 0, 0],
                [  0, -t, 0],
                [  0, -t+off, -l]
             ];
    hullify(pts=points)
        children();
}

module peg(t=15,l=15)
{
    points = [  [  0, 0, 0],
                [  0,-t, 0],
                [  0, 0, -l]
             ];
    hullify(pts=points)
        children();
}

module bolt()
{
    translate([0,EPS,0])
        cylinderpp(d=bolt_d+2*clrn_free, h=bolt_h, zet="y", align="");
}

module spacer()
{
    _z = bolt_d + 2*spacer_wt;
    _size = [psu_x, spacer_t, _z];
    _mods = [round_edges(spacer_wt, axes="xz")];

    _d = bolt_d + 2*clrn_free;
    
    difference()
    {
        cubepp(_size, align="x", mod_list=_mods);

        // left hole
        translate([bp_2[0],0,0])
            cylinderpp(d=_d, h=2*spacer_t, align="", zet="y");

        // right hole
        translate([bp_3[0],0,0])
            cylinderpp(d=_d, h=2*spacer_t, align="", zet="y");
    }
}

// piece with contact to the table
module plate()
{
    _size = [psu_x,plt_t,psu_z+psu_off];
    _mods = [round_edges(1, axes="yz")];

    translate([0,0,-psu_off])
    cubepp(_size, align="xYz", mod_list=_mods);
}

module psu()
{
    cube([psu_x, psu_y, psu_z]);
}


module main()
{
    %psu();
    difference()
    {
        plate();

        #
        translate([0,0,-psu_off])
        {
            // bolt 1
            translate(bp_1)
                bolt();
            // bolt 2
            translate(bp_2)
                bolt();
            // bolt 3
            translate(bp_3)
                bolt();
            // bolt 4
            translate(bp_4)
                bolt();
            // bolt 5
            translate(bp_5)
                bolt();
        }

    }

    // hook
    translate([0,0,psu_z-table_t-space_h])
        hook()
            cylinderpp(d=plt_t,h=psu_x, zet="x", align="xYz");

    // peg
    translate([0,0,psu_z-table_t])
        peg()
            cylinderpp(d=plt_t,h=psu_x, zet="x", align="xYZ");

}

main();

//spacer();