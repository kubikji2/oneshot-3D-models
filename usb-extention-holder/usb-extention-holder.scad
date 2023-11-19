include <../solidpp/solidpp.scad>
include <../deez-nuts/deez-nuts.scad>

// usb connector parameters
usb_h = 12;
// '-> height
usb_w = 40;
// '-> width
usb_d = 25;
// '-> depth

// cover parameters
wt = 2;
x = usb_w + 2*wt;
y = usb_d + 2*wt;
z = usb_h + wt;
r = wt;

$fn=$preview ? 20 : 120;

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

cover_body();
