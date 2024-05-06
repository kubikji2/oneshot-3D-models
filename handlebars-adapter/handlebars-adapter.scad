eps = 0.01;
$fn = 690;

x = 9.85;
y = 23;
z = 25;

difference()
{
    cylinder(d=26,h=25);
    translate([-x/2,-3,-eps])
        cube([x,y/2,z+2*eps]);
    _a = 100;
    translate([-_a/2,-_a-3+eps,-_a/2])
        cube([_a,_a,_a]);
}