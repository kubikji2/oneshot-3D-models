// PRUSA iteration4
// Einsy doors
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use<Einsy-doors-original.scad>

ext_h = 5;

fan_wt = 2;
fan_h = 5;

module body()
{

    body_h = 16 + ext_h;
    // side panels
    cube([105.5,87.5,1.5]);  
    // anti-hinge
    cube([105.5,2,body_h]);  
    // top panel
    cube([2,87.5,body_h]);   
    // hinge side
    translate([26.5,82.5,0]) cube([73,5,ext_h]); 

    // corner reinforcement
    translate([98,1,0]) cube([7.5,5,body_h]);   
    translate([0.5,0.5,0]) cube([5,6.5,body_h]);  
    // top reinforcement
    translate([1,0,0]) cube([10,87.5,6+ext_h]);   
    // bottom reinfocement
    translate([99.5,0,0]) cube([6,87.5,7+ext_h]); 
    // 
    translate([10,0,0]) cube([6,5,6+ext_h]);   

    // screw thread body
    translate([54,2,0]) cube([9.5,6,body_h]); 

    // rounded side
    translate([0,87.5,4.5+ext_h]) rotate([0,90,0]) cylinder( h=105.5, r=4.5, $fn=30);

    // upper hinge reinforcement
    //#translate([0.5,69,-9]) rotate([20,0,0]) cube([26,20,10]); 
    translate([0.5,69,0])
    difference()
    {
        cube([26,18.5,12]);
        translate([-1,0,0])
        rotate([39,0,0])
            cube([28,28.5,12]);
    }
    // door closing
    translate([4,3.5,12.8+ext_h]) rotate([0,0,0]) cylinder( h=3.2, r1=1.8, r2=3.5, $fn=30);  
    translate([102,3.5,12.8+ext_h]) rotate([0,0,0]) cylinder( h=3.2, r1=1.8, r2=3.5, $fn=30); 

    // fan holder
    translate([9,22,1])
        cube([50+2*fan_wt, 50+2*fan_wt,fan_h]);
    
}

module ventilation_holes()
    {
    for ( i = [0 : 9] )
    {
        translate([40 + (i*6),10.5,-1]) cube([3.65,19+50,1.2]);
        translate([40 + (i*6),10.5,-1]) cube([3.65,19,2.5]);
        translate([40 + (i*6),10.5+25,-1]) cube([3.65,19,2.5]);
        translate([40 + (i*6),10.5+50,-1]) cube([3.65,19,2.5]);
    }
    for ( i = [-4:0] )
    {
        //translate([40 + (i*6),10.5,-1]) cube([3.65,19+50,1.2]);
        translate([40 + (i*6),10.5,-1]) cube([3.65,19+50,1.2]);
        translate([40 + (i*6),10.5,-1]) cube([3.65,19,2.5]);
        translate([40 + (i*6),10.5+25,-1]) cube([3.65,19,2.5]);
        translate([40 + (i*6),10.5+50,-1]) cube([3.65,13,2.5]);
    }
    for ( i = [-7 : -6] )
    {
      translate([46 + (i*6),20.5,-1]) cube([3.65,19+40,1.2]);
    }
    
    //translate([15,10,1]) cube([20,55,1.5]);  
}

module cutouts()
{
    // door closing screw
    // locking bolt
    translate([58.5,4,1]) cylinder( h = 17+ext_h, r = 1.8, $fn=30);  
    // bolt interface extension
    translate([58.5,4,14.5+ext_h]) cylinder( h = 2.6, r1 = 1.8, r2=2.2, $fn=30); 
    
    translate([58.5,4,11.5+ext_h])
    {
        translate([0,0,2.5]) cube([5.7,3.8,1], center=true);
        translate([0,0,3]) cube([3.8,3.8,1], center=true);
    }

    ventilation_holes();
    
    // rounded side cutoff    
    translate([26.5,87.5,4.5+ext_h]) rotate([0,90,0]) cylinder( h = 73, r = 3.5, $fn=30);   
    translate([26.5,80,5]) cube([73,19,10]); 
    translate([26.5,82.5,1+ext_h]) cube([73,5,10]); 
    
    // upper hinge cut
    translate([0,60,-10]) cube([30,30,10]);  
    translate([-1,87.5,0]) cube([22.5,10,10]); 

    // upper hinge 
    translate([2,80,6]) cube([19.5,10+ext_h,10]);       
    translate([-2,89.7-6,3+ext_h]) rotate([-20,0,0]) cube([19.5,10,12]);     
    translate([-5,87.5,4.5+ext_h]) rotate([0,90,0]) cylinder( h = 26.5, r = 2.5, $fn=30);  

    // hinge hole
    translate([-5,87.5,4.5+ext_h]) rotate([0,90,0]) cylinder( h = 120, r = 2.6, $fn=30);  

    // door closing 
    translate([4,3.5,12.9+ext_h]) rotate([0,0,0]) cylinder( h = 3.2, r1 = 1.2, r2= 2.8, $fn=30);  
    translate([102,3.5,12.9+ext_h]) rotate([0,0,0]) cylinder( h = 3.2, r1 = 1.2, r2= 2.8, $fn=30);  

    // M3 nut
    translate([55.65,0.5,12+ext_h]) cube([5.7,10,2.2]);  

    // side panel lightning slot
    translate([2,10,3+ext_h] ) cube([7,65,5]);  
    translate([101,10,3+ext_h] ) cube([3,70,5]);  

    // corners - cut
    translate([53,3,1.5]) rotate([0,0,70]) cube([10,10,50]);  
    translate([61,12,1.5]) rotate([0,0,-70]) cube([10,10,50]);  
    translate([16,2,1.5]) rotate([0,0,45]) cube([5,5,50]);  

    translate([9,22,1.5])
        translate([fan_wt,fan_wt,0])
            cube([50,50,2*fan_h]);

}


module fan_holder()
{


    difference()
    {
        cube([50+2*fan_wt, 50+2*fan_wt,fan_h]);
        translate([fan_wt,fan_wt,-fan_h/2])
            cube([50,50,2*fan_h]);
    }

}

module Einsy_doors_new()
{
    difference()
    {
        body();
        cutouts();
        // large corner cut
        translate( [0 , -20, -3] ) rotate([0,45,45]) cube( [ 30, 30 , 20 ] );  

        translate([30,79,1]) rotate([0,0,-90]) linear_extrude(height = 0.8) 
        { text("R1",font = "helvetica:style=Bold", size=6, halign="center", valign="center"); }    

        //translate([9+25+2,22+25+2,-1])
        //    cylinder(d=50,h=10);
    }
#translate([9,22,1])
        fan_holder();   
}

Einsy_doors_new();

//translate([0,0,ext_h])
//%Einsy_doors_original();
