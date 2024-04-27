include<../solidpp/solidpp.scad>

d = 5;
z = 1.2;
off = 1;

$fn=60;

module element()
{
    difference()
    {
        cylinderpp(h=z, d=d, align="");
        cylinderpp(h=2*z, d=2, align="");
    }
}

module elements(n)
{
    for (i=[0:n])
    {
        _d = i*(d+off);
        translate([_d, 0, 0])
            render(1)
                element();
    }
        
}

rep_x = 6;
rep_x2 = 5;
_d = d+off;


for (i=[0:6])
{
    translate([-floor(i/2)*_d,0,0])
        rotate([0,0,60])
            translate([i*_d,0,0])
                rotate([0,0,-60])
                    elements(rep_x);
}   

for (i=[0:rep_x-1])
{
    translate([-floor((6+i)/2)*_d,0,0])
        rotate([0,0,60])
            translate([6*_d + i*_d,0,0])
                rotate([0,0,-60])
                    elements(rep_x-i-1);
}   

/*

translate([_d,0,0])
    rotate([0,0,-60])
        translate([_d,0,0])
            rotate([0,0,60])        
                elements(rep_x);

translate([rep_x2*_d,0,0])
    rotate([0,0,-60])
        translate([2*_d,0,0])
            rotate([0,0,60])        
                elements(rep_x2);

translate([rep_x2*_d,0,0])
    rotate([0,0,-60])
        translate([3*_d,0,0])
            rotate([0,0,60])        
                elements(rep_x2);


translate([rep_x2*_d,0,0])
    rotate([0,0,60])
        translate([2*_d,0,0])
            rotate([0,0,-60])        
                elements(rep_x2);

translate([rep_x2*_d,0,0])
    rotate([0,0,60])
        translate([3*_d,0,0])
            rotate([0,0,-60])        
                elements(rep_x2);

*/