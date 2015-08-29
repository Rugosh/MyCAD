include <Properties.scad>;
use <CableHolder.scad>;
use <HeadPhoneHolder.scad>;


rotate([90,0,0]){
    HeadPhoneHolder();

    translate([-15, 25, (stand_width ) /2])
        rotate([0,90,0]){
            CableHolder();
        }
}