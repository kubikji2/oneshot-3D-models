include<../solidpp/solidpp.scad>

clrn = 0.3;

// bolt dimensions
bsl = 12;
// '-> bolt shaft length
bsd = 3;
// '-> bolt shaft diameter
bnh = 4;
// '-> bolt nut height
bnd = 5.4/cos(180/6);
// '-> bolt nut diameter
bhd = 5.5;
// '-> bolt head diameter
bhh = 1.8;
// '-> bolt head height
b_clrn = clrn;

// nut and bolt, aligned to the bottom
module nut_and_bolt()
{
    
    // nut
    translate([0,0,-b_clrn])
        cylinderpp(d=bnd+b_clrn, h=b_clrn+bnh+b_clrn, fn=6);
    // shaft
    cylinderpp(d=bsd+b_clrn, h=bsl+bhh);
    // head
    translate([0,0,bsl])
        cylinderpp(d=bhd+b_clrn, h=bhh+b_clrn);

}

//nut_and_bolt();

// interface
i_l = 10;
// '-> interface length
i_d = 10;
// '-> interface diameter
i_bt = 2;
// '-> interface bottom thickness
i_mt = 4;
// '-> interface middle thickness

module arm_interface(angle, is_arm=false)
{
    rotate([0,0,angle])
    {
        difference()
        {
            union()
            {
                cubepp([i_l-2*clrn,i_l/2+a_wt/2,c_h], align="yz");
                cylinderpp(d=i_d-2*clrn, h=c_h);
            }

            // bolt and nut hole
            nut_and_bolt();

            _A = 2*i_l;

            // remove the mass depending whether
            // interface is on the arm or the centra piece
            if(is_arm)
            {
                // lower cut
                cubepp([_A, _A, bnh + b_clrn + i_bt], align="z");

                // upper cut
                translate([0, 0, bnh + i_bt + i_mt + b_clrn])
                    cubepp([_A, _A, bsl], align="z");
            }
            else
            {
                translate([0, 0, bnh + i_bt])
                    cubepp([_A, _A, i_mt + 2*b_clrn], align="z");
            }
        }

    }
}

// body parameters
// bigger bomb parameters
b_Do = 122;
// '-> outer diameter
b_Di = 116;
// '-> inner diameter
b_WT = 3;
// '-> body wall thickness
b_WH = 4.5;
// '-> body wall height
b_WB = 2;
// '-> body wall border

// smaller bomb parameters
b_do = 103.5;
// '-> outer diameter
b_di = 98;
// '-> inner diameter
b_wt = 2.5;
// '-> body wall thickness
b_wh = 3.8;
// '-> body wall height
b_wb = 2;
// '-> body wall border

// arm parameters
a_l = 100;
// '-> arm length
a_wt = 5;
// '-> arm wall thickness
a_h = bsl+bhh;
// '-> arm height
a2i = [(i_l)/2,-(i_l+a_wt)/2,0];
// '-> transform from arm coordinte frame to the interface coordinate frame
a_off = 2;

module arm()
{
    difference()
    {
        // basic shape
        hull()
        {   
            translate([clrn,0,0])
                cylinderpp(d=a_wt, h=a_h, align="xz");
            
            translate([a_l,0,0])
                cylinderpp(d=a_wt, h=a_h, align="Xz");    
        }

        // hole for bigger the bomb body border
        translate([-c_R,0,a_h])
        {
            translate([0,0,-a_off])
                tubepp(d=b_Di-2*b_WB, D=b_Do, h=b_WH+clrn, align="Z");
            
            tubepp(d=b_Di-2*b_WB-clrn, D=b_Do-2*b_WB, h=b_WH+a_off+clrn, align="Z");            
        }
        
        // hole for smaller the bomb body border
        translate([-c_R,0,a_h])
        {
            translate([0,0,-a_off])
                tubepp(d=b_di-2*b_wb, D=b_do, h=b_wh+clrn, align="Z");
            
            tubepp(d=b_di-2*b_wb, D=b_do-2*b_wb, h=b_wh+a_off, align="Z");
            
            translate([0,0,clrn])
            difference()
            {
                cylinderpp(d=b_di-2*b_wb, h=b_wh+a_off+2*clrn, align="Z");
                //translate([0,0,clrn])
                cylinderpp(d1=b_di-2*b_wb, d2= b_di-2*b_wb-(b_wh+a_off), h=b_wh+a_off+2*clrn, align="Z");
            }          
        }
        

    }

    translate(a2i)
        arm_interface(0, is_arm=true);
}

// centeral piece parameters
c_R = 30;

c_wt = 5;

c_h = bsl+bhh;


$fn = $preview ? 30 : 60;

module hullify(points)
{
    for (i=[0:len(points)-1])
    {
        hull()
        {
            translate(points[i])
                children(0);
            translate(points[(i+1)% len(points)])
                children(0); 
        }
    }
}

module central_triangle()
{

    angles = [0,120,240];
    points = [for(angle=angles) each [rotate_2D_z([c_R-c_wt/2, -i_l], angle), rotate_2D_z([c_R-c_wt/2, i_l], angle)]];
    //echo(points);

    hullify(points)
        cylinder(d=c_wt, h=c_h);

    for(a=angles)
    {
        rotate([0,0,a])
            translate([c_R,0,0])
            {
                arm();
                
                translate(a2i)
                    arm_interface(90, is_arm=false);
            }
    }

    //%cylinder(r=c_R,h=c_h);

}

central_triangle();

