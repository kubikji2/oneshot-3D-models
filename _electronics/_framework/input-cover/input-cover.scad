include<../../../deez-nuts/deez-nuts.scad>
include<../../../solidpp/solidpp.scad>

// fastener
bolt_d = 2;
// '-> bolt diameter
bolt_clearance = -0.05;

// body parameter
body_x = 298;
// '-> x body size, measured
body_y = 229;
// '-> y body size, measured
body_z = 1;
// '-> z body size, measured
body_r = 7;
// '-> body rounding radius
body_ears_x = 18;
body_ears_y = 13;
body_cut_x = body_x-2*body_ears_x;
// '-> body cut x length
body_cut_y = body_ears_y;
// '-> body cut y length

// positioning
front_x_off = 17;
// '-> front x offset
front_y_off = 17;
// '-> front y offset

back_x_off = 9.5;
// '-> back x offset
back_y_off = 6.5;
// '-> back y offset

// studs
front_d1 = 6.4;
// front stud base diameter
front_d2 = 5.2;
// front stud top diameter
front_h = 6.6;
// '-> height including the base z

back_d = 5.2;
// '-> back stud diameter
back_phi = -15;
// '-> back rotation angle around x axis
back_h = 4.7/cos(back_phi);

middle_d = 5.2;
// '-> middle stud diameter
middle_h = 6;
// '-> middle stud height
middle_y_off = 6;
// '-> middle stud y offset

eps = 0.01;

$fn = $preview ? 30 : 120;

module bolt_hole(h=10)
{
    _d = bolt_d+2*bolt_clearance;

    translate([0,0,_d/2])
        cylinderpp(d=_d,h=h);
    spherepp(d=_d, align="z");
}

// front stud
module front_stud()
{
    difference()
    {
        cylinderpp(d1=front_d1, d2=front_d2, h=front_h, align="z");
        translate([0,0,body_z])
            bolt_hole();
    }
}

// back stud
module back_stud()
{
    intersection()
    {
        rotate([back_phi,0,0])
            difference()
            {
                cylinderpp(d=back_d, h=2*back_h, align="");
                translate([0,0,body_z])
                    bolt_hole();
            }
        cubepp([20,20,20], align="z");
    }
}


// middle stud
module middle_stud()
{
    difference()
    {
        cylinderpp(d=middle_d, h=middle_h, align="z");
        translate([0,0,body_z])
            bolt_hole();
    }
}

// base body
module base_body()
{
    difference()
    {
        cubepp([body_x, body_y, body_z], mod_list=[round_edges(r=body_r)]);
        translate([body_ears_x, body_y-body_cut_y+eps,-eps])
            cubepp([body_cut_x, body_cut_y, body_z+2*eps], align="xyz");
    }

}

module input_cover()
{
    base_body();
    
    // front studs
    replicate_at([[front_x_off, front_y_off,0], [body_x-front_x_off, front_y_off,0]])
        front_stud();

    // backs studs
    replicate_at([[back_x_off, body_y-back_y_off, 0], [body_x-back_x_off, body_y-back_y_off, 0]])
        back_stud();

    /*
    // middle stud
    translate([body_x/2, body_y-body_cut_y-middle_y_off, 0])
        middle_stud();
    */

}


module parrot()
{
    mirror([1,0,0])
        scale([0.5,0.5,0.4/10])
            import("graphics/framework-parrot.stl");
}

module input_cover_with_parrot(visual=true, is_left=false, is_parrot=false)
{
    color("silver")
    intersection()
    {
        difference()
        {
            if (!is_parrot)
            {
                input_cover();
            }

            union()
            {
                translate([body_x/4, body_y/2, -0.01])
                {
                    parrot();
                }

                translate([3*body_x/4, body_y/2, -0.01])
                    mirror([1,0,0])
                    {
                        color("silver")
                            parrot();
                    }
            }
        }

        if (is_left)
        {
            translate([0,0,0])
                cubepp([body_x/2-0.25,body_y,20], align="xyz");
        }
        else
        {
            translate([body_x/2+0.25,0,0])
                cubepp([body_x/2,body_y,20], align="xyz");
        }
    }

    if (visual)
    {   
        %color("orange")
        intersection()
        {
            translate([body_x/4, body_y/2, -0.01])
                    parrot();
        
            if (is_left)
            {
                translate([0,0,0])
                    cubepp([body_x/2-0.25,body_y,20], align="xy");
            }
            else
            {
                translate([body_x/2+0.25,0,0])
                    cubepp([body_x/2,body_y,20], align="xy");
            }
        }

        %color("green")
        intersection()
        {
            
            translate([3*body_x/4, body_y/2, -0.01])
                mirror([1,0,0])
                    parrot();

            if (is_left)
            {
                translate([0,0,0])
                    cubepp([body_x/2-0.25,body_y,20], align="xy");
            }
            else
            {
                translate([body_x/2+0.25,0,0])
                    cubepp([body_x/2,body_y,20], align="xy");
            }
        }
    }

}

is_left = true;
is_parrot = false;

input_cover_with_parrot(is_left=is_left, is_parrot=is_parrot);

module test()
{
    // front selection
    /*
    intersection()
    {
        input_cover();
        cube([25,25,20]);
    }
    */

    /*
    // back selection
    intersection()
    {
        input_cover();
        translate([0,body_y,0])
            cubepp([25,25,20], align="xYz");
    }
    */

    /*
    // side
    intersection()
    {
        input_cover();
        translate([body_x,0,0])
            cubepp([20,body_y,20], align="Xyz");
    }
    */

    // front left
    intersection()
    {
        input_cover();
        translate([0,0,0])
            cubepp([body_x/2-0.25,20,20], align="xyz");
    }

    // front right
    intersection()
    {
        input_cover();
        translate([body_x/2+0.25,0,0])
            cubepp([body_x/2,20,20], align="xyz");
    }

}

//test();

