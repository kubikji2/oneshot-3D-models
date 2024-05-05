include<photo-frame.scad>;
$fn = 90;

// interface parameters
// '-> frame thickness
f_t = 10;

// holder parameter
h_y = 45;
h_z = 150;
h_h = 20;
h_d = 8;

wt = 2;

module points_connector(points,d,h)
{
   
    for (i=[0:len(points)-2])
    {
        hull()
        {
            translate(points[i])
                cylinder(d=d,h=h);
            translate(points[i+1])
                cylinder(d=d,h=h);
        }
    }
}


module holder(right = 0)
{
    
    // frame points
    points_f = [    [h_y,0,0],
                    [0,0,0],
                    [0,h_z,0]];
    
    // interface frame
    a = atan(h_y/h_z);
    //echo(a);
    points_a = [    [0,sqrt((h_y*h_y)+(h_z*h_z)),0],
                    [0,0,0],
                    [f_t+h_d,0,0],
                    [f_t+h_d,f_t,0]];
    // back frame
    points_b1 = [   [0,0,0],
                    [-h_y,0,0]];    
    
    points_b2 = [   [-h_y,0,0],
                    [0,2*h_y,0]];
    
    difference()
    {
        // main frame
        points_connector(points=points_f, d=h_d, h=h_h);
        
        // holes
        translate(right ? [0,0,wt+eps] : [0,0,-eps])
        {
            // horizontal
            translate([h_y/2-wp_x/2,-wp_y/2,0])
                cube([wp_x,wp_y,h_h-wt]);
            
            // vertical
            translate([-wp_y/2,h_z/4-wp_x/2,0])
                cube([wp_y,wp_x,h_h-wt]);
            
            translate([-wp_y/2,3*h_z/4-wp_x/2,0])
                cube([wp_y,wp_x,h_h-wt]);
        }
        
    }
    
    // contact interface and frame support
    translate([h_y,0,0])
        rotate([0,0,a])
            points_connector(points=points_a, d=h_d, h=h_h);
    
    // back additional support
    points_connector(points=points_b1,d=h_d,h=h_h);
    points_connector(points=points_b2,d=h_d,h=h_h);        
}


holder();

translate([120,0,0])
    holder(right = 1);
    
    
