include<../solidpp/cylinderpp.scad>
include<../solidpp/cubepp.scad>
include<../solidpp/spherepp.scad>

include<../solidpp/transforms/transform_to_spp.scad>

// key filler parameters
key_x = 12;
key_X = 16;

key_x_alt = 17;
key_X_alt = 21;

key_y = 13;
key_Y = 16;

key_z = 3;
kez_z_alt = 3;
key_Z = 4;

key_r = 0.5;

// hole for the screw
s_d = 1.7;

$fn = $preview ? 30 : 60;

module key_filler(is_alt=false)
{

    _x = is_alt ? key_x_alt : key_x;
    _X = is_alt ? key_X_alt : key_X;
    _y = key_y;
    _Y = key_Y;
    _z = is_alt ? kez_z_alt : key_z;
    _Z = key_Z;
    _dz = _Z-_z;

    _size = [_x,_y,_Z];
    _SIZE = [_X,_Y,0.001];

    difference()
    {
        _mods = [round_edges(r=key_r, axes="xy")];
        _a = "z";

        hull()
        {
            cubepp(_size, align=_a, mod_list=_mods);
            transform_to_spp(_size, align=_a, pos="Yz")
                cubepp(_SIZE, align="Yz", mod_list=_mods);
        }

        // adding curvature
        transform_to_spp(_size, align=_a, pos="Z")
            cylinderpp([_x + (is_alt ? 0 : 1), _Y, 2*_dz], zet="y", center=true);
        
        translate([0,0,-_dz/2])
            cylinderpp(d=s_d, h=_Z);

    }

}

key_filler(true);