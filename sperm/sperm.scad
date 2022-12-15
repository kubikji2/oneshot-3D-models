
r = 20;
d = 2*r;
xf = 1.5;
cf = 0.25;

module head()
{

    difference()
    {
        scale([xf,1,1])
            sphere(r=r);
        translate([-xf*r, -r, -r])
        cube([xf*d, d, d*cf]);
    }
    
}
head();

