eps = 0.01;
tol_z = 0.3;
$fn = 90;
// hole parameters
x = 18.75;
y = 12.75;
t = 0.5;
off = 1;
coff = 0.5;
wt = 1; 

// strip terminal parameters
nh = 1.8;
nd = 4.7;
bd = 2.5;

difference()
{
    union()
    {
        // upper cover
        cube([x+off,y+off,wt]);
        
        // hole fill
        translate([off/2,off/2,wt])
            cube([x,y,t]);
        // sloped cut
        translate([(off-coff)/2,(off-coff)/2,wt+t])
        hull()
        {
            cube([x+coff,y+coff,eps]);
            translate([coff/2,coff/2,2*wt])
                cube([x,y,eps]);
        }
    
    }
    
    h = wt+t+2*wt;
    
    // center frame
    translate([(x+off)/2,(y+off)/2,h])
    {
        // bolt hole
        translate([0,0,-wt-nh+2*eps])
            cylinder(h=wt+nh,d=bd);
        // nut hole
        translate([0,0,-wt-nh-2*eps])
            cylinder(h=nh,d=nd,$fn=6);
    }
    
    
}