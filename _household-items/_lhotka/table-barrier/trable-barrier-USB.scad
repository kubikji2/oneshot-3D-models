$fn=100;
eps = 0.01;

d = 5;
base_h = 4;
cut_h = 2;
l = 100;
cut_a = 18;
base_a = 30;

module
    barrier(d=d,base_h=base_h,cut_h=cut_h,l=l,cut_a=cut_a,base_a=base_a)
{
    difference()
    {
        hull()
        {
            cylinder(d=d,h=base_h);
            translate([l,0,0]) cylinder(d=d,h=base_h);
            translate([l,base_a,0]) cylinder(d=d,h=base_h);
            translate([0,base_a,0]) cylinder(d=d,h=base_h);           
        }
        translate([-d-0.05,-d-0.05,base_h-cut_h+0.05])
            cube([2*d+l+0.1,cut_a+0.1,cut_h]);
    }
}

//barrier();

module USB_barrier()
{
    usb_xo = 15;
    usb_yo = base_h + eps;
    usb_zo = 0.5;
    
    usb_x = 17;
    usb_y = base_h+2*eps;
    usb_z = 9;
    
    usb_off= 10;
    
    x_leveling = d/2;
    z_leveling = cut_a-d;
    difference()
    {
        translate([d/2,0,-z_leveling]) rotate([90,0,0])
            barrier();
        translate([usb_xo,-usb_yo,usb_zo])
            cube([usb_x,usb_y, usb_z]);
        translate([usb_xo+usb_off+usb_x,-usb_yo,usb_zo])
            cube([usb_x,usb_y, usb_z]);
        
    }
}

USB_barrier();