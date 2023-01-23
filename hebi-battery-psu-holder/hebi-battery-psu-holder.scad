// holder for the HEBI power source unit (AC/DC converter)
// consist of two parts (three pieces)
// '-> gripper (2x) - hangs on the table
// '-> socket (1x) - holds the PSU and gripper together

// PSU
ps_w = 72+1;
// '-> PSU width
ps_l = 170;
// '-> PSU length
ps_t = 40.5;
// '-> PSU thickness
ps_led_g = 33;
// '-> led gauge
//ps_cab_w = 12.5+1;
ps_cab_w = ps_led_g;
// '-> cable width
ps_cab_d = 30;

// wall thickness
wt = 2.4;

// tolerance
tol = 0.2;

// gripper
g_w = (ps_w - 2*wt - 4*tol - ps_led_g)/2;
// '-> gripper width

// socket
s_h = ps_l/2;
// '-> socket height

// cable-holder wall thickness
wall_t = 10;

// table thickness
tt = 40;
// '-> table thickness
to = 40;
// '-> distance between table and the hook

$fn = 60;

// replicates and pair-wise hullify the children at given points
module hullify(pts)
{
    for(i=[0:len(pts)-2])
    {
        hull()
        {
            translate(pts[i])
                children();
            translate(pts[i+1])
                children();
        }
    }
}

// socket piece
module socket()
{
    s_t = ps_t + wt;
    // '-> socket thickness
    s_w = ps_w + wt;
    // '-> socket width
    s_s = g_w + wt + 2*tol;
    // '-> socket strips
    points = [  [s_s, -wt, 0],
                [s_s, 0, 0],
                [0, 0, 0],
                [0, -wt, 0],
                [0, s_t+wt, 0],
                [0, s_t, 0],
                [s_s, s_t, 0],
                [s_s, s_t+wt, 0],
                [s_w-s_s, s_t+wt, 0],
                [s_w-s_s, s_t, 0],
                [s_w,s_t,0],
                [s_w,s_t+wt,0],
                [s_w,-wt,0],
                [s_w,0,0],
                [s_w-s_s,0,0],
                [s_w-s_s,-wt,0]
             ];
    
    translate([-wt/2,-wt/2,0])
    hullify(pts=points)
        cylinder(h=s_h,d=wt);
}

module unit()
{
    socket();

    // PSU
    %cube([ps_w,ps_t,ps_l]);
    
    // LED gauge
    translate([(ps_w-ps_led_g)/2,-wt,0])
        %cube([ps_led_g,ps_t,ps_l]);

    //color("red")
    rotate([0,-90,0])
    translate([-wt/2-tol,-wt-wt/2,-g_w-tol])
        gripper();
}

unit();


module __table_hook(l=ps_l/4, t=wall_t+wt, off=2)
{   
    points = [  [  0, 0, 0],
                [  0, t, 0],
                [  -l, t-off, 0]
             ];
    hullify(pts=points)
        children();
}

_l = ps_l/2;
_t = ps_t + wt;
_w = ps_w + 2*wt;
_ht = wall_t + wt;
_ho = _l-tt-to;

module gripper()
{
    s_l = s_h + wt + 2*tol;
    s_t = ps_t + 3*wt;
    s_t2 = s_t - wt;

    h_o = s_l + to - wt;
    h_l = wall_t;
    // '-> hook offset
    points = [  [s_l, wt, 0],  
                [s_l, 0, 0],
                [0,-tol,0],
                [0,s_t+tol,0],
                [s_l,s_t,0],
                [s_l,s_t2,0],
                [s_l,s_t2,0],
                [h_o-h_l,s_t2,0],
                [h_o,s_t2+h_l,0],
                [h_o,s_t2,0],
                [ps_l,s_t2,0]
            ];
    
    hullify(pts=points)
        cylinder(d=wt,h=g_w);

    // aux geometry (hole between table desk and the cable holding wall)
    //%translate([s_l-wt/2, s_t+wt/2, 0])
    //    cube([tt,10,10]);

    // adding table hook
    translate([s_l,s_t,0])
        __table_hook()
            cylinder(d=wt,h=g_w);      
}

/*
%cube([ps_l,ps_t,ps_w]);
translate([0,-wt,0])
%cube([s_h,ps_t+2*wt,ps_w]);

translate([-wt/2-tol,-wt-wt/2,0])
    gripper();
*/
