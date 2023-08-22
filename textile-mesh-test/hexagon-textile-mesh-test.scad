include<../solidpp/solidpp.scad>

x = 25;
y = 50;
z = 2;
wt = 2;
R = 5;
r = R - wt;
off = 1;

D_o = 20;
D_i = D_o-2*wt;

$fn=60;

module round_hexagon(R, r, h)
{
    translate([0,0,-h/2])
    linear_extrude(h)
    {   
        pts = [ for (i=[0:5]) (R-r)*[sin(i*360/6), cos(i*360/6)]];
        offset(r=r)
            polygon(points = pts);
    }   
}

module block()
{
    difference()
    {
        round_hexagon(R=D_o/2, r=r, h=z);
        round_hexagon(R=D_i/2, r=r-wt, h=2*z);
    }
}

block();

_D = D_o+off;

translate([_D,0,0])
    block();

translate(2*[_D,0,0])
    block();

translate([_D,0,0])
    rotate([0,0,60])
        translate([_D,0,0])
            block();

rotate([0,0,60])
    translate([_D,0,0])
        block();

/*
difference()
{
    size_outer = [x,y,z];
    size_inner = size_outer - 2*[wt,wt,-z];

    ml_outer = [round_edges(r=R)];
    ml_inner = [round_edges(r=r)];

    tupepp();

    cylinder(size_outer, mod_list=ml_outer, align="z");
    cylinder(size_inner, mod_list=ml_inner, align="");
}
*/