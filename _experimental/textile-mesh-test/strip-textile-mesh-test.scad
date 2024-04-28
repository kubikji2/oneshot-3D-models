include<../solidpp/solidpp.scad>

x = 2;
y = 15;
z = 2;

$fn = 60;

off = 2;
n = 15;

module strip()
{
    _y = y - x;

    _size = [x, _y, z];
    _align = "";
    cubepp(_size, align=_align);

    mirrorpp([0,1,0],true)
        transform_to_spp(size = _size, align = _align, pos = "y")
            cylinderpp(d=x, h=z, align=_align);

}

for (i=[0:n])
{
    _off = i*(x+off);
    translate([_off,0,0])
        strip();    
}


