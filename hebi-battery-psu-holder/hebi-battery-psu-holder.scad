
// PSU
ps_w = 72;
ps_l = 170;
ps_t = 40.5;

ps_led_g = 33;
// '-> led gauge
ps_cab_w = 12.5;
// '-> cable width
ps_cab_d = 23;

// cable wall holder
wall_t = 10;

// wall thickness
wt = 3;

$fn = 60;


module hull_line(d,h,pts)
{
    for(i=[0:len(pts)-2])
    {
        hull()
        {
            translate(pts[i])
                cylinder(d=d,h=h);
            translate(pts[i+1])
                cylinder(d=d,h=h);
        }
    }
}

module shape()
{
    _l = ps_l/2;
    _t = ps_t + wt;
    _ht = wall_t + wt;
    points = [  [   0,  0, 0],
                [ -_l,  0, 0],
                [ -_l, _t, 0],
                [   0, _t, 0],
                [  _l, _t, 0],
                [  _l, _t+_ht, 0],
                [  _l/4, _t+_ht-2, 0] ];
    hull_line(d=wt,h=ps_w+2*wt,pts=points);
}

module holder()
{
    difference()
    {
        union()
        {
            shape();
            // walls
            translate([-ps_l/2,0,0])
                cube([ps_l/2,ps_t+wt,wt]);
            translate([-ps_l/2,0,ps_w+wt])
                cube([ps_l/2,ps_t+wt,wt]);
        }
        translate([-ps_l/2+wt/2,-wt,(ps_w/2)-ps_led_g/2])
            cube([ps_l/2,2*wt,ps_led_g]);
        translate([-ps_l/2-wt,-wt/2,(ps_w/2)-ps_cab_w/2])
            cube([2*wt, ps_cab_d+wt, ps_cab_w]);

    }
}

holder();