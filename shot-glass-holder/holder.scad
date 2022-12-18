_t = 0.5;
d_a = 29.5 + _t;
r_a = d_a/2;
d_b = 38.7 + _t;
r_b = d_b/2;
h = 68.2 + _t;
w = 50;

module shot_glass(){
    cylinder(h, r_a, r_b, true);
}


module shot_glass_o(t = 2){
    difference(){
        cylinder(h+t, r_a+t, r_b+t, true);
        shot_glass();
        translate([-w/2, -w/2, h/2-t/2])
            cube([w, w, 2*t]);
        }
}

shot_glass_o();
 