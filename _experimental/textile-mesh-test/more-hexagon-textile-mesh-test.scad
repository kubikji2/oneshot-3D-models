include<../solidpp/solidpp.scad>

h = 1.2;
wt = 2;
R = 5;
r = R - wt;
off = 2;

D_o = 20;
D_i = D_o-2*wt;

$fn=30;

module round_triangle(R, r, h)
{
    translate([0,0,-h/2])
    linear_extrude(h)
    {   
        pts = [ for (i=[0:2]) (R-2*r)*[sin(i*360/3), cos(i*360/3)]];
        offset(r=r)
            polygon(points = pts);
    }
    //%cylinder(r=R,h=h);
}

module round_hexagon(R, r, h)
{
    translate([0,0,-h/2])
    linear_extrude(h)
    {   
        pts = [ for (i=[0:5]) (R-(2/sqrt(3))*r)*[sin(i*360/6), cos(i*360/6)]];
        offset(r=r)
            polygon(points = pts);
    }   
}

module block(alt=false)
{
    
    if (alt)
    {
        for (i=[0:5])
        {
            _off = 0.1;
            _D = (D_o/4);
            rotate([0,0,30+i*60])
                translate([0, -_D,0])
                    difference()
                    {                    
                        round_triangle(R = _D, r = 1, h = h);
                        //echo(D_i/4-off-wt);
                        round_triangle(R = _D-off-wt, r = 0, h = 2*h);  
                    }  
        }
        #cylinder(d=D_o);
        %round_hexagon(R=D_o/2, r=0, h=2*h);
    }
    else
    {
        difference()
        {
            round_hexagon(R=D_o/2, r=r, h=h);
            round_hexagon(R=D_i/2, r=r-wt, h=2*h);
        }
    }

    //%round_hexagon(R=D_o/2, r=0, h=h);
    //%cylinder(r=D_o/2, h=h);
    //#round_hexagon(R=D_o/2, r=0, h=h);

}

module blocks(n_blocks, l)
{
    for (i=[0:n_blocks])
    {
        _d = i*l;
        translate([_d, 0, 0])
            //render(1)
                block();
    }
}

rep_x = 3;
rep_x2 = 5;
_l = sqrt(D_o*D_o-(D_o/2)*(D_o/2))+off;


for (i=[0:rep_x])
{
    translate([-floor(i/2)*_l,0,0])
        rotate([0,0,60])
            translate([i*_l,0,0])
                rotate([0,0,-60])
                    blocks(rep_x, _l);
}

