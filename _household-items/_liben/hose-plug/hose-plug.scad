// hose diameter
hose_diameter = 25;

// number of segments
n_segments = 5; // [1:1:10]

// segment smaller radius
segment_radius = 23;

// segment width
segment_width = 5;

// hose clamp segment diameter
clamp_diameter = 23;

// hose clamp segment width
clamp_width = 10;

// which segment is clamp segment
clamp_segment_ordinal = 2;

assert(clamp_segment_ordinal < n_segments, str("clamp segment ordinal cannot be greater than number of segments"));


$fn = $preview ? 30 : 120;

module _regular_segment()
{
    cylinder(d1=hose_diameter, d2=segment_radius, h=segment_width);
}


module _clamp_segment()
{
    cylinder(d=clamp_diameter, h=clamp_width);
}


module hose_plug()
{
    // lower segment
    for(i=[1:n_segments])
    {
        z_off = (i-(i<=clamp_segment_ordinal ? 1 : 2))*segment_width + (i>clamp_segment_ordinal ? 1 : 0)*clamp_width;

        translate([0,0,z_off])
            if(i==clamp_segment_ordinal)
            {
                _clamp_segment();
            }
            else
            {
                _regular_segment();
            }
    }
}

hose_plug();