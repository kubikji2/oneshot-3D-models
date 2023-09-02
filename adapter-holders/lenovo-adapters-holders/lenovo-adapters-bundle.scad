include<adapter-legion.scad>
include<adapter-usb-c-65W.scad>
include<adapter-lenovo-65W.scad>

module curve(h,r)
{
    difference()
    {
        cubepp([r,r,h]);
        cylinderpp(r=r,h=3*h, align="xy");
    }
}

module adapter_bundle()
{
    // adding legion holder
    holder_lgn();

    // left adapter
    _len_trans = [  (lgn_h - w65_h_l)/2,
                    (lgn_t + w65_t_l)/2+lgn_wt,
                    -(lgn_l - w65_l_l)/2];
    translate(_len_trans)
    {
        // holder
        holder_65w_lenovo(has_hooks=false);

        // connector
        transform_to_spp(size=h_65w_size_l,align="",pos="Xyz")
            cubepp(size=[w65_wt_c,w65_wt_c,h_65w_z_l], align="Xyz");
        
        // inner curve
        transform_to_spp(size=h_65w_size_l-[0,2*lgn_wt,0],align="",pos="xyz")
            rotate([0,0,90])
                curve(r=w65_wt_l,h=h_65w_z_l);
    }
    // right adapter
    _usb_trans = [  (lgn_h - w65_h_c)/2,
                    -(lgn_t + w65_t_c)/2-lgn_wt,
                    -(lgn_l - w65_l_c)/2];
    
    translate(_usb_trans)
    {
        // holder
        holder_65w_usb_c(has_hooks=false);
        
        // connector
        transform_to_spp(size=h_65w_size_c,align="",pos="XYz")
            cubepp(size=[w65_wt_c,w65_wt_c,h_65w_z_c], align="XYz");

        // inner curve
        transform_to_spp(size=h_65w_size_c-[0,2*lgn_wt,0],align="",pos="xYz")
            rotate([0,0,180])
                curve(r=w65_wt_c,h=h_65w_z_c);
    }

}

adapter_bundle();


