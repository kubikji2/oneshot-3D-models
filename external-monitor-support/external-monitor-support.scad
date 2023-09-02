use <../solidpp/cubepp.scad>
use <../solidpp/cylinderpp.scad>
use <../solidpp/spherepp.scad>
use <../solidpp/transforms/replicate.scad>

// hook parameters
h_w = 12;
// '-> witdt
h_wt = 4;
// '-> wall thickness
h_l = 120;
// '-> total length
h_fo = 20;
// '-> front offset
h_to = 20;
// '-> top offset

// monitor paramters
m_t = 16;
m_T = 26;
m_h = 8;
m_off = 50;
m_f_off = 15;
m_ang = 75;

$fn=60;

module hullify(p1,p2)
{
        hull()
    {
        replicate_at([p1, p2])
            cylinderpp(d=h_wt,h=h_w,zet="x", align="");
    }
}

module external_monitor_support_right()
{

    front_point = [0, -m_f_off-h_wt/2, 0];
    back_point  = [0, h_l -m_f_off - h_wt, 0];

    hullify(front_point, back_point);

    _l = h_l-h_wt;
    _a = -90+m_ang;
    top_point = [0, _l*sin(-_a), _l*cos(-_a) ];


    // main support
    hullify([0,0,0], top_point);

    // main support support
    hullify(top_point, back_point);

    _hook_offset = [0,0, m_off-h_wt];
    __h = _hook_offset[2] + 2.5*h_wt;
    ___h = -m_T + m_t - h_wt;
    _m = -m_T-h_wt;
    _hf = front_point + [0,0,52];  //[0, __h*sin(-_a), __h*cos(-_a)] + [0,___h*cos(-_a),___h*sin(-_a)];
    echo(_hf);
    hullify(front_point, _hf);


    rotate([_a, 0, 0])
    {
        translate(_hook_offset)
        {
            hook_front_point = [0, -m_T-h_wt, 0];
            hook_front_top_point = [0, -m_T-h_wt, m_h+h_wt];
            hook_back_point = [0, -m_t-h_wt, m_h+h_wt];
            hook_back_top_point = [0, -m_t-h_wt, m_h+h_wt+h_to];
            // front
            hullify([0,0,0], hook_front_point);
            // up
            hullify(hook_front_point, hook_front_top_point);
            // back
            hullify(hook_front_top_point, hook_back_point);
            // up
            hullify(hook_back_point, hook_back_top_point);

            %translate([0,-h_wt/2,h_wt/2])
            {
                cubepp([h_w, m_T, m_h], align="Yz");
                cubepp([h_w, m_t, m_h+h_to], align="Yz");
            }

        }
    }



}

//external_monitor_support_right();

module external_monitor_support_left()
{

    front_point = [0, -m_f_off-h_wt/2, 0];
    back_point  = [0, h_l -m_f_off - h_wt, 0];

    hullify(front_point, back_point);

    _l = h_l-h_wt;
    _a = -90+m_ang;
    top_point = [0, _l*sin(-_a), _l*cos(-_a) ];


    // main support
    hullify([0,0,0], top_point);

    // main support support
    hullify(top_point, back_point);

    _hook_offset = [0,0, m_off-h_wt];
    __h = _hook_offset[2] + 2.5*h_wt;
    ___h = -m_T + m_t - h_wt;
    _m = -m_T-h_wt;
    _hf = front_point + [0,0,52];  //[0, __h*sin(-_a), __h*cos(-_a)] + [0,___h*cos(-_a),___h*sin(-_a)];
    echo(_hf);
    hullify(front_point, _hf);


    rotate([_a, 0, 0])
    {
        translate(_hook_offset)
        {
            hook_front_point = [0, -m_T-h_wt, 0];
            hook_front_top_point = [0, -m_T-h_wt, m_h+h_wt+h_to];
            

            _h = h_l - m_off;
            hook_back_point = [0, 0, m_h+h_wt];
            hook_back_top_point = [0, 0, _h ];
            hook_middle_point = [0, -m_t+3*h_wt/2, m_h+h_wt];
            hook_middle_top_point = [0, -m_t+3*h_wt/2, m_h+h_wt+_h];

            // front
            hullify([0,0,0], hook_front_point);
            // up
            hullify(hook_front_point, hook_front_top_point);
            // middle
            hullify(hook_back_point, hook_middle_point);
            // middle to top
            hullify(hook_middle_point, hook_middle_top_point);
            // middle top to back
            hullify(hook_middle_top_point, hook_back_top_point);

            // back
            //hullify(hook_front_top_point, hook_back_point);
            // up
            //hullify(hook_back_point, hook_back_top_point);

            %translate([0,-h_wt/2,h_wt/2])
            {
                cubepp([h_w, m_T, m_h], align="Yz");
                translate([0,m_t-m_T,0])
                    cubepp([h_w, m_t, m_h+h_to], align="Yz");
            }

        }
    }



}

external_monitor_support_left();
