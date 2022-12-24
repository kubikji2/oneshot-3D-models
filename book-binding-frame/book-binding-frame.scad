// GENERAL parameters
clearance = 0.25;
A4_w = 297;
eps = 0.01;

// SPIKE parameters
sp_th = 2;
// '-> spike tip head hight
sp_td = 1.5;
// '-> spike tip head diameter
sp_d = 2;
// '-> spike diameter

// PLANCHET parameters
pl_x = A4_w/2;
pl_y = 15;
pl_z = 2;

// HOLE parameters
hl_off = 5;
// '-> hole offset
hl_g = 10;
// '-> hole guage

// base dimensions
wt = 2;
bt = 2;

module base()
{
    _x = pl_x + clearance + wt;
    _y = pl_y + clearance + wt;
    _z = pl_z + bt + sp_th;

    difference()
    {
        cube([_x,_y,_z]);

        translate([wt, -wt, bt])
            cube([_x,_y,_z]);

    }
}

base();


$fn = 60;

module planchet()
{
    difference()
    {
        cube([pl_x, pl_y, pl_z]);

        for(i=[0:round((pl_x-hl_off)/hl_g)])
        {
            _x_off = hl_off + i*hl_g;
            _y_off = pl_y - hl_off;
            _h = pl_z+2*eps;
            translate([_x_off,_y_off,-eps])
                cylinder(d=sp_d,h=_h);
        }
    }
}

translate([wt+clearance, 0, bt+sp_th])
    planchet();