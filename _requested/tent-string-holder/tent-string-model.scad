dia = 24.1;
$fn = 120*3;

difference(){
    union(){
        translate([0, 0, dia/2])
            sphere(d = dia);
        translate([0, 0, (dia-1.4)/2])
        {
            cylinder(h = 1.4, d1 = dia, d2 = 28.5);
            translate([0,0,1.4])
                cylinder(h=1.4,d=28.5);
        }
    }
    union(){
        cylinder(h = 2, d = dia); 
        cylinder(h = dia, d = 9.3);
        translate([0, 0, 4])
            cylinder(h = dia, d = 12.7);
    }
}