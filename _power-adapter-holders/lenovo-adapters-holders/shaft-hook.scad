// adding solidpp
include <../../solidpp/solidpp.scad>

// customizable hook
module shaft_hook(length, width, wall_thickness, shaft_diameter, clearance, is_up=true)
{
    _h = length/4;
    _H = _h+wall_thickness;
    _hd = _H-_h;
    _d = shaft_diameter+2*wall_thickness;
    _a = is_up ? "Z" : "z";
    _off = - wall_thickness - clearance; 
    
    translate([wall_thickness,0,0])
    transform_to_spp([_d, _d, _h], align="", pos="x")
    difference()
    {   
        hull()
        {
            // outer shell
            translate([_off,0,0])
                cylinderpp(d=_d, h=_h, align=_a);
            // connection to the adapter holder
            transform_to_spp([_d,_d,_h], align=_a,pos="X")
                cubepp([wall_thickness, width, _h], align="X");

        }

        translate([0,0,(is_up ? 1 : -1)*_hd/2])
        {
            // shaft hole
            translate([_off,0,0])
                cylinderpp(d=shaft_diameter, h=_H, align=_a);

            // assembly shaft hole
            _hole_d = 3*shaft_diameter/4; //shaft_d-2*length;
            cubepp([_d, _hole_d , _H], align=str(_a,"X"));
        }
    }
}