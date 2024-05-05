eps = 0.01;
$fn = 90;

// screw diameter
s_d = 3.5;
// screw head diameter
s_h = 7;
// screw head conic part height
s_c = 2.5;


// deodorand diameter
d_d = 55;
// deodorands offsets
d_off = 5;
// additional tolerance for deodorants
d_tol = 10;

// antiperspirant width value
ap_x = 27;

// deodorand counts
d_n = 3;

x = (d_n+1)*d_off + d_n*d_d;
z = 120+d_off/2;

diff = 0;

sh_off = 35;

module quadrant_cut(r=20,h=5)
{
    translate([0,h,0])
    rotate([90,0,0])
    difference()
    {
        cube([r,r,h]);
        translate([0,0,-eps]) cylinder(r=r,h=h+2*eps);
    }
    
}

module body()
{
    difference()
    {
        // body
        union()
        {
            d = d_d+2*d_off;
            for(i=[0:d_n-1])
            {
                translate([d_off+i*(d_d+d_off)+d_d/2,d/2,0])
                    cylinder(h=z-diff,d=d);
            }
            
            // upper part
            y_u = d/2+d_tol;
            translate([0,d/2,0]) cube([x,y_u,z]);
        }
        
        // drill holes for deodorands
        for(i=[0:d_n-1])
        {
            // cylinder
            translate([d_off+d_d/2+i*(d_d+d_off),d_d/2+d_off,d_off/2])
                cylinder(d=d_d,h=z);
            // cube
            translate([d_off+i*(d_d+d_off),d_d/2+d_off,d_off/2])
                cube([d_d,d_d/2+d_tol,z]);
            // hole for antiperspirant
            h_off = (d_d-ap_x)/2;
            translate([d_off+h_off+i*(d_d+d_off),0,d_tol+ap_x/2])
                //cube([ap_x,d_d/2,z]);
            hull()
            {   
                translate([ap_x/2,0,0])
                {
                    rotate([-90,0,0])
                        cylinder(h=d_d/2,d=ap_x);
                    translate([0,0,z]) rotate([-90,0,0])
                        cylinder(h=d_d/2,d=ap_x);
                }
            }
            
            // better corners
            cor_r = d_off+d_d/2-ap_x/2;
            translate([i*(d_d+d_off),0,z-cor_r-diff])
                quadrant_cut(r=cor_r+eps,h=d_d+d_off+d_tol);
            translate([i*(d_d+d_off),0,z-cor_r-diff+eps])
                translate([d_off+h_off+ap_x+cor_r,d_d+d_off+d_tol,0])
                    rotate([0,0,180])
                        quadrant_cut(r=cor_r+eps,h=d_d+d_off+d_tol);
            
            // drilling holes for screws
            translate([d_off+d_d/2+i*(d_d+d_off),d_d+d_tol+d_off,0])
            {
                translate([0,0,sh_off])
                rotate([-90,0,0]) translate([0,0,-eps])   
                {
                    cylinder(d=s_d,h=d_tol);
                    cylinder(d2=s_d,d1=s_h,h=s_c);
                }
                translate([0,0,z-sh_off])
                rotate([-90,0,0]) translate([0,0,-eps])   
                {
                    cylinder(d=s_d,h=d_tol);
                    cylinder(d2=s_d,d1=s_h,h=s_c);
                }
                
            }
        }
        
    }
    
}
body();