eps = 0.01;
z_tol = 0.8;
tol = 0.5;
$fn = 90;

// wood piece parameters
wp_x = 16.15;
wp_y = 3.25;

// additional paramters
// difference between lenth of the woodpiece and glass
// '-> per each side
df = 5;
// wall thickness
wt = 3;
// glass thickness
gt = 3;
// sololit thiskness
st = 3;

// M2 parameters
m2_l = 10;
m2_d = 2;
m2_hd = 3.8;
m2_hh = 1.4;
m2_nh = 1.5;
m2_nd = 4.75;

module bolt_hole()
{
    // bolt head
    translate([0,0,m2_l])
        cylinder(h=m2_l, d=m2_hd);
    // bolt body
    cylinder(h=m2_l+eps,d=m2_d);
    // nut hole
    translate([0,0,m2_nh+tol-m2_l])
        cylinder(h=m2_l, d=m2_nd, $fn=6);
}

module corner_bolt_holes()
{
    _x = wp_x-wt-df/2;
    _y = wp_x-tol-(df)/2;
    _z = 2*wt+gt+st+wp_y-m2_l-m2_hh;
    // left bolt
    translate([-_x, _y, _z])
        bolt_hole();
    // down bolt
    translate([_y, -_x, _z])
        rotate([0,0,90])
            bolt_hole();
    // corner bolt
    translate([_y, _y, _z])
        rotate([0,0,0])
            bolt_hole();

}

module corner()
{
    // total z height
    _tz = wt+gt+st+wp_y+wt;
    difference()
    {
        union()
        {
            // horizontal piece
            translate([-wp_x,-wt,0])
                cube([2*wp_x+wt,wt+wp_x+wt,_tz]);
            // vertical piece
            translate([-wt,-wp_x,0])
                cube([wt+wp_x+wt,2*wp_x+wt,_tz]);
        }
        
        // cut for the wood pieces
        // '-> horizontal
        translate([-eps-wp_x,0,wt+st+gt])
            cube([2*wp_x+eps,wp_x,wp_y]);
        // '-> vertical
        translate([0,-wp_x-eps,wt+st+gt])
            cube([wp_x,2*wp_x+eps,wp_y]);
                
        // universal cut
        translate([-wp_x-eps, -wp_x-eps, -eps])
            cube([2*wp_x, 2*wp_x, wt+st+gt+2*eps]);
        
        // bolt holes
        corner_bolt_holes();
         
    }
    
}

module corner_bottom()
{
    translate([-wp_x,-wp_x,0])
    difference()
    {
        // main shape
        cube([2*wp_x-tol, 2*wp_x-tol, wt+st+gt-tol]);
        
        // cut for glass
        translate([-eps, -eps, wt+st+eps])
            cube([2*wp_x-tol+eps-df, 2*wp_x-tol+eps-df, gt+eps]);
        
        // cut for sololit
        translate([-eps, -eps, wt+eps])
            cube([2*wp_x-tol+eps-df, 2*wp_x-tol+eps-df, st+eps]);
        
        // bolt holes
        translate(-1*[-wp_x,-wp_x,0])
            corner_bolt_holes();
        
    }
}


/***************
* SIDE MODULES *
***************/

module side_holes()
{
    _x = wp_x-df;
    _y = wp_x-tol-(df)/2;
    _z = 2*wt+gt+st+wp_y-m2_l-m2_hh;
    // down bolt
    translate([_y, -_x, _z])
        rotate([0,0,90])
            bolt_hole();
    // up bolt
    translate([_y, _x, _z])
        rotate([0,0,90])
            bolt_hole();
 
}


module side()
{
    // total z height
    _tz = wt+gt+st+wp_y+wt;
    difference()
    {
        union()
        {

            // vertical piece
            translate([-wt,-wp_x,0])
                cube([wt+wp_x+wt,2*wp_x,_tz]);
        }
        
        // cut for the wood pieces
        translate([0,-wp_x-eps,wt+st+gt])
            cube([wp_x,2*wp_x+2*eps,wp_y]);
                
        // universal cut
        translate([-wp_x-eps, -wp_x-eps, -eps])
            cube([2*wp_x, 2*wp_x+2*eps, wt+st+gt+2*eps]);
        
        // bolt holes
        side_holes();
         
    }
}

module side_bottom()
{
    translate([-wt,-wp_x,0])
    difference()
    {
        // main shape
        cube([wp_x+wt-tol, 2*wp_x, wt+st+gt-tol]);
        
        // cut for glass
        translate([-eps, -eps, wt+st+eps])
            cube([wp_x+wt-tol+eps-df, 2*wp_x+2*eps, gt+eps]);
        
        // cut for sololit
        translate([-eps, -eps, wt+eps])
            cube([wp_x+wt-tol+eps-df, 2*wp_x+2*eps, st+eps]);
        
        // bolt holes
        translate(-1*[-wt,-wp_x,0])
            side_holes();
        
    }
}
    

//side();

//side_bottom();

/*
corner();
corner_bottom();
*/