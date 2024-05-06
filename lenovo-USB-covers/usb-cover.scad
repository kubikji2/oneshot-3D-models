eps = 0.01;
// basic dimensions
// [mm]
x = 12.75;
y = 5.1;
// cover thickness
t = 1.5;
// depth to the USB
d = 2;
// y overlap
y_ol = 2;

// wall thickness on all others sides
wt = 0.35;
wto = 0.2;
// wall thickness on the bellow
WT = 1.75;


// lower part
difference()
{
    translate([0,-y_ol,0]) cube([x,y+y_ol,t]);
    translate([-eps,-3.05,-0]) rotate([-45,0,0]) cube([x+2*eps,t,t]);
        
}
// upper part
translate([wto,wto,t])
    difference()
    {
        //cube([x-2*wt,y-wt-WT,d]);
        cube([x-2*wto,y-2*wto,d]);
        translate([wt,WT,-eps]) cube([x-2*wt-2*wto,y-wt-WT-2*wto,2*eps+d]);
    }