// hose diameter
hose_diameter = 25.33; // 25.66, 25.5

//echo(PI*hose_diameter-25*PI);

// number of segments
n_segments = 6; // [1:1:10]

// segment smaller radius
segment_radius = 23;

// segment width
segment_width = 5;

// hose clamp segment diameter
clamp_diameter = 23;

// hose clamp segment width
clamp_width = 10;

// which segment is clamp segment
clamp_segment_ordinals = [1,3];

//assert(clamp_segment_ordinals < n_segments, str("clamp segment ordinal cannot be greater than number of segments"));

$fn = $preview ? 30 : 120;


// regular (conical) segment
module _regular_segment()
{
    cylinder(d1=hose_diameter, d2=segment_radius, h=segment_width);
}


// segment for the hose clamp
module _clamp_segment()
{
    cylinder(d=clamp_diameter, h=clamp_width);
}


// main module
module hose_plug(idx=0, z_off=0)
{

    difference()
    {
        union()
        {
            // ending recursion
            if (idx < n_segments)
            {
                // is current index a clamp
                is_clamp = len(search(idx, clamp_segment_ordinals));

                // translate this current segment  
                translate([0,0,z_off])
                    if(is_clamp)
                    {
                        // add clamp segment
                        _clamp_segment();
                    }
                    else
                    {
                        // add regular segment
                        _regular_segment();
                    }
                
                // recursive call
                hose_plug(idx=idx+1, z_off=z_off+ (is_clamp > 0 ? clamp_width : segment_width));
            }
        }

        // add hose diameter to the hose plug module
        translate([0,0,-0.01])
            linear_extrude(0.21)
                rotate([0,180])
                    text(text=str(hose_diameter), valign="center", halign="center", size = 5);
    }
}

hose_plug();