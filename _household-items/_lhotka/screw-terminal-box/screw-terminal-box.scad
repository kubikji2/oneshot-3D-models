eps = 0.01;
tol = 0.2;
$fn = 90;

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

// offset from the bold diameter
io_bt = 2;
// io side thickness 
io_t = 2*io_bt + m3_nd;
// io hole offset form bottom of the box
io_off = 3;
// in cable diameter
in_d = 7;
// out cable diameters
out_a = 6;
out_b = 3.5;

// cable space
cs = 10;

// Chocolate parameters
c_x = 25;
c_y = 17;
c_z = 15;

//chocolate holders parameters
ch_h = 9;
ch_d = 2;
ch_dist = 8;

// Box parameteres
b_x = 30;
b_y = c_y + 2*(cs+io_t);
b_z = 18;

module box()
{
    difference()
    {
        
        // cut for the chocolate and cable space
        cd_x = (b_x-c_x)/2;
        cd_y = (b_y-c_y)/2-cs;
        cd_z = (b_z-c_z);
        
        // in cut
        io_x = b_x+2*eps;
        io_y = 2*io_bt+m3_nd+tol+eps;
        io_z = c_z;
        io_xo = -eps;
        in_yo = -eps;
        in_zo = b_z-c_z+eps+io_off+in_d/2-tol;
        
        // out cut
        out_yo = 2*io_bt+m3_nd-tol+c_y+2*cs+eps;
        out_zo = b_z-c_z+eps+io_off+out_b/2-tol;

        // basic shape
        union()
        {
            // basic box
            difference()
            {
                cube([b_x,b_y,b_z]);

                translate([cd_x,cd_y,cd_z+eps])
                    difference()
                    {
                        cube([c_x,c_y+2*cs,c_z]);
                        // bolt support front left
                        translate([m3_bhd/2,m3_bhd/2,0])
                            cylinder(h=2*io_bt,d=2*io_bt+m3_bhd);
                        // bolt support back right
                        translate([c_x-m3_bhd/2,c_y+2*cs-m3_bhd/2,0])
                            cylinder(h=2*io_bt,d=2*io_bt+m3_bhd);
                    }
                ///////////////////
                // io basic cuts //
                ///////////////////
                translate([io_xo,in_yo,in_zo]) cube([io_x,io_y,io_z]);
                translate([io_xo,out_yo,out_zo]) cube([io_x,io_y,io_z]);
                
            }
            
            // io front upper part
            iou_x = b_x;
            iou_y = 2*io_bt+m3_nd+eps;
            iu_z = c_z - in_d/2 - io_off - eps;
            iu_zo = b_z-c_z+eps+io_off+in_d/2;
        
            translate([0,0,iu_zo]) cube([iou_x, iou_y, iu_z]);
            
            // io back upper part
            ou_yo = b_y-iou_y;
            ou_z = c_z - out_b/2 - io_off - eps;
            ou_zo = b_z-ou_z;
            translate([0,ou_yo,ou_zo]) cube([iou_x, iou_y, ou_z]);
            
            // central cover
            cc_x = b_x;
            cc_y = b_y-2*iou_y-2*tol;
            cc_z = io_bt;
            cc_yo = iou_y+tol;
            cc_zo = b_z+tol;
            translate([0,cc_yo,cc_zo]) cube([cc_x,cc_y,cc_z]);
        }        

        
        // in cable cut
        in_xo = b_x/2;
        translate([in_xo,-eps,in_zo]) rotate([-90,0,0]) cylinder(d=in_d,h=io_y);
        
        // out cable cut
        oc_xo = (b_x-out_a)/2;
        oc_yo = out_yo;
        oc_zo = out_zo+tol - out_b/2;
        translate([oc_xo, oc_yo, oc_zo]) cube([out_a,io_y,out_b]);
        
        
        // io bolt holes
        io_bx_left = io_bt + m3_nd/2;
        io_bx_right = b_x-io_bx_left;
        io_by_front = io_bx_left;
        io_by_back = b_y-io_by_front;
        
        ///////////////////////////////////// 
        // holes for bolts and their heads //
        /////////////////////////////////////
        // left front
        translate([io_bx_left, io_by_front,-eps])
        {
            cylinder(h=m3_bh+2*eps, d=m3_bd);
            cylinder(h=m3_bht, d=m3_bhd);
            translate([0,0,b_z-1.5*m3_nh+2*eps])
                cylinder(h=1.5*m3_nh,d=m3_nd,$fn=6);
        }
        // right front
        translate([io_bx_right, io_by_front,-eps])
        {
            cylinder(h=m3_bh+2*eps, d=m3_bd);
            cylinder(h=m3_bht, d=m3_bhd);
            translate([0,0,b_z-1.5*m3_nh+2*eps])
                cylinder(h=1.5*m3_nh,d=m3_nd,$fn=6);
        }
        // left back
        translate([io_bx_left, io_by_back,-eps])
        {
            cylinder(h=m3_bh+2*eps, d=m3_bd);
            cylinder(h=m3_bht, d=m3_bhd);
            translate([0,0,b_z-1.5*m3_nh+2*eps])
                cylinder(h=1.5*m3_nh,d=m3_nd,$fn=6);
        }
        // right back
        translate([io_bx_right, io_by_back,-eps])
        {
            cylinder(h=m3_bh+2*eps, d=m3_bd);
            cylinder(h=m3_bht, d=m3_bhd);
            translate([0,0,b_z-1.5*m3_nh+2*eps])
                cylinder(h=1.5*m3_nh,d=m3_nd,$fn=6);
        }
        
        // holes for the upper cover
        // only left front and back right
        ch_xo_left = cd_x + m3_bhd/2;
        ch_yo_front = io_y + cd_x;
        translate([ch_xo_left, ch_yo_front, -eps])
        {
            cylinder(h=m3_bh+tol+io_bt+2*eps, d=m3_bd);
            cylinder(h=2*m3_bht, d=m3_bhd);
        }

        ch_xo_right = b_x-ch_xo_left;
        ch_yo_back = b_y-ch_yo_front;
        translate([ch_xo_right, ch_yo_back, -eps])
        {
            cylinder(h=m3_bh+tol+io_bt+2*eps, d=m3_bd);
            cylinder(h=2*m3_bht, d=m3_bhd);
        }
        
    }
    
    // holders for chocolate
    ch_x = (b_x-ch_dist)/2;
    ch_y = (b_y)/2;
    ch_z = (b_z-c_z);
    translate([ch_x,ch_y,ch_z]) cylinder(h=ch_h, d=ch_d);
    translate([b_x-ch_x,ch_y,ch_z]) cylinder(h=ch_h, d=ch_d);
    
}

box();