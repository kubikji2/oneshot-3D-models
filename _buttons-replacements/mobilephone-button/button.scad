$fn = 90;
_h = 1.5;
_d = 3;
_l = 7;

hull()
{
    cylinder(h=_h,d=_d);
    translate([_l,0,0])
        cylinder(h=_h,d=_d);
}