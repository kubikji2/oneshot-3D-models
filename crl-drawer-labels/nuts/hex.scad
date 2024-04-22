// open with commandline via 
// openscad -o test.stl -D 'param="M2x10"' crl-drawer-labels.scad

use <../../solidpp/cubepp.scad>
use <../../solidpp/modifiers/modifiers.scad>

// param="text_";
symbol = "\u2B22       ";
label="  M2.5";
spec = "thin";
//echo(xlabel);

$fn = 60;
wi = 38.6;
de = 18.0;
he = 1.6;
r_corners = 3;
label_h = 0.6;

is_text = false;

// module for easy part selection
module multicolor(is_child_only)
{
    
    if (is_child_only)
    {
        children(1);
    }
    else
    {
        difference()
        {
            children(0);
            children(1);
        }            
    }
}


// main
rotate([0, 180, 0]){
multicolor(is_text)
{
    mod_list=[round_edges(r=r_corners, axes="xy")];
    eps = 0.1;
    w = wi+eps;
    d = de+eps;
    h = he+eps;
    // children(0)
    difference(){
    //cube([wi, de, he], center=true);
    cubepp([wi, de, he], align="Z", mod_list=mod_list);
    #polyhedron(
        points = [
        [w/2, d/2, -h],
        [-w/2, d/2, -h], 
        [w/2, -d/2, -h], 
        [-w/2, -d/2, -h], 
        [w/2, -d/2, -1.2], 
        [-w/2, -d/2, -1.2]], 
        faces=[
        [0, 2, 4],
        [5, 3, 1],
        [0, 4, 5, 1],
        [4, 2, 3, 5],
        [0, 1, 3, 2]
        ], 
        convexity = 1
        );
    }
    
    // children(1)
    size = 28/6;
    _off = is_text ? 0 : 0.1;
    //l = (len(llabel)-1);
    translate([0,0,-label_h])
    linear_extrude(height = (is_text ? 1 : 2)*label_h)
        offset(_off)
        {
            translate([0, 1]){
            text(symbol, valign="bottom", halign="center", 
                font="DejaVu Sans:style=Bold",
                    size=size);
            } //"Liberation Mono:style=Bold"
            
            translate([0, 1]){
            text(label, valign="bottom", halign="center", 
                font="Liberation Mono:style=Bold",
                    size=size);
            }
            
            translate([0, -1]){
                    text(spec, valign="top", halign="center", 
                    font="Liberation Mono:style=Bold",
                    size=size);
            }
            //translate([-((l/2)-1)*28/l, 0])circlepp(size=[28/l, 28/l],align="center", $fn = 6);
            //echo(len(label));
        }
}
}
