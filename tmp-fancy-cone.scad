
$fn=40;

module fancy_cone(R=10, H=20, d=2, n_rots=3, n_steps=100)
{

    cylinder(r1=R, r2=0, h=H);

    // computationally heavy
    /*
    minkowski()
    {
        linear_extrude(H, scale=0.01, twist=360*n_rots)
            translate([R, 0])
                square([0.01, 0.01]);
        sphere(d=d);
    }
    */

    // increment in rotation
    _d_rot = (n_rots*360)/n_steps;
    // increment in height
    _d_H = (H-d/2)/n_steps;
    // increment in radius
    _d_R = R/n_steps;
    
    for(i=[0:n_steps-1])
    {
        hull()
        {
            rotate([0,0,i*_d_rot])
                translate([R-(i*_d_R),0, i*_d_H])
                    sphere(d=d);
            
            rotate([0,0,(i+1)*_d_rot])
                translate([R-((i+1)*_d_R),0, (i+1)*_d_H])
                    sphere(d=d);
        }
    }
}

//fancy_cone();



module donut(D=10, d=2)
{
    rotate_extrude()
        translate([D/2, 0, 0])
            circle(d=d);
}

module fancy_cone_donut(R=10, H=20, d=2, n_donuts=4)
{
    cylinder(r1=R, r2=0, h=H);

    // increment in height
    _d_h = (H-d/2)/(n_donuts);
    // increment in radius
    _d_R = R/n_donuts;

    for(i=[0:n_donuts])
    {
        _h = (i)*_d_h;
        _R = (n_donuts-i)*_d_R;

        translate([0,0,_h])
            donut(D=2*_R, d=d);
    }
}

fancy_cone_donut();


module fancy_cone_nana()
{
    r_b = 30; //radius of the base
    r_p = 1; //radius of added part
    cons = 0.03; //added part augmentation constant

    linear_extrude(height = 50, center = true, convexity = 10, twist = 1800, slices = 200, scale = 0.001, $fn = 250)
    {

        circle(r=r_b);
        
        for(phi = [-45 : 1 : 45])
        {
            rotate([0,0,phi])
                translate([r_b,0,0])
                    circle(r=r_p+0.03*(45-abs(phi)));
        }
        
    }

}

//fancy_cone_nana();


module rotation_1(angle=90, step=10, l=10, a=1)
{
    for(phi=[0:step:angle])
    {
        rotate([0,0,phi])
            translate([l,0,0])
                cube(a);
    }
}

//rotation_1();


module rotation_2(angle=90, step=10, l=10, a=1)
{
    for(phi=[0:step:angle])
    {
        translate([l*cos(phi), l*sin(phi), 0])
            cube(a);
    }
}

//rotation_2();