use <../solidpp/cubepp.scad>
use <../solidpp/modifiers/modifiers.scad>

wi = 38.6;
de = 19.0;
he = 2.0;

difference(){
cubepp([wi, de, he], center=true);

text("M2x8", valign="center", halign="baseline");
    }