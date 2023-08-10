include<../solidpp/solidpp.scad>

// todo define bolt dimensions

module nut_and_bolt()
{

}
// interface
i_l = 7;

i_d = 7;

module arm_interface(angle, is_arm=false)
{
    rotate([0,0,angle])
    {
        difference()
        {
            union()
            {
                cubepp([i_l,i_l/2+a_wt/2,c_h],align="yz");
                cylinderpp(d=i_d,h=c_h);
            }

            // TODO remove screw
            nut_and_bolt();

            // TODO remove the mass depending whether
            // interface is on the arm or the centra piece
            if(is_arm)
            {

            }
            else
            {

            }
        }

    }
}

// arm parameters
a_l = 100;

a_wt = 3;

a_h = 10;

a2i = [(i_l)/2,-(i_l+a_wt)/2,0];

module arm()
{
    difference()
    {
        // basic shape
        hull()
        {
            cylinderpp(d=a_wt, h=a_h, align="xz");
            translate([a_l,0,0])
                cylinderpp(d=a_wt, h=a_h, align="Xz");    
        }

        // hole for the body border
        // TODO

    }

    translate(a2i)
        arm_interface(0, is_arm=true);
}

// body parameters
b_Do = 122;
// '-> outer diameter
b_Di = 116;
// '-> inner diameter
b_wt = 3;
// '-> body wall thickness
b_wh = 4.5;
// '-> body wall height
b_wb = 2;
// '-> body wall border

// centeral piece parmeters
c_R = 45;

c_wt = 3;

c_h = 10;


$fn = $preview ? 30 : 60;

module hullify(points)
{
    for (i=[0:len(points)-1])
    {
        hull()
        {
            translate(points[i])
                children(0);
            translate(points[(i+1)% len(points)])
                children(0); 
        }
    }
}

module central_triangle()
{

    angles = [0,120,240];
    points = [for(angle=angles) each [rotate_2D_z([c_R-c_wt/2, -i_l], angle), rotate_2D_z([c_R-c_wt/2, i_l], angle)]];
    echo(points);

    hullify(points)
        cylinder(d=c_wt, h=c_h);

    for(a=angles)
    {
        rotate([0,0,a])
            translate([c_R,0,0])
            {
                %arm();
                translate(a2i)
                    arm_interface(90, is_arm=false);
            }
    }

    %cylinder(r=c_R,h=c_h);

}

central_triangle();

