$fn = 180;
fn_o = $fn;
eps = 0.01;
tol = 0.2;

// M3
m3_l=10;
m3_d=3;
m3_nd=6.0;
m3_nh=2.3;
m3_hd=5.5;
m3_hh=2;

// main shape parameters
wt = 3;
r_o = 140;
r_i = r_o-wt;
h=70+45-42;
wt_i = 3;
wt_o = 4;

// additional parameters
// border height
bh = 10;
// border thickness
bt = 3;

// support
// col angle width
ca = 5;
// foil thickness
ft = 1;
// foil height
fh = 2;


module bolt_hole()
{
    // head
    cylinder(h=m3_hh,d=m3_hd);
    
    // thread
    cylinder(h=m3_hh+m3_l,d=m3_d);
    
    // nut
    translate([0,0,m3_hh+m3_l-3])
        cylinder(d=m3_nd+tol,h=m3_l,$fn=6);
}

// cut in the shape of pie slice
module angle_cut(a_min, a_max,  h=20, d=1000)
{
    _h = h+2*eps;
    _a = d;
    
    rotate([0,0,180-a_min])
        translate([0,-d/2,-eps])
            cube([_a,_a,_h]);
    
    rotate([0,0,-a_max])
        translate([0,-d/2,-eps])
            cube([_a,_a,_h]);
}

// cylindrical ring-like shape
module cylinder_shell(r_i, r_o, h, fn_i=$fn, fn_o=$fn)
{
    difference()
    {
        cylinder(r=r_o,h=h,$fn=fn_o);
        translate([0,0,-eps])
            cylinder(r=r_i,h=h+2*eps, $fn=fn_i);
    }
}

module nut_holes()
{
    rotate([0,0,180+ca/2])
    {
        translate([0,-r_o-wt_o,1.5*bh])
            rotate([-90,0,0])
                bolt_hole();
        translate([0,-r_o-wt_o,h+bh/2])
            rotate([-90,0,0])
                bolt_hole();
    }
    
    rotate([0,0,180-ca/2])
    {
        translate([0,-r_o-wt_o,1.5*bh])
            rotate([-90,0,0])
                bolt_hole();
        translate([0,-r_o-wt_o,h+bh/2])
            rotate([-90,0,0])
                bolt_hole();
    }
}

module col(_ri, _ro, fn_i=$fn, fn_o=$fn)
{
    difference()
    {
        // main shape
        rotate([0,0,ca])
            cylinder_shell(r_i=_ro-wt_o, r_o=_ro, h=h+2*bh, fn_i=fn_i, fn_o=fn_o);
        
        // cut
        angle_cut(-ca, ca, h=h+2*bh, d=1000);
        
        // holes for the nuts and bolts
        nut_holes();
        
    }
}


module col_o()
{
    _ri = r_o;
    _ro = r_o+wt_o;
    _fn = 360/(2*ca);

    col(_ri, _ro, fn_o=_fn);

}

col_o();

module col_i()
{
    
    _ri = r_i-wt_i;
    _ro = r_i-tol;
    _fn = 360/(2*ca);
    
    col(_ri, _ro, _fn);
    
    // middle part
    translate([0,0,bh+tol])
        difference()
        {
            rotate([0,0,ca])
                cylinder_shell(r_i=_ro-wt_o, r_o=r_o-2*tol, h=h-2*tol);

        
            // cutting only certain area
            angle_cut(-ca, ca, h=h, d=1000);
            
            // holes for the nuts and bolts
            translate([0,0,-bh-tol])
                nut_holes();
        
        /*
        // cutting hole for the plastic foil
        translate([0,0,-eps])
            difference()
            {
                cylinder_shell( r_i=r_i+wt/2-ft/2,
                                r_o=r_o-wt/2+ft/2,
                                h=h+2*bh+2*eps);
                _a = 1000;
                rotate([0,0,180-ca+1])
                    translate([0,-_a/2,-eps])
                        cube([_a,_a,h+2*bh+2*eps]);                
            }
            
            translate([0,0,-eps])
            difference()
            {
                cylinder_shell( r_i=r_i+wt/2-ft/2,
                                r_o=r_o-wt/2+ft/2,
                                h=h+2*bh+2*eps);
                _a = 1000;
                rotate([0,0,ca-1])
                    translate([0,-_a/2,-eps])
                        cube([_a,_a,h+2*bh+2*eps]);                
            }
        */

        }
}

col_i();


module arch()
{
    difference()
    {
        // main shape
        cylinder_shell(r_i=r_i-wt_i, r_o=r_o+wt_o, h=2*bh);
        
        // lower shell cut
        translate([0,0,-eps])
            cylinder_shell(r_i=r_i, r_o=r_o, h=bh+eps);
        
        // upper shell cut
        translate([0,0,2*bh-fh])
        {
            difference()
            {
                cylinder_shell(r_i=r_i+wt/2-ft/2, r_o=r_o-wt/2+ft/2, h=fh+eps);
                angle_cut(ca-1, 91-ca,  h=2*bh+2*eps, d=1000);               
            }
            
        }
        
        // cutting only one quadrant
        angle_cut(1, 89,  h=20, d=1000);
        
        // screw holes
        nut_holes();
        rotate([0,0,-90]) nut_holes();
        
        
        // inner cut
        render(2)
        translate([0,0,-eps])
        difference()
        {
            cylinder_shell(r_i=r_i-wt_i-eps, r_o=r_i+tol, h=2*bh+2*eps);
            angle_cut(-ca, ca+0.1,  h=2*bh+2*eps, d=1000);
        }
        
        // outer cut
        render(2)
        translate([0,0,-eps])
        difference()
        {
            cylinder_shell(r_i=r_o-tol, r_o=r_o+wt_o+eps, h=2*bh+2*eps);
            angle_cut(-ca, ca+0.1,  h=2*bh+2*eps, d=1000);
        }
        
        // inner cut
        render(2)
        translate([0,0,-eps])
        difference()
        {
            cylinder_shell(r_i=r_i-wt_i-eps, r_o=r_i+tol, h=2*bh+2*eps);
            angle_cut(90-ca-0.1, 90+ca,  h=2*bh+2*eps, d=1000);
        }
        
        render(2)
        translate([0,0,-eps])
        difference()
        {
            cylinder_shell(r_i=r_o-tol, r_o=r_o+wt_o+eps, h=2*bh+2*eps);
            angle_cut(90-ca-0.1, 90+ca,  h=2*bh+2*eps, d=1000);
        }
        

        n_cuts = 18;
        for(i=[0:n_cuts])
        {
            translate([0,0,2*bh])
                rotate([-90,0,-81+4*i])
                    cylinder(d=4,h=2*r_o,$fn=6);
        }
        
        for(i=[0:n_cuts+1])
        {
            translate([0,0,2*bh-3])
                rotate([-90,0,-85+4*i+2])
                    cylinder(d=4,h=r_i,$fn=6);
        }
        
        for(i=[0:n_cuts+1])
        {
            translate([0,0,2*bh-3])
                rotate([0,0,-85+4*i+2])
                    translate([0,r_o,0])
                        rotate([-90,0,0])
                            cylinder(d=4,h=r_i,$fn=6);
        }
        
        for(i=[0:n_cuts])
        {
            translate([0,0,3])
                rotate([0,0,-81+4*i])
                    translate([0,r_o+1,0])
                        rotate([-90,0,0])
                            cylinder(d=4,h=r_i,$fn=6);
        }
        
        for(i=[0:n_cuts])
        {
            translate([0,0,3])
                rotate([0,0,-81+4*i])
                    rotate([-90,0,0])
                        cylinder(d=4,h=r_i-1,$fn=6);
        }
    }
}

//arch();
