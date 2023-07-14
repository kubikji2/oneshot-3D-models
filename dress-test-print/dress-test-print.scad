wi = 10;
de = 10;
he = 0.6;
hole_wi = 0.8;
hole_de = 0.8;

difference(){
    cube([wi, de, he]);
    for(i = [0 : 1 : (wi-1)]){
        for(j = [0 : 1 : (de-1)]){
            translate([i, j, 0]) cube([hole_wi, hole_de, he]);
        }
    }
}