include<../solidpp/solidpp.scad>

// LEGO figure parameters
lego_a = 8.4;
// '-> leg hole side
lego_h = 3.9;
// '-> lego hole height
lego_o = 5.4;
// '-> offset between leg figures
lego_wt = 2.5;
// '-> lego leg wall thickness
$fn=60;

module interface()
{

    mirrorpp([1,0,0], true)
    {
        translate([lego_o/2,0,0])
            cylinderpp(d=lego_a, h=lego_h, align="xz");
    }

}



module test()
{
    _x = lego_wt + lego_a + lego_o + lego_a + lego_wt;
    _y = lego_wt + lego_a + lego_wt;
    _z = 2;
    translate([0,0,_z])
        interface();
    cubepp([_x,_y,_z], align="z");
    
}

test();

