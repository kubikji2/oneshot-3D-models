// open with commandline via 
// openscad -o test.stl -D 'param="M2x10"' crl-drawer-labels.scad

use <../solidpp/cubepp.scad>
use <../solidpp/modifiers/modifiers.scad>

param="text_";
val=param;

wi = 38.6;
de = 19.0;
he = 1.5;

difference(){
cubepp([wi, de, he], center=true);

linear_extrude(height = 1.5){
text(val, valign="center",halign="center", font="Liberation Mono:style=Regular", size=wi/5);
    }
}