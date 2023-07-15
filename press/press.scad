// include cylinderpp
include <../solidpp/cylinderpp.scad>
// not intuitive, but spherepp must be included as well
include <../solidpp/spherepp.scad>
// include modifier
include <../solidpp/modifiers/modifiers.scad>

_r = 10;
_R = 50;
_h = 100;
_h_b = _h/3;
thickness = 4;
size = 2.5;

// spicy way to modify fn parameter for preview and f6 rendering
_fn = $preview ? 4 : 120;

// mod list is same for all basic solidpp geometries (cubepp, cylinerpp, tubepp, ...)
mod_list = [round_corners(_r)];
m_list = [round_corners(-_r)];

module press(){
    difference()
    {
        union()
        {
        cylinderpp(r=_R, h=_h+_r, mod_list=mod_list, $fn = _fn); //top cylinder
        translate([0, 0, -_h_b])  cylinderpp(r=_R, h=_h_b, mod_list=mod_list, $fn = _fn); //bottom cylinder
        cylinder(r=_R, h=_h_b, $fn = _fn, center = true); //unification of both
        }

        translate([0, 0, thickness]) cylinderpp(r=_R-thickness, h=_h+thickness, mod_list=mod_list, $fn = _fn); //hollow top cylinder
        translate([-_R, -_R, _h]) cube([2*_R, 2*_R, 2*_r]); // cut the top round corner

        translate([0, 0, -thickness-_h_b]) cylinderpp(r=_R-thickness, h=_h_b+thickness, mod_list=mod_list, $fn = _fn);//hollow bottom cylinder
        translate([-_R, -_R, - _h_b]) cube([2*_R, 2*_R, 2*_r]); // cut the bottom round corner

        for (phi = [0 : 15 : 360]) //holes on the very bottom
        {
            rotate([0, 0, phi]) translate([_R-thickness, 0, -_h_b+2*_r]) cube([3*thickness, thickness, 2*thickness], center = true);
        }

        for (phi = [0 : 5 : 360], z = [_r : 5 : 2*_h/3] ) // side holes
        {
            rotate([0, 0, phi]) translate([_R-thickness, 0, z+thickness]) cube([3*thickness, size, size], center = true);
        }
        intersection()
        {
            cylinder(r=_R - _r, h = _h, center = true);
            for(x = [-_R : 5 : _R], y = [-_R : 5 : _R])
            {
                translate([x, y, 0]) cube([size, size, 3*thickness], center = true);
            }
        }
    }
}    

w_offset = 0.5;
r_w = 10;
r_h = 15;
/*
module weight()
{
    union(){
        translate([0, 0, thickness]) cylinderpp(r=_R-thickness-w_offset, h=_h+thickness, mod_list=mod_list, $fn = _fn);
        translate([0, 0, thickness+_h+thickness]) cylinderpp(r=r_w-w_offset, h=_h+thickness, mod_list=m_list, $fn = _fn);
        translate([0, 0, thickness+_h+thickness]) cylinderpp(r1=r_w-w_offset+_r, r2=r_w-w_offset, h=_r, mod_list=m_list, $fn = _fn);
    }
}
*/

r2D = r_w-w_offset;
h2D = _h+thickness;

module weight()
{
    union(){
        translate([0, 0, thickness]) cylinderpp(r=_R-thickness-w_offset, h=_h+thickness, mod_list=mod_list, $fn = _fn);
        translate([0, 0, thickness+_h+thickness]) {
            rotate_extrude(angle = 360, convexity = 30){
                square([r2D, h2D], center = false);
                difference()
                {
                    translate([r2D, 0]) square([r2D, r2D], center = false);
                    translate([2*r2D, r2D]) circle(r2D);
                }
                difference()
                {
                    translate([r2D, h2D-r2D]) square([r2D, r2D], center = false);
                    translate([2*r2D, h2D-r2D]) circle(r2D);
                }
            }
        }
    }
}

press();
weight();