use<../../lib/solidpp/solidpp.scad>
use<../../lib/deez-nuts/deez-nuts.scad>

include<item-20-dimensions.scad>

module item_20_hole(height, groove_depth=item20_d/2, clearance=0.2)
{
    _a = item20_a + 2*clearance;
    _h = height + clearance;
    _w = item20_w - 2*clearance;

    translate([0,0,-clearance])
        difference()
        {
            
            // main body
            cubepp([_a, _a, height], align="z");

            // side grooves
            mirrorpp([-1,1,0], true)   
                mirrorpp([1,1,0], true)
                    translate([_a/2+clearance,0,0])
                        cubepp([groove_depth, _w, 3*_h], align="X");   

        }


}

