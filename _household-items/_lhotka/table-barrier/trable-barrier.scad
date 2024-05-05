$fn=100;

module barrier(d=5,base_h=4,cut_h=2,l=100,cut_a=18,base_a=30)
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

barrier();