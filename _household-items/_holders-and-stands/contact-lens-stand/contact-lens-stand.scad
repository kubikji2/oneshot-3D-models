eps = 0.01;
$fn = 90;
tol = 0.2;

// basic pareters
wt = 2;

// contact len shelf dimensions
cls_x = 34;
cls_y = 34;
cls_z = 11;

// contact len solution bottle dimensions
sb_d = 65;
sb_h = cls_x;


// contact len shelf
/*
module cl_shelf()
{
    _a = cls_x+2*wt;
    _b = cls_y+wt;
    _c = cls_z+2*wt;
    translate([-_a/2,0,0])
        difference()
        {
            cube([_a,_b,_c]);
            translate([wt,wt,wt])
                cube([cls_x,cls_y+eps,cls_z]);
        }
}
*/

/*
module cl_holder()
{
    
    n_cl = 5;
    // shelfs
    difference()
    {
        union()
        {
            translate([0,sb_d/2+((cls_z+wt)*2/sqrt(2))/2,0])
            {
                for(i=[0:n_cl])
                {
                    z_off = i*(cls_z+wt)*2/sqrt(2);
                    translate([0,0,z_off])
                        rotate([45,0,0])
                            cl_shelf();
                }
                
                // side supports
                translate([-cls_x/2-wt,-cls_z,0])
                    cube([wt,cls_z,
                          ((n_cl+0.5)*(cls_z+wt)+0.5*wt)*2/sqrt(2)]);
                translate([cls_x/2,-cls_z,0])
                    cube([wt,cls_z,
                          ((n_cl+0.5)*(cls_z+wt)+0.5*wt)*2/sqrt(2)]);
            }
            // lower part
            _R = sqrt(45*45+(45/2)*(45/2))+wt;
            _r = sqrt((sb_d/2)*(sb_d/2) + (sb_d/4)*(sb_d/4))+wt;
            cylinder(r=_R,h=wt,$fn=6);
            translate([0,0,wt])
                cylinder(r1=_R,r2=_r,h=sb_h,$fn=6);
        }
        translate([0,0,wt])
            cylinder(d=sb_d,h=sb_h+eps);
    }
    %cylinder(d=90);
    

        
}
*/

module cl_stand()
{
    
    n_cl = 5;
    // shelfs
    difference()
    {
        _a = cls_x+2*wt;
        _b = cls_y+wt;
        _c = cls_z+2*wt;
        //translate([-_a/2,0,0])
        //    difference()
        //    {
        //        cube([_a,_b,_c]);

        //    }
        union()
        {
        
            for(i=[0:n_cl])
            {
                z_off = 0;
                y_off = sb_d/2+cls_z+2*wt;
                rotate([0,0,i*60])
                    translate([-_a/2,y_off,z_off])
                        rotate([90,0,0])
                            //cl_shelf();
                            cube([_a,_b,_c]);
            }
            
            // lower part
            _R = sqrt(45*45+(45/2)*(45/2))+wt;
            _r = sqrt((sb_d/2)*(sb_d/2) + (sb_d/4)*(sb_d/4))+wt;
            cylinder(r=_R,h=wt,$fn=6);
                translate([0,0,wt])
            cylinder(r1=_R,r2=_r,h=sb_h,$fn=6);    
        }
        
        for(i=[0:n_cl])
        {   
            z_off = 0;
            y_off = sb_d/2+cls_z+2*wt;
            rotate([0,0,i*60])
                    translate([-_a/2,y_off,z_off])
                        rotate([90,0,0])
                            translate([wt,wt,wt])
                                cube([cls_x,cls_y+eps,cls_z]);
        }
            
        translate([0,0,wt])
            cylinder(d=sb_d,h=100);
    }
    //%cylinder(d=90);
}

cl_holder();
    