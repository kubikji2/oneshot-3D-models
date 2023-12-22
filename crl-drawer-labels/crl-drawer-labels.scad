// open with commandline via 
// openscad -o test.stl -D 'param="M2x10"' crl-drawer-labels.scad

use <../solidpp/cubepp.scad>
use <../solidpp/modifiers/modifiers.scad>

// param="text_";
label="?????";

$fn = 60;
wi = 38.6;
de = 18.0;
he = 1;
r_corners = 1;
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
multicolor(is_text)
{
    // children(0)
    mod_list=[round_edges(r=r_corners, axes="xy")];
    cubepp([wi, de, he], align="Z", mod_list=mod_list);
    
    // children(1)
    translate([0,0,-label_h])
    linear_extrude(height = (is_text ? 1 : 2)*label_h)
    {
        text(   label, valign="center", halign="center", 
                font="Liberation Mono:style=Regular",
                size=wi/len(label));
    }
}
