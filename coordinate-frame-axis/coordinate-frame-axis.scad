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

single_axis();
