eps = 0.01;
$fn = 180;

d = 20;
bx = 154+d;
by = 110+d;
bz = 54;

module box (x=bx,y=by,z=bz,d=20,t=2)
{
    A = x-d;
    B = y-d;
    C = z;
    
    //%translate([-d/2,-d/2,0]) cube([x,y,z]);
    difference()
    {
        hull()
        {
            cylinder(d=d, h=C);
            translate([A,0,0]) cylinder(d=d, h=C);
            translate([A,B,0]) cylinder(d=d, h=C);
            translate([0,B,0]) cylinder(d=d, h=C);
        }
        
        translate([-t/2,-t/2,t])
        hull()
        {
            translate([t,t,0]) cylinder(d=d-t, h=C);
            translate([A,t,0]) cylinder(d=d-t, h=C);
            translate([A,B,0]) cylinder(d=d-t, h=C);
            translate([t,B,0]) cylinder(d=d-t, h=C);
        }
        
        // front holes
        difference()
        {
            translate([-d/2-t,-d/2-eps,0])
                hexagonal_cut(d=20,t=2*t+2*eps,off=2);
            translate([-d/2,-d/2,0])
                cube([d/2,d/2,z]);
            translate([bx-d,-d/2,0])
                cube([d/2,d/2,z]);
            translate([-d/2,-d/2,0])
                cube([bx,by,2*t]);
            translate([-d/2,-d/2,bz-2*t])
                cube([bx,by,2*t]);
        }
        
        // back holes
        translate([0,by-2*t,0]) difference()
        {
            translate([-d/2-t,-d/2-eps,0])
                hexagonal_cut(d=20,t=2*t+2*eps,off=2);
            translate([-d/2,-d/2,0])
                cube([d/2,d/2,z]);
            translate([bx-d,-d/2,0])
                cube([d/2,d/2,z]);
            translate([-d/2,-d/2,0])
                cube([bx,by,2*t]);
            translate([-d/2,-d/2,bz-2*t])
                cube([bx,by,2*t]);
        }
        
        // left holes
        translate([-d/2-3*t,0,0]) rotate([0,0,90]) difference()
        {
            translate([-d/2-t,-d/2-eps,0])
                hexagonal_cut(d=20,t=2*t+2*eps,off=2);
            translate([-d/2,-d/2,0])
                cube([d/2,d/2,z]);
            translate([by-d,-d/2,0])
                cube([d/2,d/2,z]);
            translate([-d/2,-d/2,0])
                cube([bx,by,2*t]);
            translate([-d/2,-d/2,bz-2*t])
                cube([bx,by,2*t]);
        }
        
        // right holes
        translate([bx-d/2-4*t,0,0]) rotate([0,0,90]) difference()
        {
            translate([-d/2-t,-d/2-eps,0])
                hexagonal_cut(d=20,t=2*t+2*eps,off=2);
            translate([-d/2,-d/2,0])
                cube([d/2,d/2,z]);
            translate([by-d,-d/2,0])
                cube([d/2,d/2,z]);
            translate([-d/2,-d/2,0])
                cube([bx,by,2*t]);
            translate([-d/2,-d/2,bz-2*t])
                cube([bx,by,2*t]);
        }
        
    }
}

box();


module hexagonal_cut(d=50, t=2, off=5)
{
    n_rows = 5;
    n_cols = 10;
    
    for(i=[0:n_rows-1])
    {
        v_off = i*sqrt((d+off)*(d+off)-((d+off)/2)*((d+off)/2));
        for(j=[0:n_cols-1])
        {
            if(i % 2 == 0)
            {
                translate([off/2+(d+off)/2+j*(d+off),0,v_off])
                    rotate([-90,90,0])
                        cylinder($fn=6,d=d,h=t);
            } else {
                translate([off/2+j*(d+off),0,v_off]) rotate([-90,90,0])
                    cylinder($fn=6,d=d,h=t);
            }
            
        }
    }
}

//hexagonal_cut(d=50,t=2,off=5);