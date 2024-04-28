$fn = 100;

module box(l=200,d=20,h=100,t=5)
{
   
    a = l-2*d;
    h_ = h-t;
    a_ = a-t;
    d_ = d -t;
    difference()
    {
        //base
        hull()
        {
            cylinder(d=d,h=h);
            translate([a,0,0]) cylinder(d=d,h=h);
            translate([a,a,0]) cylinder(d=d,h=h);
            translate([0,a,0]) cylinder(d=d,h=h);
        }
        
        //cut
        translate([t/2,t/2,t+0.01])
        hull()
        {
            cylinder(d=d_,h=h_);
            translate([a_,0,0]) cylinder(d=d_,h=h_);
            translate([a_,a_,0]) cylinder(d=d_,h=h_);
            translate([0,a_,0]) cylinder(d=d_,h=h_);            
        }
        
    }
}

module cover(l=210, d=20, h=25, t=4)
{
    a = l-2*d;
    h_ = h-t;
    a_ = a-t;
    d_ = d -t;
    
    difference()
    {
        //base
        hull()
        {
            cylinder(d=d,h=h);
            translate([a,0,0]) cylinder(d=d,h=h);
            translate([a,a,0]) cylinder(d=d,h=h);
            translate([0,a,0]) cylinder(d=d,h=h);
        }
        
        //cut
        translate([t/2,t/2,-0.01])
        hull()
        {
            cylinder(d=d_,h=h_);
            translate([a_,0,0]) cylinder(d=d_,h=h_);
            translate([a_,a_,0]) cylinder(d=d_,h=h_);
            translate([0,a_,0]) cylinder(d=d_,h=h_);            
        }
        
        d_l = l;
        //cross diagonal
        #translate([l/2-d,l/2-d,1.5*t])
            hull(){
                translate([0.075*d_l,0.275*d_l,h/2]) cylinder(d=d/2,h=h/2);
                translate([0.075*d_l,-0.275*d_l,h/2]) cylinder(d=d/2,h=h/2);
                translate([-0.075*d_l,-0.275*d_l,h/2]) cylinder(d=d/2,h=h/2);
                translate([-0.075*d_l,0.275*d_l,h/2]) cylinder(d=d/2,h=h/2);
            }           
        
        //cross vertical
        #translate([l/2-d,l/2-d,1.5*t])
            hull(){
                translate([0.275*d_l,0.075*d_l,h/2]) cylinder(d=d/2,h=h/2);
                translate([0.275*d_l,-0.075*d_l,h/2]) cylinder(d=d/2,h=h/2);
                translate([-0.275*d_l,-0.075*d_l,h/2]) cylinder(d=d/2,h=h/2);
                translate([-0.275*d_l,0.075*d_l,h/2]) cylinder(d=d/2,h=h/2);
            }
    }
    
}

module cross(l=210,d=20,t=4){
    //cut
    a = l-2*d;
    a_ = a-t -1;
    d_ = d -t;
    translate([t/2,t/2,-0.01])
    hull()
    {
        cylinder(d=d_,h=t/2);
        translate([a_,0,0]) cylinder(d=d_,h=t/2);
        translate([a_,a_,0]) cylinder(d=d_,h=t/2);
        translate([0,a_,0]) cylinder(d=d_,h=t/2);            
    }
    
    d_l = l-1;
    //cross diagonal
    translate([l/2-d,l/2-d,0])
        hull(){
            translate([0.075*d_l,0.275*d_l,t/2]) cylinder(d=d/2,h=t);
            translate([0.075*d_l,-0.275*d_l,t/2]) cylinder(d=d/2,h=t);
            translate([-0.075*d_l,-0.275*d_l,t/2]) cylinder(d=d/2,h=t);
            translate([-0.075*d_l,0.275*d_l,t/2]) cylinder(d=d/2,h=t);
        }           
        
    //cross vertical
    translate([l/2-d,l/2-d,0])
        hull(){
            translate([0.275*d_l,0.075*d_l,t/2]) cylinder(d=d/2,h=t);
            translate([0.275*d_l,-0.075*d_l,t/2]) cylinder(d=d/2,h=t);
            translate([-0.275*d_l,-0.075*d_l,t/2]) cylinder(d=d/2,h=t);
            translate([-0.275*d_l,0.075*d_l,t/2]) cylinder(d=d/2,h=t);
        }
}

//box();

//translate([-5,-5,100-20])
//%cover();
cross();