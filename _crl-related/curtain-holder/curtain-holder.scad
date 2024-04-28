eps = 0.01;
$fn = 90;

// thread diameter
m_d = 10;

// screw diameter
s_d = 3.5;
// screw head diameter
s_h = 7;
// screw head conic part height
s_c = 2.5;

// nut diameter
n_d = 18.25;
// nut thickness
n_t = 8.2;

// bolt head diamater
b_d = 19.5;
// bolt head thickness
b_t = 6.5;

// base leg dimensions
a = 50;
// base thicknes
t = 5;
// total leg heigh
h = 75-2*b_t;

// handle diameter
h_d = 19;

// handle hole heigh
hhh = 30;

module base()
{
    difference()
    {
        // cylinder 
        cylinder(d=a-s_h,h=h,$fn=6);
        // bolt hole
        translate([0,0,-eps])
            cylinder(d=m_d,h=h+2*eps);
        // nut hole
        translate([0,0,h-n_t+eps])
            cylinder(d=n_d, h=n_t+2*eps, $fn=6);
        // handle hole
        translate([0,0,-eps])
            cylinder(d=h_d, h=hhh);
        
    }
}

base();

module foot()
{
    translate([0,0,b_t])
    difference()
    {
        cylinder(d1=a,d2=b_d+2*t,h=b_t, $fn=6);
        translate([0,0,-eps])cylinder(d=b_d,h=b_t+2*eps,$fn=6);
    }
    cylinder(d=a,h=b_t,$fn=6);
}

translate([0,1.5*a,0]) foot();

module foot_ender()
{
    translate([0,0,b_t])
    difference()
    {
        cylinder(d1=a,d2=h_d,h=b_t,$fn=6);
        translate([0,0,-eps])cylinder(d=h_d,h=b_t+2*eps);
    }
    cylinder(d=a,h=b_t,$fn=6);
}

translate([0,-1.5*a,0]) foot_ender();
