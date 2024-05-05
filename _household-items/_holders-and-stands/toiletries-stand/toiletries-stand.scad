eps = 0.01;
$fn = 90;

// parameters
// base diameters
b_d = 95;
// base thickness
b_t = 2;
// base rising
b_r = 5;

// general parameters
// wall thickness
wt = 3;

// accessories dimensions
// rasor blade storage dimensions
rb_x = 47.5;
rb_y = 11.5;
rb_z = 72;
rb_h = 25;

// razor dimension
r_x = 9;
//r_y = 9;
//r_y = 11;
r_y = 10;
r_o = 5;
r_z = 110;
r_d = 5;
r_do = 3;
r_t = 5+r_do;

// toothbrush dimensions
tb_X = 12;
tb_x = 7;
tb_Y = 15;
tb_y = 9;
tb_z = 110;

// contact lens case paremeters
clc_t = 12;
clc_h = 35;

// interdental brush paramters
ib_t = 6;
ib_w = 7;
ib_o = 4;

// possible extention into separete module
module base()
{
    hull()
    {
        cylinder(d=b_d, h=b_t, $fn=8);
        translate([0,0,b_t])
            cylinder(d=rb_x+2*wt, h=b_r, $fn=8);
    }
    
}

module stand()
{
    difference()
    {
        union()
        {
            // base
            rotate([0,0,22.5]) base();
            
            // toothbrush block
            translate([tb_X/2+wt-tb_X-2*wt,tb_Y/2+wt,b_t])
            {
                hull()
                {
                    // vertical
                    translate([-tb_x/2, -tb_Y/2-wt, 0])
                        cube([tb_x, tb_Y+2*wt, tb_z]);
                    // horizontal
                    translate([-tb_X/2-wt, -tb_y/2, 0])
                        cube([tb_X+2*wt, tb_y, tb_z]);
                }
                
                // razor hook
                hull()
                {
                    // razor hook
                    translate([tb_X/2+2*wt,-r_y/2-wt,r_z-r_t])
                        cube([r_o+r_x,r_y+2*wt,r_t]);
                    
                    // razor hook support
                    translate([0,
                                -r_y/2-wt,
                                r_z-r_o-r_x-r_t-tb_X/2-2*wt])
                        cube([  wt,
                                r_y+2*wt,
                                r_o+r_x+r_t+tb_X/2+2*wt]);
                }
                
                // interdental hook
                translate([-tb_X/2-wt,-ib_w/2,tb_z-(2*wt+ib_t+ib_o)-15])
                hull()
                {
                    cube([wt,ib_w,2*wt+ib_t+ib_o]);
                    translate([-ib_t-ib_o-wt,0,wt+ib_t+ib_o])
                        cube([2*wt+ib_t+ib_o,ib_w,wt]);
                }
                
                
            }
            
            // razor blades stock stand
            translate([-rb_x/2-wt,-rb_y-wt,b_t])
                cube([rb_x+2*wt,rb_y+2*wt,rb_h]);
        }
        
        // toothbrush hole
        translate([tb_X/2+wt-tb_X-2*wt,tb_Y/2+wt,b_t-eps])
        {
            hull()
            {
                // vertical
                translate([-tb_x/2, -tb_Y/2, 0])
                    cube([tb_x, tb_Y, tb_z+2*eps]);
                // horizontal
                translate([-tb_X/2, -tb_y/2, 0])
                    cube([tb_X, tb_y, tb_z+2*eps]);
            }
        
            // blade hole
            translate([tb_X/2+wt+r_o,-r_y/2,b_r+2*eps])
            {
                cube([r_x+wt+eps,r_y,r_z+eps]);
                
                // deeping
                translate([r_o,-wt-eps,r_z-b_r-r_do+r_d])
                    rotate([-90,0,0])
                        cylinder(h=r_y+2*wt+2*eps,d=r_x);
            
            }
            
            // water hole
            _wh_d = (tb_X-wt)/sqrt(2); 
            translate([-tb_X/2-wt-eps,0,b_r])
            {
                _a = _wh_d;
                // lower side cut
                rotate([45,0,0])
                    cube([tb_X+2*wt+2*eps,_a,_a]);
                _l = tb_z-(r_o+r_x+r_t+tb_X/2+2*wt)-b_r-(tb_X-wt)/2-2;
                // upper side cut
                translate([0,0,_l])
                    rotate([45,0,0])
                        cube([tb_X+2*wt+2*eps,_a,_a]);
                // middle section
                translate([0,-(tb_X-wt)/2,(tb_X-wt)/2])
                    cube([tb_X+2*wt+2*eps,tb_X-wt,_l]);
                
                //rotate([0,90,0])
                //    rotate([0,0,0])
                //        cylinder(h=tb_X+2*wt+2*eps,d=_wh_d);
            }
            // vertical hole
            translate([0,0,-b_t-wt])
                cylinder(d=wt,h=b_r+2*eps);
            
            // interdental brush hooks
            translate([-tb_X/2-wt-ib_o-ib_t/2,ib_w/2+eps,tb_z-15])
                rotate([90,0,0])
                    cylinder(d=ib_t,h=ib_w+2*eps);
        }
        
        // razor blade storage hole
        translate([-rb_x/2,-rb_y,b_t+eps])
            cube([rb_x,rb_y,rb_h+eps]);
    }
    
    // contact lens case stand
    translate([0-tb_X-wt,tb_Y+2*wt+clc_t,0])
    hull()
    {
        cube([tb_X,3*wt,eps]);
        cube([tb_X,wt,clc_h]);
    }
    
}

stand();