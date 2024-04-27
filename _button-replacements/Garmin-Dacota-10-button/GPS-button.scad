// basic parameters
$fn=180;

translate([1,1,0])
    minkowski()
    {
        cube([6,1,6]);
        cylinder();
    }

translate([0,0,6.5])
    minkowski()
{
        cube([8,3,0.5]);
        cylinder();
    }
    
 //% cube([8,3,7]);