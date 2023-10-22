include<../../solidpp/solidpp.scad>

// adapter parameters
adapter_width = 45;
adapter_length = 110;
adapter_h = 12;
adapter_H = 16.4;
adapter_rail_w = 5;
adapter_bottom_off = 20;
adapter_top_off = 15;

// cable parameters
cable_H = 6;
cable_D = 7 + 0.5;
cable_d = 4;
cable_w = 12 + 0.5;
cable_t = 6 + 0.5;

// ethernet parameters
ethernet_connector_w = 11.5;
ethernet_connector_t = 8;
ethernet_front_offset = 4;
ethernet_d = 3.5;

// holder paramters
wt = 2;

// cable hook paramteters
cable_hook_h = 5;
cable_hook_off = 32;
cable_hook_H = cable_hook_h + cable_hook_off;


module cable_hook()
{
    difference()
    {
        _d = 2*wt + ethernet_d;

        union()
        {
            cylinderpp(d=_d, h=cable_hook_h, align="yz");
            cubepp([_d, _d/2, cable_hook_h], align="yz");
        }
        translate([0,_d/2,0])
            cylinderpp(d=ethernet_d, h=3*cable_hook_h, align="");
        translate([0,_d/2,0])
            cubepp([ethernet_d,_d,3*cable_hook_h], align="y");
    }
}

module shaft_hook()
{

}


module body()
{
    _x = 2*wt + adapter_width;
    _y = 2*wt + adapter_H;
    _z = wt + adapter_length + cable_hook_H;
    _h_off = (adapter_H-adapter_h)/2;
    _r = _h_off;

    difference()
    {
        // main geometry
        mod_list = [round_edges(r=_r)];
        size = [_x,_y,_z];
        cubepp(size, mod_list=mod_list, align="yz");

        // thin adapter hole
        translate([0,wt+_h_off,wt])
            cubepp([adapter_width, adapter_h, _z], align="yz");
        
        // thick adapter hole
        translate([0,wt,wt])
            cubepp([adapter_width-2*adapter_rail_w, adapter_H, _z], align="yz");

        // connector holes
        translate([0,wt+_h_off,wt+adapter_bottom_off])
            cubepp([2*_x,adapter_h, adapter_length - adapter_bottom_off - adapter_top_off], align="yz");
        
        // usb c cable hole
        translate([0,_y/2,0])
        {
            cubepp([cable_w, cable_t, 3*wt], align="");
            cylinderpp(d=cable_D, h=3*wt, align="");
        }

        // top cut
        translate([0,wt,wt+adapter_length])
            cubepp([2*_x,_y,_z], align="yz");


    }
}

module adapter_holder()
{
    // main body
    body();

    // cable hook
    translate([0,wt,wt+adapter_length+cable_hook_off])
        cable_hook();

    // lower shaft hook

    // upper shaft hook

}

adapter_holder();