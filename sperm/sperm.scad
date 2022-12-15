
r = 20;
d = 2*r;
xf = 1.5;
cf = 0.25;

module head()
{
    scale([xf,1,1])
            sphere(r=r, $fn=60);
}

function dump_sine(x, A_max=4, p=10, d=-0.1) = A_max*exp(d*x)*cos(x*360/p);

q = 1;
t_off = 20+2.5;
t_r = 5;
x_s = 1/t_r;
tl = 20*t_r;
module tail()
{
    for(i=[0:round(q*tl)])
    {
        x = (1/q)*i;
        y = r*dump_sine(x_s*x+t_off);
        s = (round(q*tl)-i)/(round(q*tl))*0.5 + 0.5;

        translate([x,y,0])
            sphere(r=s*t_r,$fn=40);
    }
}

module sperm()
{
    head();
    translate([xf*r,0,0])
        tail();
}

sperm();