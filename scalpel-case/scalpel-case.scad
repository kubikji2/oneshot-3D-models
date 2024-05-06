$fn = 180;
eps =  0.01;
tol = 0.25;

function sum(arr,i=0,s=0) =
    i < len(arr) ?
    sum(arr,i+1,s+arr[i]) :
    s;
 
function sum_c(arr,c,i=0,s=0) =
    i < len(arr) ?
    sum_c(arr,c,i+1,s+arr[i][c]) :
    s;

function sum_cl(arr,c,l,i=0,s=0) =
    i < l ?
    sum_cl(arr,c,l,i+1,s+arr[i][c]) :
    s;
    
function max_c(arr,c,i=0,m=0) =
    i < len(arr) ?
    max_c(arr,c,i+1,max([m,arr[i][c]])) :
    m;

// scalpel parameters
sp =    [
        [3.0,165,14.0],
        [3.5,165,11.0],
        [6.0,145,12.5],
        [4.5,125, 7.0]
        ];

// scalpel case parameters
wt = 4;
// scalpel distances
sd = 2;

lh = 10;

module scalpel_case()
{
    _x = 2*wt+(len(sp)-1)*sd+sum_c(sp,0);
    _y = 2*wt+max_c(sp,1);
    _z = 2*wt+max_c(sp,2);


    difference()
    {
        // main box
        cube([_x,_y,_z]);
        
        // middle part cut
        translate([-eps,_y/2,wt-tol]) cube([_x+2*eps,_y,_z]);
        
        // lower cut
        translate([-eps,_y/2,-_z+wt/2+tol]) cube([_x+2*eps,_y,_z]);
        
        // left cut
        translate([-eps,_y/2,0]) cube([wt/2+2*eps+tol,_y+tol,_z]); 
        
        // right cut
        translate([_x-wt/2-tol,_y/2,0]) cube([wt/2+tol+eps,_y+tol,_z]);
        
        // upper cut
        translate([0,_y-wt,0]) cube([_x,_y,_z]);
        
        // scalpel case cuts
        for(i=[0:len(sp)-1])
        {
            _cx = sp[i][0];
            _cy = sp[i][1];
            _cz = sp[i][2];
            
            _cxo = wt+sum_cl(sp,0,i)+i*sd;
            translate([_cxo,wt,wt]) cube([_cx,_cy,_cz]);
        }
        
        // cut for scalpel
        translate([-eps,_y/2-lh+eps,-eps])
        difference()
        {
            cube([_x+2*eps,lh,_z+2*eps]);
            translate([wt/2+tol,-eps,wt/2+tol])
                cube([_x-wt-2*tol,lh+2*eps,_z+2*eps-wt-2*tol]);
        }
    
    }
    
    // cover
    translate([-2*_x,0,0])
    difference()
    {
        // basic shape
        cube([_x,_y,_z]);
        translate([-eps,-_y/2+tol-lh,-eps])
            cube([_x+2*eps,_y,_z+2*eps]);
        translate([wt/2-tol,-wt/2+tol,wt/2-tol])
            cube([_x-wt+2*tol,_y,_z-wt+2*tol]);
    }
    
    
}

scalpel_case();