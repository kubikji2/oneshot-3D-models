include<../solidpp/solidpp.scad>

// todo define bolt dimensions

module nut_and_bolt()
{

}

module arm()
{

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

    points = [for(angle=[0,120,240]) each [rotate_2D_z([c_R-c_wt/2, -10], angle), rotate_2D_z([c_R-c_wt/2, 10], angle)]];
    echo(points);

    hullify(points)
        cylinder(d=c_wt, h=c_h);

    %cylinder(r=c_R,h=c_h);

}

central_triangle();