eps = 0.01;
$fn = 90;

// mobile parameters
m_x = 155;
m_y = 12;
m_z = 76;
// mobile corners
m_c = 5;
// mobile slat (CZ lista, rost)
m_sl = 5;
// mobile stripe
m_st = 10;

m_p = 25;
// cut size for repros and USB
m_ru = 55;

// support cut parameters
// notebook corner parameters
sc_cy = 4;
sc_cz = 9;
// display thickness
sc_dt = 8;
sc_sz = 22;

// general parameters
t = 3;
alpha = 60;


module support_box()
{
    mb_x = m_x + 2*t;
    mb_y = m_y + 2*t;
    mb_z = m_z + 3*t;
    
    difference()
    {
        union()
        {
            difference()
            {
                // main block
                cube([mb_x, mb_y, mb_z]);
                // mobile side cut
                translate([-eps,t,t]) cube([m_x+t+2*eps,m_y,m_z]);
                // cut for display
                translate([-eps,-eps,t+m_sl])
                    cube([m_x-m_c-m_st+t,m_y+t,m_z-2*m_sl]);
                
            }
        
        
            // support box
            translate([0, m_y+2*t, 0]) difference()
            {
                // main box
                cube([2*t+m_x, m_z+2*t, m_z+3*t]);
                // cutting display holes
                translate([-eps, sc_cy, -eps])
                    cube([2*t+m_x+2*eps, sc_dt, t+m_z+eps]);
                // cutting upper part for display holes
                translate([-eps, 0, t+m_z-sc_cz])
                    cube([2*t+m_x+2*eps, sc_cy+sc_dt, sc_cz]);
                // cutting lower part for diplay holes
                translate([-eps, 0, -eps])
                    cube([2*t+m_x+2*eps, sc_cy+sc_dt, t+m_z-sc_sz+eps]);
                
                // cutting skewed parts
                // lower cut
                cl = 4*t+2*m_z;
                translate([-eps, 0, 0]) rotate([-alpha,0,0])
                    cube([2*eps+2*t+m_x,cl,cl]);
                // upper cut
                translate([-eps, sc_cy+sc_dt+2*t, 3*t+m_z])
                    rotate([-alpha,0,0])
                        cube([2*eps+2*t+m_x,cl,cl]);
            }
        }
        
        
        // cut for buttons
        mc_y = mb_y+2*eps+m_x;
        translate([t+m_p,-eps,m_z+t-eps]) hull()
        {
            // main cut
            cube([m_x-2*m_p,mc_y,2*t+2*eps]);
            // skewed sides
            tmp_d = 0.1;
            #translate([-2*t,mc_y-eps,2*t+tmp_d])
                rotate([90,0,0]) cylinder(d=tmp_d, h=mc_y);
            translate([m_x-2*m_p+2*t,mc_y-eps,2*t+tmp_d])
                rotate([90,0,0]) cylinder(d=tmp_d, h=mc_y);
        }
        // cut for USB and repros
        translate([t+m_x-eps,-eps,t+(m_z-m_ru)/2])
        hull()
        {
            // main cut
            cube([t+2*eps,mc_y,m_ru]);
            // skewed sides
            tmp_d = 0.1;
            translate([tmp_d+t,mb_y+eps,-t])
                rotate([90,0,0]) cylinder(d=tmp_d, h=mc_y);
            translate([tmp_d+t,mb_y+eps,m_ru+t])
                rotate([90,0,0]) cylinder(d=tmp_d, h=mc_y);
        }
        
        // holes for lighter structure
        z_holes = 55;
        difference()
        {
            union()
            {
                translate([t,mb_y,t]) rotate([90-alpha,0,0])
                    cube([m_p-2*t,2*mb_x,z_holes]);
                translate([mb_x-m_p+t,mb_y,t]) rotate([90-alpha,0,0])
                    cube([m_p-3*t,2*mb_x,z_holes]);
                translate([t+m_p,mb_y,t]) rotate([90-alpha,0,0])
                    cube([mb_x-2*m_p-2*t,2*mb_x,z_holes-t]);
            }
            translate([0,sc_cy+sc_dt/2+mb_y-z_holes,0])
                cube([mb_x, z_holes, mb_z]);
            
        }
    }
}


support_box();



