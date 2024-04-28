$fn = 90;
eps = 0.01;

t = 5;

a = 95;
b = 50;
h = 30+t/2;

difference()
{
    hull()
    {
        translate([0,0,0]) cylinder(h=h, d=t);
        translate([a,0,0]) cylinder(h=h, d=t);
        translate([a,b,0]) cylinder(h=h, d=t);
        translate([0,b,0]) cylinder(h=h, d=t);
    }
    
    translate([0,0,t/2]) cube([a,b,h]);
}

