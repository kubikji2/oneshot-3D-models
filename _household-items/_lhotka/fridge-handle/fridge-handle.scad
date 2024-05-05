$fn = 90;
eps = 0.01;
// distance between holes
d = 132.5;
// inner holes radius
r_i = 4/2;
// inner holes height
h_i = 4;
// inner holes mantinels thickness
t_i = 1.3;
// inner holes mantinels relative height
rh_i = 0.5;

// inner hole distance
d_i = 11-2*r_i;
// outer holes radius
r_o = 10.4/2;
// outer holes distance
d_o = 15.3 - 2*r_o;
// distance from hole border to mountlet border
h2b_d = 10;
// hole offset in y axis
ho_y = 5.5;

// mounting plate depth (y dimension) including fridge mantinel 
m_y = 30;
// mounting plate thickness
m_z = 6;
// mounting plate corner diameter
m_d = 5;

// mounting plate dimensions
x_dim = h2b_d + 2*r_i + d + 2*r_i + h2b_d;
y_dim = m_y;
z_dim = m_z;

// border mantinel thickness
bm_y = 5.5;
// border mantinel height from mounting plate
bm_z = 15;

// distance from handle to mantinel
h2m_d = 25;
// handle support x_dim
hs_x = 25;
// handle diameter
h_d = 16;
// handle off set in z dimension
h_z_off = 16;

module holes()
{
    y_off = d_i/2;
    // screw holes
    hull()
    {
        translate([0,y_off,-eps]) cylinder(r=r_i,h=h_i+rh_i+2*eps);
        translate([0,-y_off,-eps]) cylinder(r=r_i,h=h_i+rh_i+2*eps);    
    }
    
    // mantinels hole
    z_off = h_i;
    y_off2 = d_o/2;
    difference()
    {
        hull()
        {
            translate([0,y_off2,z_off]) cylinder(r=r_o,h=rh_i);
            translate([0,-y_off2,z_off]) cylinder(r=r_o,h=rh_i);
        }
        
        hull()
        {
            translate([0,y_off,z_off-eps]) cylinder(r=r_i+t_i,h=rh_i+2*eps);
            translate([0,-y_off,z_off-eps]) cylinder(r=r_i+t_i,h=rh_i+2*eps);
        }        
    }
    
    //the most upper part
    z_off2 = z_off + rh_i;
    t = m_z - z_off;
    hull()
    {
        translate([0,y_off2,z_off2-eps]) cylinder(r=r_o,h=t+2*eps);
        translate([0,-y_off2,z_off2-eps]) cylinder(r=r_o,h=t+2*eps);
    }  
    
}

//holes();

module mounting_plate()
{   
    hull()
    {
        translate([-x_dim/2, -y_dim/2,0]) cube([x_dim, y_dim/2,z_dim]);
        translate([x_dim/2-m_d/2,y_dim/2-m_d/2]) cylinder(d=m_d,h=z_dim);
        translate([-x_dim/2+m_d/2,y_dim/2-m_d/2]) cylinder(d=m_d,h=z_dim);        
    }
}


module handle_support()
{
    translate([-hs_x/2,0,0])
    hull()
    {
        cube([hs_x,bm_y,bm_z+z_dim]);
        translate([0,-h2m_d-h_d/2,h_z_off+z_dim+h_d/2])
            rotate([0,90,0]) cylinder(d=h_d,h=hs_x);
    }
}
//handle_support();

module handle()
{
    // mounting plate
    difference()
    {
        mounting_plate();
        y_off = y_dim/2-d_i/2-r_i-ho_y;
        translate([d/2,y_off,z_dim]) rotate([0,180,0]) holes();
        translate([-d/2,y_off,z_dim]) rotate([0,180,0]) holes();

    }
    
    // fridge door border mantinel
    translate([-x_dim/2,-y_dim/2,z_dim]) cube([x_dim,bm_y,bm_z]);
    
    // handle    
    translate([0,-h2m_d,h_z_off+h_d/2])
        // alignement with mantinel
        translate([0,-y_dim/2-h_d/2,z_dim]) rotate([0,90,0])
            // horizontal handle
            translate([0,0,-x_dim/2]) cylinder(d=h_d,h=x_dim);
    
    // handle supports
    translate([x_dim/2-hs_x/2,-y_dim/2,0]) handle_support();
    translate([-x_dim/2+hs_x/2,-y_dim/2,0]) handle_support();
    
    // fridge border leverage
    translate([-x_dim/2,-y_dim/2+bm_y,z_dim+bm_z/2]) cube([x_dim,1.5,bm_z/2]);
    //%translate([-x_dim/2,-3*y_dim/4-h2m_d,0]) cube([x_dim,h2m_d,z_dim+2*bm_z]);
    
    
    
}

handle();
