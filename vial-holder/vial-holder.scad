// based on the previous model from:
// https://github.com/kubikji2/useful-models/tree/master
use <../../openscad-libraries/cubepp.scad>

eps = 0.01;
$fn = 45;

// base parameters
// hole numbers
n_x = 10;
n_y = 5;
//n_y = 1;
// borders
b_xy = 8;
// offsets
o_xy = 5.45;
// hole parameters
h_D = 13;
h_d = 12.4;
// diameter tolerance
h_dt = 0.2;
h_h = 15.5;

// base parameters
b_x = n_x*(h_D+o_xy)-o_xy+2*b_xy;
b_y = n_y*(h_D+o_xy)-o_xy+2*b_xy;
b_z = 21;
b_tol = 0.05;

// connection interface parameters
ci_o = 1;
ci_a = 6;
ci_h = 2;
ci_c = 1;
ci_t = 0.25;

// vial cap params
vc_d = 12;
vc_h = 3;

echo(b_x);
echo(b_y);

module vial_holder()
{   
    // interface positions
    i_p = [[ci_o,ci_o,0], [ci_o,b_y-ci_o-ci_a,0],[b_x-ci_o-ci_a,b_y-ci_o-ci_a,0],[b_x-ci_o-ci_a,ci_o,0]];

    difference()
    {
        cube([b_x,b_y,b_z]);

        for(i=[0:n_x-1])
        {
            for(j=[0:n_y-1])
            {
                _xo = b_xy+h_D/2+i*(h_D+o_xy);
                _yo = b_xy+h_D/2+j*(h_D+o_xy);
                // vial hole
                translate([_xo,_yo,b_z-h_h+eps])
                    cylinder(d2=h_D+b_tol,d1=h_d+b_tol,h=h_h);
                // vial cap hole
                translate([_xo,_yo,-eps])
                    cylinder(d=vc_d, h=vc_h);
            }
        }
        // add connectors to the bottom
        //i_po = [[-ci_t,-ci_t,0],[-ci_t,ci_t,0],[ci_t,ci_t,0],[ci_t,-ci_t,0]];
        i_po = [[-ci_t,-ci_t,0],[-ci_t,-ci_t,0],[-ci_t,-ci_t,0],[-ci_t,-ci_t,0]];

        translate([0,0,-eps])
        for(i=[0:len(i_po)-1])
        {
            _i_p = i_p[i];
            _i_po = i_po[i];
            translate(_i_p)
                translate(_i_po)
                    trapezoid([ci_a+2*ci_t,ci_a+2*ci_t,ci_h+ci_t], [[ci_c,ci_c],[ci_c,ci_c]]);
        }

        // horizontal label
        for(o=[0:n_x-1])
        {
            _t = o+1;
            translate([b_xy+h_D/2+o*(h_D+o_xy),b_xy/2,b_z-0.5+eps])
            {
                linear_extrude(height=0.5)
                    text(text=str(_t), size=5, font="Monospac821 BT:style=Bold",
                            halign="center",valign="center");
            }
            translate([b_xy+h_D/2+o*(h_D+o_xy),b_y-b_xy/2,b_z-0.5+eps])
            {
                linear_extrude(height=0.5)
                    text(text=str(_t), size=5, font="Monospac821 BT:style=Bold",
                            halign="center",valign="center");
            }
        }

        // vertical label
        y_l = ["A", "B", "C", "D", "E"];
        for(o=[0:n_y-1])
        {
            _t = y_l[n_y-1-o];
            translate([b_xy/2,b_xy+h_D/2+o*(h_D+o_xy),b_z-0.5+eps])
            {
                linear_extrude(height=0.5)
                    text(text=str(_t), size=5, font="Monospac821 BT:style=Bold",
                            halign="center",valign="center");
            }
            translate([b_x-b_xy/2,b_xy+h_D/2+o*(h_D+o_xy),b_z-0.5+eps])
            {
                linear_extrude(height=0.5)
                    text(text=str(_t), size=5, font="Monospac821 BT:style=Bold",
                            halign="center",valign="center");
            }
        }

        // nametag
        name = "Kourimsky";
        _depth = 0.5;
        translate([b_x/2,-eps+_depth,b_z/2])
        rotate([90,0,0])
        linear_extrude(height=_depth)
        {
            text(text=str(name), size=12, font="Monospac821 BT:style=Bold",
                            halign="center",valign="center");
        }

    }

    // add connectors to the top
    for(_p=i_p)
    {
        translate(_p)
            translate([0,0,b_z])
                trapezoid([ci_a,ci_a,ci_h], [[ci_c,ci_c],[ci_c,ci_c]]);
    }

    

    
}

vial_holder();