include<../solidpp/solidpp.scad>

d = 5;
z = 1.2;
off = 1;

$fn=60;

module dot()
{
    cylinder(h=z, d=d);
}

module dots(n)
{
    for (i=[0:n])
    {
        _d = i*(d+off);
        translate([_d, 0, 0])
            render(1)
                dot();
    }
        
}

rep_x = 10;
rep_x2 = 5;
_d = d+off;

translate([_d,0,0])
    dots(rep_x);

translate([_d,0,0])
    rotate([0,0,60])
        translate([_d,0,0])
            rotate([0,0,-60])
                dots(rep_x);

translate([_d,0,0])
    rotate([0,0,-60])
        translate([_d,0,0])
            rotate([0,0,60])        
                dots(rep_x);

translate([rep_x2*_d,0,0])
    rotate([0,0,-60])
        translate([2*_d,0,0])
            rotate([0,0,60])        
                dots(rep_x2);

translate([rep_x2*_d,0,0])
    rotate([0,0,-60])
        translate([3*_d,0,0])
            rotate([0,0,60])        
                dots(rep_x2);


translate([rep_x2*_d,0,0])
    rotate([0,0,60])
        translate([2*_d,0,0])
            rotate([0,0,-60])        
                dots(rep_x2);

translate([rep_x2*_d,0,0])
    rotate([0,0,60])
        translate([3*_d,0,0])
            rotate([0,0,-60])        
                dots(rep_x2);