include<../qpp_all.scad>
// nuc power unit dimensions
h = 75.5;
t = 26;
l = 150;

// cable height
ch = 20;

// wall parameters
wt = 3;

r = wt/2;
// cable holder parameters
sheet_t = 10;
hook_l = h/2;

$fn=qpp_fn;

module hook()
{
    _hx = hook_l;
    _hy = -sheet_t - 2*r;
    points = [  [  0,  0,0],
                [_hx,  0,0],
                [_hx,_hy,0],
                [  0,_hy,0]];
    for(i=[0:len(points)-2])
    {
        hull()
        {
            translate(points[i])
                cylinder(r=r,h=l + 2*wt);
            translate(points[i+1])
                cylinder(r=r,h=l + 2*wt);
        }
    }
}

module nuc_pu_holder()
{
    _x = l + 2*wt;
    _y = t + 2*wt;
    _z = h-hook_l + 2*wt;

    difference()
    {
        translate([_x,0,0])
            rotate([0,-90,0])
                qpp_cylindrocube([_z,_y,_x,r]);
        translate([wt,wt,wt])
            cube([l,t,h+qpp_eps]);
        translate([-qpp_eps,wt, wt+ch])
            cube([_x+2*qpp_eps,_y-2*wt,_z]);
    }
}

nuc_pu_holder();
translate([l + 2*wt,wt/2,h+wt+wt/2-hook_l])
    rotate([0,-90,0])
        qpp_coordinate_frame()
        hook();


