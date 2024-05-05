$fn = 100;
eps = 0.01;
h = 30;
d = 1;
a = 75;

module connector(){
    difference(){
        cube([60,25,5]);
        translate([5+2.5,10+2.5,-eps]) hull(){
            cylinder(h=5+2*eps,d=5);
            translate([5,0,0]) cylinder(h=5+2*eps,d=5);
        }
        translate([60-10,10,-eps]) hull(){
            cylinder(h=5+2*eps,d=5);
            translate([0,5,0]) cylinder(h=5+2*eps,d=5);
        }
      
    }
}
translate([(75-60)/2,26,0]) connector();
translate([0,26,0]) cube([10,25,5]);
translate([65,26,0]) cube([10,25,5]);


difference()
{
    union(){
        //%translate([-d/2,-d/2,0])cube([75,75,30]);
        hull(){
            cylinder(h=h,d=d);
            translate([a,0,0]) cylinder(h=h,d=d);
            translate([a,a,0]) cylinder(h=h,d=d);
            translate([0,a,0]) cylinder(h=h,d=d);
        }
    }
    translate([(75-66)/2,(75-61)/2,-1]) cube([66,61,30+2]);
    translate([75/2,8,0]) rotate([90,0,0]) cylinder(d=10,h=10);
}

