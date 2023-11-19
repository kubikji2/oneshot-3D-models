include <../solidpp/solidpp.scad>
include <../deez-nuts/deez-nuts.scad>

// usb connector parameters
usb_h = 12;
// '-> height
usb_w = 40;
// '-> width
usb_d = 25;
// '-> depth
usb_wing_d = 7.5;
usb_wing_w = 7;
usb_wing_g = 29;
usb_cable_d = 8;

USB_W = 15;
USB_H = 7.5;

// cover parameters
wt = 2;
x = usb_w + 2*wt;
y = usb_d + 3*wt;
z = usb_h + wt;
r = wt;

$fn=$preview ? 20 : 120;


// cover body
module cover_body()
{
    mod_list = [round_corners(r=r)];
    size = [x,y,2*z];

    intersection()
    {
        cubepp(size,align="y", mod_list=mod_list);
        cubepp(size,align="yz");
    }
}


// usb extention holder
module usb_extention_holder(txt="MINI")
{

    difference()
    {
        // basic shape
        cover_body();

        // USB hole
        translate([0,0,usb_h/2])
            cubepp([USB_W, 5*wt, USB_H], align="");

        // adding hole for the mounting usb holder
        _b_off = wt+3;
        mirrorpp([1,0,0], true)
            translate([usb_wing_g/2, wt, usb_h/2])
                rotate([90,0,0])
                    bolt_hole(descriptor="M3x5", standard=DN_BOLT_SLOTTED_HEAD, align=DN_ALIGN_MIDDLE);

        // adding mounting holes
        _s_off = wt+3;
        mirrorpp([1,0,0], true)
            translate([x/2-_s_off,y-_s_off,z])
                screw_hole(descriptor="M3x20",standard=DN_SCREW_PHILLIP, align=DN_ALIGN_TOP);
        
        // adding hole for the usb
        _off = 2*wt;
        translate([0, _off, 0])
        {
            cubepp([usb_w, usb_wing_d, 2*usb_h], align="y");
            cubepp([usb_w-2*usb_wing_w, usb_d, 2*usb_h], align="y");
        }

        // adding cable hole
        translate([0, _off+usb_d, usb_h/2])
        {
            cylinderpp(d=usb_cable_d,h=3*wt,zet="y",align="");
            cubepp([usb_cable_d,usb_cable_d,usb_h],align="Z");
        }

        // text
        translate([0,(y-6)/2,z-0.2+DN_EPS])
            linear_extrude(0.2)
                offset(0.1)
                    text(txt, valign="center", halign="center");
    }

}

txt="MINI";
body=false;

if(body)
{
    usb_extention_holder(txt=txt);
}
else
{
    translate([0,(y-6)/2,z-0.2])
        linear_extrude(0.2)
            text(txt, valign="center", halign="center");
}