$fn = 180;

D = 80;
d = 2.5;
l = D/2-2-d/2;
h = 4;
t = 1;

module lamp_cover()
{
    cylinder(d=D,h=t);
    for(i=[0:2])
    {
        rotate([0,0,120*i])
            translate([l,0,t])
                cylinder(d=d,h=h);
    }
}

lamp_cover();