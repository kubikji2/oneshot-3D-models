// general parameters
$fn = 90;
eps = 0.01;
tol = 0.2;

// tool case dimensions including sufficient tolerance
tc_x = 150;
tc_y = 60;
tc_z = 150;

// electronic case holder
ec_x = 110;

// wall thickness
wt = 2.5;

// screw parameters
s3_hd = 7;
s3_hh = 2.5;
s3_d = 3.5;


module screw_hole(h=2*wt)
{
    // remaining height of the hole
    _dh = h-s3_hh;
    
    // remaining hole
    cylinder(d=s3_d, h=_dh);
    
    // head hole
    translate([0,0,_dh]) cylinder(d1=s3_d, d2=s3_hd, h=s3_hh);
    
}

//screw_hole();

module main_holder(c_x = tc_x, c_y = tc_y, c_z = tc_z)
{
    _x = 2*wt + c_x;
    _y = 3*wt + c_y;
    _z = wt+ c_z;
    
    // defining sizes of cuts
    // cut coeffient multiplier, e.g. how big are top and bottom stripes in relation to the total height z
    __ccf = 0.25;
    // stripe size in z
    _ss = __ccf*c_z;
    
    
    difference()
    {
        // main geometry
        cube([_x,_y,_z]);
        
        // main cut for the case
        translate([wt,wt,wt])
            cube([c_x,c_y,c_z+eps]);
        
        // front cut for accessing the screws
        translate([wt,-eps,wt+_ss])
            cube([c_x, wt+2*eps, c_z-2*_ss]);
        
        // screw holes cut
        // screw holes offset
        _sc_o = wt+s3_hd;
        _sc_xo = _sc_o;
        _sc_yo = _y;
        _sc_zo = _sc_o+_ss;
        
        // screws positions
        scp = [ [_sc_xo,_sc_yo,_sc_zo],
                [_x-_sc_xo,_sc_yo,_sc_zo],
                [_sc_xo,_sc_yo,_z-_sc_zo],
                [_x-_sc_xo,_sc_yo,_z-_sc_zo],
                ];
        for (pos = scp)
        {
            translate(pos)
                rotate([90,0,0])
                    screw_hole();
        }
        
    }
}

//translate([ec_x+3*wt,0,0]) main_holder();

module eletronic_holder()
{
    main_holder(c_x = ec_x, c_y = tc_y, c_z = tc_z);
}


eletronic_holder();