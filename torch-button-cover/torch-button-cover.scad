include<../solidpp/solidpp.scad>


a = 13;
b = 16;
c = 0.8;
cr = 2;

D = 10.5;
d = 9;

H = 5;
h = 2.5;

$fn = $preview ? 30 : 120;

module button_cover()
{
    
    difference()
    {
        union()
        {
            mod_list = [round_edges(r=cr)];
            size = [a,b,c];
            cubepp(size, mod_list=mod_list, align="z");


            translate([0,0,c])
                cylinderpp(d=D,h=H);

            translate([0,0,c+H])
                spherepp(size=[D,D,2*h]);
        }

        wt = (D-d)/2;

        cylinderpp(d=d,h=2*(H+c), align="");

        translate([0,0,c+H])
            spherepp(size=[D-2*wt,D-2*wt,2*(h-wt)]);

    }
}

button_cover();

/*
intersection()
{
    button_cover();
    cube([20,20,20]);
}
*/