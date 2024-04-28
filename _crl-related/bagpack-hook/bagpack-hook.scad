eps = 0.01;
$fn = 90;
tol = 0.4;

// M3 bolt parameters
// bold diameter
m3_bd = 3;
// bold height
m3_bh = 18;
// nut diameter
m3_nd = 6.5;
// nut height
m3_nh = 2.5;
// bolt head diameter
m3_bhd = 5.5;
// bolt head height
m3_bht = 2;

wt = 3;
hole_d = 73;
hole_h = 18;

b_l = 20;

module hole_fill()
{
    difference()
    {
        union()
        {
            cylinder(d=hole_d, h=hole_h);
            translate([0,0,hole_h])
                cylinder(d=hole_d+2*wt, h=wt);
        }
        // drilling hole
        difference()
        {
            union()
            {
                translate([0,0,-eps])
                    cylinder(d=hole_d-2*wt,
                        h=hole_h + wt + 2*eps);
                translate([hole_d/2-2*wt,-wt,-eps])
                    cube([4*wt,2*wt,hole_h+wt+2*eps]);
            }
            translate([ -hole_d+3*wt+m3_bd,
                        -hole_d/2,
                        wt])
                cube([hole_d/2,hole_d,hole_h]);
        }
        
        _a = m3_bd + 2*wt;
        _b = b_l + m3_bd + 2*wt;
        _c = hole_h-wt;
        
        // drilling holes
        translate([-hole_d/2+wt+m3_bd,0,0])
        {
            translate([0,-b_l/2,-eps])
                bolt_hole();
            translate([0,b_l/2,-eps])
                bolt_hole();
            // secure hole
            cylinder(d=m3_bd,h=hole_h+wt+eps);
            translate([0,0,hole_h-m3_bht-wt])
                cylinder(d=m3_bhd+0.2,
                         h=m3_bht+2*wt+eps);
        }        
    }    
}

module bolt_hole()
{
    rotate([0,0,90])
    {
        cylinder(d=m3_bd,h=wt+hole_h+2*eps);
        cylinder(d=m3_nd,h=wt+hole_h/2, $fn=6);
    }
}

%hole_fill();

module hole_safety()
{
    difference()
    {
        union()
        {
            // inner
            cylinder(d=hole_d-2*wt-2*tol, h=wt);
            // outer
            translate([0,0,-wt])
                cylinder(d=hole_d+2*wt, h=wt);
        }
        
        difference()
        {
            translate([0,0,-wt-eps])
                cylinder(h=2*wt+2*eps, d=hole_d-4*wt);
            
            translate([ -hole_d+3*wt+m3_bd,
                        -hole_d/2,
                        -wt])
                cube([hole_d/2,hole_d,hole_h]);
        }
        translate([-hole_d/2+wt+m3_bd,0,-wt-eps])
        {
            // hole for bolt
            rotate([0,0,90])
            cylinder(d=m3_nd,h=m3_nh+eps,$fn=6);
            // hole for nut
            cylinder(d=m3_bd,h=2*wt+2*eps);
        }
        
        translate([hole_d/2-3*wt,-wt,-wt-eps])
            cube([6*wt,2*wt,hole_h+wt+2*eps]);
    }
    
}

%hole_safety();

module hook_shape(a=20, h=b_l+2*m3_bd+2*wt, d=5)
{
    //s_a = sqrt((a*a)/2);
    s_a = a/2;
    points = [  [0,0,0],
                [-a,0,0],
                [-a-s_a,s_a,0],
                [-a-s_a,s_a+a,0],
                [-a,a+2*s_a,0]
             ];
    for(i=[0:len(points)-2])
    {
        hull()
        {
            translate(points[i])
                cylinder(d=5,h=h);
            translate(points[i+1])
                cylinder(d=5,h=h);

        }
    }
}


module hook()
{
    _h = b_l+2*m3_bd+2*wt;
    _a = 20;
    _d = 5;
    translate([ -hole_d/2+wt+m3_bd,
                0,
                wt+hole_h+_d/2])
    difference()
    {
        translate([_d/2,(b_l+2*m3_bd+2*wt)/2,0])
            rotate([90,0,0])
                hook_shape(a=_a,h=_h,d=_d);
        
        // left bolt
        //  - bolt hole
        translate([0,-b_l/2,-eps-_d/2])
            cylinder(d=m3_bd,h=_d+2*eps);
        // - bolt head hole
        translate([0,-b_l/2,_d/2-m3_bht])
            cylinder(d=m3_bhd,h=m3_bht);
        // right bolt
        //  - bolt hole
        translate([0,b_l/2,-eps-_d/2])
            cylinder(d=m3_bd,h=_d+2*eps);
        // - bolt head hole
        translate([0,b_l/2,_d/2-m3_bht])
            cylinder(d=m3_bhd,h=m3_bht);
        // hole for secure bolt
        translate([0,0,-eps-_d/2])
            cylinder(d=m3_bhd+0.2,
                     h=_d+2*eps);
    }
}
hook();