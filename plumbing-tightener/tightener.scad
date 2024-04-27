include<../solidpp/solidpp.scad>

h_off = 20;
//


// given parameters
h = 40;
// '-> height
r = 104/2;
// '-> radius, 145 mm max
p_w = 4.5;
// '-> pertrusion width
p_l = 5.5;
// '-> pertrusion lengths
p_n = 6;

//s_h = 3;
// '-> slope height
h_h = 10;
// '-> handle heights
h_d = 30;
// '-> handle diameter
h_l = 250;
// '-> handle length



wt = 5;
clrn = 0.5;
$fn = $preview ? 30 : 120;


module interface_shape()
{
    // main shape
    circle(r=r);
    // pertrusions
    for(i=[0:p_n-1])
    {
        z_rot = 360/p_n;
        rotate(i*z_rot)
            translate([r,0])
                squarepp([2*p_l, p_w],align="");
    }
}

module outer_shape_2d()
{
    offset(wt)
        hull()
            interface_shape();
}

module inner_hole_2d()
{
    offset(-clrn)
        offset(2*clrn)
            interface_shape();
}


module interface_xy_projection()
{

    difference()
    {
        outer_shape_2d();
        inner_hole_2d();
    }

}

module tightener()
{

    linear_extrude(h + h_off + h_h)
        interface_xy_projection();

    difference()
    {
        /*
        intersection()
        {
            // levarage
            hull()
                mirrorpp([1,0,0], true)
                    translate([h_l/2,0,0])
                        cylinderpp(h=h_h, d=h_d, align="Xz");
            hull()
                mirrorpp([1,0,0], true)
                    translate([h_l/2,0,h_h/2])
                        spherepp([h_d,h_d,2*h_h], align="X");

        }
        */
        render()
        difference()
        {
            hull()
                mirrorpp([1,0,0], true)
                    translate([h_l/2,0,h_h/2])
                        spherepp([h_d,h_d,2*h_h], align="X");

            cubepp([1000,1000,1000], align="Z");
        }

        translate([0,0,-clrn])
            linear_extrude(h_h+h_off+2*clrn)
                inner_hole_2d();

    }

}

tightener();



