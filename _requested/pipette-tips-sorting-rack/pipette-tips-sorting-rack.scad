// basic parameters
$fn = 90;
eps = 0.01;
// free movement tolerance
f_tol = 0.3;
// tight/no movement tolerance
t_tol = 0.1;



// pipette tips parameters
// pipette tips stopping diameters, e.g. diameter of small flat annulus
pt_sd = 4.9;
// pippete tips upper diameter, e.g. maximal diameter of the whole pipette tip
pt_ud = 7.5;
// pippete tips height
pt_h = 15;
// pipette tips upper height, e.g. distance from the flat annulus to the top of the pipette
pt_uh = 17+10;

// comb carriage parameter
// comb carriage height, e.g. distance from the bottom to the lower part of the carriage
cc_h = 2;
// comb carriage thickness
cc_t = 3;

// grid paramaters parameters
n_rows = 8;
n_cols = 12;
// height of the grid
g_h = 2*cc_h+cc_t;
// distance between centers
g_l = 9;

// comb paramters
// comb width
c_w = g_l-pt_sd;
// commb handle diameter
c_hd = 10;


// hinge paramteres
// hinge height, e.g. distance from the one hole end to another
h_h = 12;
// hinge diameter, e.g. diameter of the inner cylinder
h_d = 2;
// outer hinge diamter, e.g. inner cylinder plus its walls
h_D = h_d + 4;

// border parameteres
// wall thiskness
w_t = 2;
// additional border height, e.g. additional distance from the top most part of pipette tips.
// must be at least as big as the hinge outer diameters for hinges to fit
b_h = h_D;

// door parameters
// door reinforcement in y axis
drf_y = 5;

// hinge end reinforcement
//h_r = 5;

// outer hinbe
module outer_hinge()
{
    rotate([-90,0,0])
    {
        // incerface part
        cube([h_h,h_D,w_t]);
        // main body
        difference()
        {
            // no idea to be honest -- do not remeber writing that part
            union()
            {
                union()
                {
                    translate([0,0,w_t]) cube([h_h/4,h_D,h_D/2+f_tol]);
                    translate([0,h_D/2,h_D/2+w_t+f_tol]) rotate([0,90,0])
                        cylinder(h=h_h/4,d=h_D);
                }
                
                translate([h_h-h_h/4,0,0])
                union()
                {
                    translate([0,0,w_t]) cube([h_h/4,h_D,h_D/2+f_tol]);
                    translate([0,h_D/2,h_D/2+w_t+f_tol]) rotate([0,90,0])
                        cylinder(h=h_h/4,d=h_D);
                }
            }
            
            translate([-eps,h_D/2,h_D/2+w_t+f_tol]) rotate([0,90,0])
                cylinder(h=h_h+2*eps,d=h_d+t_tol);
            
        }
    }
        
}

module door()
{
    _l = 0.5;
    
    x = n_cols*g_l+2*w_t;
    y = h_D/2;
    z = g_h + pt_uh-_l;
    //echo(z);
    
    rotate([-90,0,0]) cube([x,y,z]);
    
    translate([0,-h_D-_l,-h_D+h_d/2-f_tol/2]) inner_hinge(l=_l);
    translate([x-h_h,-h_D-_l,-h_D+h_d/2-f_tol/2]) inner_hinge(l=_l);
}

///door();

// inner hinge
module inner_hinge(l=1)
{
    {
        // main
        translate([h_h/4+f_tol,0,0])
        difference()
        {
            union()
            {
                translate([0,h_D/2,w_t+f_tol/2])
                    cube([h_h/2-2*f_tol,h_D/2+f_tol+l,h_D/2]);
                translate([0,h_D/2,h_D/2+w_t]) rotate([0,90,0])
                    cylinder(h=h_h/2-2*f_tol,d=h_D-f_tol);
            }
                       
            translate([-eps,h_D/2,h_D/2+w_t]) rotate([0,90,0])
                cylinder(h=h_h/2+2*eps-2*f_tol,d=h_d+0.5);
            
            
            
        }
    }
}


module ptsr()
{
    x = n_cols*g_l + 2*w_t;
    // TODO add more reinforcement to the door area
    y_c = 3;
    y = w_t +y_c*(n_rows*g_l) + drf_y;
    z = g_h + pt_uh + b_h;
    off = pt_ud;
    
    difference()
    {
        // main shape
        cube([x,y,z]);
        
        
        // main cut
        translate([w_t, w_t, z+eps])
        hull()
        {
            _x = x-2*w_t;
            _y = y_c*(n_rows*g_l);
            _z = pt_uh-pt_h+b_h+2*eps;
            points = [  [0,off,-_z],
                        [0,0,0],
                        [0,_y-off,-_z],
                        [0,_y,0]];
            for(i=[0:len(points)-1])
            {
                translate(points[i])
                   rotate([0,90,0]) cylinder(h=_x,d=eps); 
            }
        }
        
        // cut for tips to fall in
        for(i=[0:n_cols-1])
        {
            // lower cut for the pipette tips
            _x = w_t+g_l/2 + i*g_l;
            _y = w_t+g_l/2;
            translate([_x,0,-eps]) hull()
            {
                translate([0,_y,0])
                    cylinder(d=pt_sd,h=g_h+2*eps);
                translate([0,y+4*w_t+2*f_tol,0])
                    cylinder(d=pt_sd,h=g_h+2*eps);
            }
            
            // upper cut for the pipette tips
            translate([_x,0,g_h])
            difference()
            {
                hull()
                {
                    translate([0,_y,0])
                        cylinder(d=pt_ud,h=pt_uh+2*eps);
                    translate([0,y+4*w_t+2*f_tol,0])
                        cylinder(d=pt_ud,h=pt_uh+2*eps);
                }
                // adding archs nexto the doors
                difference()
                {
                    _d = pt_ud;
                    translate([-_d/2,y-_d,pt_uh-_d/2])
                        cube([_d,_d,_d/2]);
                    translate([0,y+eps,pt_uh-_d/2])
                        rotate([90,0,0])
                            cylinder(h=10,d=_d);
                }
            }
            // cut for border
            translate([_x,_y,g_h])
                cylinder(h=pt_uh+b_h,d=pt_ud);
        }
        
        // cut holes for the comb
        translate([-eps, y,cc_h])
        {
            for(i=[1:n_rows])
            {
                _y = -i*g_l-c_w/2;
                translate([0,_y-f_tol,-f_tol])
                    cube([x+2*eps,c_w+2*f_tol,cc_t+2*f_tol]);
            }
        }
        
    }
    
    // brim cheater
    //translate([0,y-2*w_t,0]) cube([x,2*w_t,0.21]);
    
    // insert carriages
    _ic_d = 2*g_l;
    translate([0 ,w_t +y_c*(n_rows*g_l) + drf_y-g_l/2,0])
    {
        // lower inserter carriages
        // cubic part
        translate([-_ic_d/4-2,-(n_rows+0.5)*g_l,0])
            cube([_ic_d/4+2,((n_rows+1)*g_l),cc_h-f_tol]);
        // rounded part
        translate([-_ic_d/4-2,0,0])
        hull()
        {
            cylinder(d=_ic_d/2,h=cc_h-f_tol);
            translate([0,-((n_rows)*g_l),0])
                cylinder(d=_ic_d/2, h=cc_h-f_tol);
        }
        
        // side triangular-like carriages
        translate([0,0,cc_h-f_tol])
        {
            for(i=[0:n_rows])
            {
                _x = n_cols*g_l + 2*w_t;
                _y = -i*g_l-c_w/2-f_tol/2-4*eps;
                
                // teeth
                translate([0,_y,0])
                hull()
                {
                    _d = g_l - c_w-2*f_tol-2*eps;
                    _h = cc_t+2*f_tol;
                    cylinder(d=0.01,h=_h);
                    translate([0,_d,0]) cylinder(d=0.01,h=_h);
                    translate([-_ic_d/2,_d/2,0]) cylinder(d=0.01,h=_h);
                }
            
            }
        }
    }
    
    translate([x,w_t +y_c*(n_rows*g_l) + drf_y-g_l/2,0])
    {
        // lower inserter carriages
        // cubic part
        translate([0,-(n_rows+0.5)*g_l,0])
            cube([_ic_d/4+2,((n_rows+1)*g_l),cc_h-f_tol]);
        // rounded part
        translate([_ic_d/4+2,0,0])
        hull()
        {
            cylinder(d=_ic_d/2,h=cc_h-f_tol);
            translate([0,-((n_rows)*g_l),0])
                cylinder(d=_ic_d/2, h=cc_h-f_tol);
        }
        
        // side triangular-like carriages
        translate([0,0,cc_h-f_tol])
        {
            for(i=[0:n_rows])
            {
                _x = n_cols*g_l + 2*w_t;
                _y = -i*g_l-c_w/2-f_tol/2-4*eps;
                // teeth 
                translate([0,_y,0])
                hull()
                {
                    _d = g_l - c_w-2*f_tol-2*eps;
                    _h = cc_t+2*f_tol;
                    cylinder(d=0.01,h=_h);
                    translate([0,_d,0]) cylinder(d=0.01,h=_h);
                    translate([_ic_d/2,_d/2,0]) cylinder(d=0.01,h=_h);
                }
            
            }
        }
    }
    // hinges
    translate([0,y-w_t,z]) outer_hinge();
    translate([x-h_h,y-w_t,z]) outer_hinge();
    
    // pipet tips
    /*
    for(i=[0:n_rows-1])
    {
        %translate([w_t+g_l/2,y-ft_ud/2-i*g_l,0])
        {
            cylinder(h=10,d=ft_ud);
            translate([0,0,-5]) cylinder(h=10,d=ft_sd);
        }
    }
    */
}

ptsr();


/*
translate([0,2*n_rows*g_l+w_t+drf_y+h_D/2+f_tol,g_h + pt_uh-f_tol])
    rotate([-90,0,0])
        door();
*/


module comb()
{
    // holder part
    translate([-c_hd/2,w_t +2*(n_rows*g_l) + drf_y-g_l/2, cc_h])
    hull()
    {
        cylinder(d=c_hd,h=cc_t);
        translate([0,-((n_rows)*g_l),0])
            cylinder(d=c_hd, h=cc_t);
        
    }
    
    // comb teeth
    translate([-eps, w_t +2*(n_rows*g_l) + drf_y, cc_h])
        {
            for(i=[1:n_rows])
            {
                _x = n_cols*g_l + 2*w_t;
                _y = -i*g_l-c_w/2;
                translate([0,_y,0])
                    cube([_x+2*eps+i*g_l,c_w,cc_t]);
                
                // enamel
                translate([_x+2*eps+i*g_l,_y,0])
                hull()
                {
                    cylinder(d=0.01,h=cc_t);
                    translate([0,c_w,0]) cylinder(d=0.01,h=cc_t);
                    translate([g_l,0,0]) cylinder(d=0.01,h=cc_t);
                }
            
            }
        }
}

//translate([-g_l/2,0,0])comb();

