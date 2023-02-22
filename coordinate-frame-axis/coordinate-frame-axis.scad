// parameters
l = 100;
// '-> axis length
a = 10;
// '-> axis width

module single_axis()
{
    // shaft cross-section points e.g. the interaface prism and point bases
    base_points =
        [
            [0,0,0],
            [0,a,0],
            [a,a,0],
            [a,0,0]
        ];
    
    // faces (facetes) of the four-sided pyramid
    // '-> bases corners are at indexes 0:3, 4 is the top
    faces =
        [
            [0,1,2,3],
            [4,1,0],
            [4,2,1],
            [4,3,2],
            [4,0,3]
        ];
    
    // interface prism top point
    interace_point = [0,0,a];
    // interaface prism points bases on 0:3, top point at 4
    _interface_points = [ for (_p=base_points) _p, interace_point];

    // pointy prism top point
    pointy_point = [a/2,a/2,-a/sqrt(2)];
    // pointy prism points bases on 0:3, top point at 4
    _pointy_points = [ for (_p=base_points) _p, pointy_point];


    // interface prism
    polyhedron(points = _interface_points, faces = faces);   

    // main shaft
    translate([0,0,-l])
        cube([a,a,l]);
    
    // point
    translate([0,0,-l])
        polyhedron(points = _pointy_points, faces = faces);   

}

//single_axis();

include<../solidpp/cubepp_mods/bevel_corners_cubepp.scad>
// '-> including the cubepp without the corners

tol = 0.15;
// '-> tight fit tolerance
wt = 4;
// '-> wall thickness

module origin()
{
    _a = a + 2*tol;
    _A = a + 2*wt;
    difference()
    {
        // main cube
        translate([-wt,-wt,-wt])
            bevel_corners_cubepp([_A,_A,_A], cut=_A/3);

        // x-axis cut
        translate([-tol, -tol, -tol])
        {
            // x-axis cut
            cube([l,_a,_a]);

            // y-axis cut
            cube([_a,l,_a]);

            // z-axis cut
            cube([_a,_a,l]);
        }
    }

}

origin();