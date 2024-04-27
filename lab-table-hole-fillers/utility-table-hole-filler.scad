include<../solidpp/solidpp.scad>


d = 60;
h = 18;
wt = 2;
$fn = 120;

tubepp(D=d, h=h, t=wt, align="z");

hull()
{
    cylinder(h=0.001, d=d+2*wt);
    
    translate([0, 0, -wt])
        cylinder(h=0.001, d=d);
}

