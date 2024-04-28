include<../solidpp/solidpp.scad>

// CUSTOMIZABLE parameters

clrn = 0.2;
// '-> clearance

_D = 130 + 2*clrn;
// '-> thread outer diameter
_d = 127 - 2*clrn;
// '-> thread inner diameter
_top_t = 1.7 - 2*clrn;
// '-> thread top thickness
_bottom_t = 2.2 - 2*clrn;
// '-> thread bottom thickness
_pitch = 4.5;
// '-> thread pitch
//     NOTE: pitch = top_t + bottom_t + 2*sloped_off
_n = 3;
// '-> number of thread revolution

_cover_D = 134.5;
// '-> cover diameter
_cover_h = 18;
// '-> cover inner height
_cover_H = 20;
// '-> cover outer height

$fn = $preview ? 30 : 60;

// single thread segment
module segment(d, D, bottom_t, top_t, depth, angle, fn)
{

    // get points
    points = [  [d/2,  top_t/2],
                [d/2, -top_t/2],
                [D/2, -bottom_t/2],
                [D/2,  bottom_t/2]];
    // get segment angular length
    angular_length = 360/fn;

    // segment
    render(1)
    rotate([angle,0,0])
    difference()
    {
        // basic ring
        rotate([0,0,angular_length/2])
            rotate_extrude($fn=fn)
                polygon(points);
        
        // first cutting cube
        rotate([0,0,-angular_length/2])
            cubepp([D,D,D],align="Y");
        
        // second cutting cubepp
        rotate([0,0,angular_length/2])
            cubepp([D,D,D],align="y");
    }
}

// inner thread
module trapezoid_thread(pitch, top_t, bottom_t, d, D, n)
{
    _fn = $fn == 0 ? 30 : $fn;

    // get the depth
    _depth = (D - d)/2;

    // number of repetition
    _rep = floor(n*_fn);

    // difference in angle per each segment
    _dangle = (360/_fn);
    // difference in pitch per each segment
    _dpitch = _pitch/_fn;
    // length of each segmet
    _seg_l = (PI*d)/(_fn);
    // angle of rotation for each segment
    _seg_angle = asin(_dpitch/_seg_l);
    
    // generate thread
    for(i=[0:_rep-1])
    {
        _cur_a = i*_dangle;
        _cur_h = i*_dpitch;
        rotate([0,0,_cur_a])
            translate([0,0,_cur_h])
                segment(d=d, D=D, bottom_t=bottom_t, top_t=top_t, depth =_depth, angle=_seg_angle, fn=_fn);    
    }
}

module cover()
{   
    
    _dh = _cover_H-_cover_h;
    mod_list = [round_bases(r_bottom = _dh)];
    
    difference()
    {
        cylinderpp(h=_cover_H, d=_cover_D, mod_list=mod_list);
        translate([0,0,_dh])
            cylinderpp(h=_cover_H, d=_D);
    }

    // adding threads
    translate([0,0,_dh])    
        trapezoid_thread(pitch=_pitch, top_t=_top_t, bottom_t=_bottom_t, d=_d, D=_D, n=_n);

    // adding stumbs
    for(i=[0:$fn])
    {   
        rotate([0,0,i*(360/$fn)])
            translate([_cover_D/2,0,_dh])
                cylinder(h=_cover_h, d=_dh);
    }

}

cover();