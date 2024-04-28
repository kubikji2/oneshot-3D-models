include<../solidpp/solidpp.scad>

x = 25;
y = 50;
z = 3;
wt = 2;
R = 5;
r = R - wt;

$fn=60;

difference()
{
    size_outer = [x,y,z];
    size_inner = size_outer - 2*[wt,wt,-z];

    ml_outer = [round_edges(r=R)];
    ml_inner = [round_edges(r=r)];

    cubepp(size_outer,mod_list=ml_outer, align="z");
    cubepp(size_inner,mod_list=ml_inner, align="");
}
