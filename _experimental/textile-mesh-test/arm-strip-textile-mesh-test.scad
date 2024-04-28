include<../solidpp/solidpp.scad>

x = 6;
y = 3;
z = 1.2;

$fn = 60;

off = 2;
n_strips = 15;

module strip()
{
    _x = x - y;

    _size = [_x, y, z];
    _align = "";
    cubepp(_size, align=_align);

    mirrorpp([1,0,0],true)
        transform_to_spp(size = _size, align = _align, pos = "x")
            cylinderpp(d=y, h=z, align=_align);

}

module strip_row(n)
{

    for (i=[0:n])
    {
        _off = i*(x+off);
        translate([_off,0,0])
            strip();    
    }
}

//strip_row(n_strips);

x_o = x + off;
y_o = y + off;

for (i=[-1:1])
{
    _y = i*y_o;
    _x = i % 2 == 0 ? x_o/2 : 0;
    translate([_x, _y, 0])
        strip_row(n_strips);
}

