$fn = 90;
eps = 0.01;
tol_z = 0.5;
tol_xy = 0.1;

// wall parameters
// wall thickness
t = 7;
// wall height
h = 30;


// backpack hook parameters
// backpack hook lowering
bh_l = 10;
// backpack hook contact plane
bh_c = 35+t;

// screw block
sb_l = 2*18+t;
sh_o = 9+18;
sh_bo = t/2+2*18;
sh_d = 3.5;
sh_D = 6.8;

// headphones hook parameters
hh_l = 200-10;
hh_alpha = 25;
hh_x = -hh_l*sin(hh_alpha);
hh_y = hh_l*cos(hh_alpha);

// headphones hook interface width
hh_iw = 35+t;
hh_io = 10;
hh_ih = 25-hh_io;

// wooden piece parameters
wp_w = 16.1 + tol_z;
wp_t = 3.5 + tol_xy;
wp_d = 15;


// sole backpack holder
module backpack_hook()
{
    points = [  [0,hh_ih+hh_io,0],
                [0,hh_io,0],
                [hh_io,0,0],
                [hh_iw,0,0],
                [hh_io+hh_iw,hh_io,0],
                [hh_io+hh_iw,hh_io+hh_ih,0]];
    
    for(i=[0:len(points)-2])
    {
        translate([-hh_io-hh_iw,-hh_ih,0])
        hull()
        {
            translate(points[i]) cylinder(d=t,h=h);
            translate(points[i+1]) cylinder(d=t,h=h);
        }
    }    
    
}

//backpack_hook();

// helmet hook for the furniture
module helmet_hook(co=0,off=2*hh_ih)
{
    points = [  [0,hh_ih+hh_io,0],
                [0,hh_io,0],
                [hh_io,0,0],
                [hh_iw,0,0],
                [hh_io+hh_iw,hh_io,0],
                [hh_io+hh_iw,hh_io+hh_ih+off,0],
                [hh_io+hh_iw+18+t,hh_io+hh_ih+off],
                [hh_io+hh_iw+18+t,hh_io+hh_ih],];
    
    for(i=[0:len(points)-2-co])
    {
        translate([-hh_io-hh_iw,-hh_ih,0])
        hull()
        {
            translate(points[i]) cylinder(d=t,h=h);
            translate(points[i+1]) cylinder(d=t,h=h);
        }
    }
}

/*
helmet_hook();
*/
module helmet_hook_upper()
{
    difference()
    {
        helmet_hook();
        
        // hole for the wood piece
        _xo = (t-wp_t)/2;
        _zo = (h-wp_w)/2;
        translate([-_xo,-wp_d,_zo])
            cube([wp_t,2*wp_d,wp_w]);
        
        // hole for bolt
        translate([t/2+eps,0,h/2])
            rotate([0,-90,0])
                union()
                {
                    cylinder(h=6.5,d=2.2);
                    cylinder(h=1.5,d=3.8);                    
                }          
        
    }
}

/*
translate([75 ,0,0])
    helmet_hook_upper();
*/

module helmet_hook_lower()
{
    difference()
    {
        helmet_hook(co=2,off=65);
        
        translate([0,65,0])
        {
            // hole for the wood piece
            _xo = (t-wp_t)/2;
            _zo = (h-wp_w)/2;
            translate([-_xo,-wp_d,_zo])
                cube([wp_t,2*wp_d,wp_w]);
            
            // hole for bolt
            translate([t/2+eps,0,h/2])
                rotate([0,-90,0])
                    union()
                    {
                        cylinder(h=6.5,d=2.2);
                        cylinder(h=1.5,d=3.8);                    
                    }          
        }
    }   
}

/*
helmet_hook_lower();
*/

module screw_block()
{
    difference()
    {
        union()
        {
            // main screw block
            hull()
            {
                cylinder(d=t,h=h);
                translate([0,sb_l-t/2,0])
                    cylinder(d=t,h=h);
            }
            
            // border
            translate([0,sh_bo,0])
            {
                hull()
                {
                    cylinder(d=t,h=h);
                    translate([20,0,0])
                        cylinder(d=t,h=h);
                }
            }
        }
        
        // lower screw hole
        translate([t/2+eps,sh_o,t/2+sh_D/2])
            rotate([0,-90,0])
            {
                cylinder(d=sh_d,h=t+2*eps);
                translate([0,0,t-sh_D+sh_d+2*eps])
                    cylinder(d1=sh_d,d2=sh_D,h=sh_D-sh_d);
            }
        
        // upper screw hole
        translate([t/2+eps,sh_o,h-(t/2+sh_D/2)])
            rotate([0,-90,0])
            {
                cylinder(d=sh_d,h=t+2*eps);
                translate([0,0,t-sh_D+sh_d+2*eps])
                    cylinder(d1=sh_d,d2=sh_D,h=sh_D-sh_d);
            }
        
        // check hole
        //#cube([10,2*18,10]);
        //%cube([10,9+18,10]);
            
    }
    
    
}

//screw_block();

module headphone_hook()
{
    hull()
    {
        cylinder(h=h,d=t);
        translate([hh_x,hh_y,0])
            cylinder(h=h,d=t);
    }
    
    points = [  [0,hh_ih+hh_io,0],
                [0,hh_io,0],
                [hh_io,0,0],
                [hh_iw,0,0],
                [hh_io+hh_iw,hh_io,0],
                [hh_io+hh_iw,hh_io+hh_ih,0]];
    
    translate([hh_x-hh_iw/2-3,hh_y,0])
    {
        for(i=[0:len(points)-2])
        {
            hull()
            {
                translate(points[i]) cylinder(d=t,h=h);
                translate(points[i+1]) cylinder(d=t,h=h);
            }
        }   
    }
}

module headphones_and_backpack_hook()
{
    backpack_hook();
    screw_block();
    translate([0,sb_l-t/2,0])
        headphone_hook();
}

//headphones_and_backpack_hook();

module backpack_only_hook()
{
    backpack_hook();
    screw_block();
}

backpack_only_hook();