$fn = 180;
eps = 0.01;
eps2 = 2*eps;
height = 14;
Height = 17.5;
tol = 0.2;

x = 15.7;
l_x = 4.75;
y = 8;
d = 4;
D = 8;

r1 = 6;
r2 = 10;
r3 = 14;

// second quadrant from extruded annulus 
module q_cylinder(r_i = r1, r_o = r3, h = 10)
{
    //%cylinder(r = r_o, h = h);
    difference()
    {
        //eps = 1;
        //eps2 = 2;
        cylinder(r = r_o, h = h);
        translate([0, 0, -eps]) cylinder(r = r_i, h = h+eps2);
        translate([0, -eps, -eps]) cube([r_o+eps, r_o+eps2, h+eps2]);
        translate([-eps, -r_o-eps, -eps]) cube([r_o+eps2,r_o+eps2,h+eps2]);
        translate([-r_o-eps, -r_o-eps, -eps]) cube([r_o+eps2,r_o+eps,h+eps2]);
    }
}

//q_cylinder();

// wings to lock piece to the stairs
module wing()
{
    difference()
    {

        z = height-tol;
        //base
        cube([x,y,z]);
        // clip
        translate([x-l_x+eps-tol,y-4+eps-tol,-eps]) cube([l_x+tol,4+tol,z+eps2]);
        // screw hole (inner)

        h1 = 4.5;
        h3 = 1.8;
        h2 = y-h1-h3;
        translate([3.5+d/2,y+eps,z/2]) rotate([90,0,0])
        {
            cylinder(d=d,h=h1+eps2);
            translate([0,0,h1-eps]) cylinder(d1=d,d2=D,h=h2+eps2);
            translate([0,0,h1+h2-eps-eps]) cylinder(d=D,h=h3+eps2+1);
        }
    }
}

//wing();

// inner piece
module inner()
{
    // upper part
    wing();
    // medium part
    translate([0,-r1,0]) q_cylinder(r_i=r1,r_o=r3,h=height-tol);
    // down part
    translate([0-r1,-r1,height-tol]) rotate([0,180,90]) wing();
    
    
}

// outer piece side
module base()
{
    h = Height-height;
    rad = 6;
    // middle
    translate([0,-r1,0]) q_cylinder(r_i=0,r_o=r3,h=h); 
    hull()
    {
        // upper
        cube([x,r3-r1,h]);
        // upper small cube
        translate([x,d,0]) cube([rad,d,h]);
        // upper small q_cylinder
        translate([x,rad-d,0]) rotate([0,0,180]) q_cylinder(r_i = 0, r_o = rad,h=h);
        // lower
        translate([0-r1,-r1,h]) rotate([0,180,90]) cube([x,r3-r1,h]);
        // lower small cube
        translate([-2*d-r1,-2*rad-x,0]) cube([d,rad,h]);
        // lower small q_cylinder
        translate([-d-d,-x-rad,0]) rotate([0,0,180]) q_cylinder(r_i = 0, r_o = rad,h=h);
    }
}

//base();

// outer part to be put on from sides
module outer()
{
    h = Height-height;
    rad = 6;
    // upper locker
    translate([x-l_x,d,h]) cube([l_x,d,height]);

    // down locker
    translate([-r1-d-d,-x-r1,h]) cube([d,l_x,height]);
    
    // medium part
    difference()
    {
        hull()
        {   
            // upper part cube
            translate([x,rad-d,h]) cube([rad,rad,height]);
            // upper part q_cylinder
            translate([x,rad-d,h]) rotate([0,0,180]) q_cylinder(r_i = 0, r_o = rad,h=height);
            // down part cube
            translate([-2*d-r1,-2*rad-x,h]) cube([rad,rad,height]);
            // down part q_cylinder
            translate([-d-d,-x-rad,h]) rotate([0,0,180]) q_cylinder(r_i = 0, r_o = rad,h=height);
        };
        // upper tongue hole
        translate([0, -tol, h-eps]) cube([x+tol,d+tol,height+eps2]);
        // down tongue hole
        translate([-r1-d, -r1-x-tol, h-eps]) cube([d+tol,x+tol,height+eps2]);
        // rod hole
        translate([0,-r1,h-eps]) cylinder(r=r1,h=height+eps2);
    }
    
    // lower part
    base();
}

translate([0,0,Height-height+tol]) inner();
outer();

//translate([0,20,0])
//q_cylinder();

