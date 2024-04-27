

d = 8;
bh = 1;
h = 3;


$fn=$preview ? 30 : 120;

module button()
{
    intersection()
    {
        union()
        {
            cylinder(d=d,h=bh);
            resize([d-bh,d-bh,2*h])
                sphere(r=h);
        }

        
        cylinder(d=d, h=h);
    }
}

button();