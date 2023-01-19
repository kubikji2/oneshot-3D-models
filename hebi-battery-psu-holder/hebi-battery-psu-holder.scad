
// PSU
ps_w = 72+1;
ps_l = 170;
ps_t = 40.5;

ps_led_g = 33;
// '-> led gauge
//ps_cab_w = 12.5+1;
ps_cab_w = ps_led_g;
// '-> cable width
ps_cab_d = 30;

// cable wall holder
wall_t = 10;

// wall thickness
wt = 2.4;

// table thickness
tt = 40;
to = 40;

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


_l = ps_l/2;
_t = ps_t + wt;
_w = ps_w + 2*wt;
_ht = wall_t + wt;
_ho = _l-tt-to;

module shape()
{
    points = [  [   0,  0, 0],
                [ -_l,  0, 0],
                [ -_l, _t, 0],
                [   0, _t, 0],            
                [  _ho+to-_ht-wt/2, _t, 0],
                [  _ho+to, _t+_ht, 0],
                [  _ho+to, _t, 0],
                [  _l, _t, 0] ];
    hull_line(d=wt,h=ps_w+2*wt,pts=points);
    
    // aux geometry
    %translate([_l,_t,0])
    {
        translate([-tt-to+wt/2, 0, 0])
            cube([tt,10,10]);
    }
}

module hook()
{
    
    points = [  [  _ho+wt, _t, 0],
                [  _ho+wt, _t+_ht, 0],
                [  _ho+wt-_l/2, _t+_ht-2, 0]
             ];
    hull_line(d=wt,h=ps_w+2*wt,pts=points);
}

module holder()
{
    difference()
    {
        union()
        {
            shape();
            hook();
            // walls
            translate([-ps_l/2,0,0])
                cube([ps_l/2,ps_t+wt,wt]);
            translate([-ps_l/2,0,ps_w+wt])
                cube([ps_l/2,ps_t+wt,wt]);
        }
        // cut for the LEDs
        translate([-ps_l/2+wt/2,-wt,wt+(ps_w/2)-ps_led_g/2])
            cube([ps_l/2,2*wt,ps_led_g]);
        // cable cut
        translate([-ps_l/2-wt,-wt/2,wt+(ps_w/2)-ps_cab_w/2])
            cube([2*wt, ps_cab_d+wt, ps_cab_w]);
        // stress reliever
        translate([-5*_l/6,_t, _w/6])
            translate([0,-wt,0])
                cube([ps_l/3, 2*wt, 2*_w/3]);

    }

    // adding manual support to the stress reliever
    _n = 7;
    translate([0,_t,0])
    for(i=[0:_n])
    {
        _step = ps_l/(2*_n);
        _off = -i*_step;
        translate([_off,0,0])
        cylinder(d=wt,h=ps_w+2*wt);
    }

    
    // adding manual support to the LED hole
    //_n = 7;
    for(i=[0:_n])
    {
        _step = ps_l/(2*_n);
        _off = -i*_step;
        translate([_off,0,0])
        cylinder(d=wt,h=ps_w+2*wt);
    }

    // adding manual support to the cable hole
    __n = 5;
    for(i=[0:__n])
    {
        _step = (ps_t+wt)/(__n);
        _off = i*_step;
        translate([-ps_l/2,_off,0])
        cylinder(d=wt,h=ps_w+2*wt);
    }
}

holder();