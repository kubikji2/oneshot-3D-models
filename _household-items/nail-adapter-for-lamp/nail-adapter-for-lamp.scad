// based on the old code from discontinued repository: 
// https://github.com/kubikji2/useful-models/tree/master

$fn = 90;
eps = 0.01;

nail_d = 2;
inner_d = 4;
outer_d = 6.5;

difference()
{
    // main body
    union()
    {
        cylinder(d=outer_d+2, h=2);
        translate([0,0,2])
            cylinder(d=inner_d,h=2);
        translate([0,0,4])
            cylinder(d=outer_d,h=2);
    }

    // nail hole
    translate([0,0,-eps])
        cylinder(d=nail_d,h = 7++2*eps);
    
}