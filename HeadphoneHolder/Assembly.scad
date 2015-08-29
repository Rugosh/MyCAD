include <Properties.scad>;
include <CableHolder.scad>;
include <HeadPhoneHolder.scad>;


HeadPhoneHolder();
//CableHolder();

translate([-15, 25, (stand_width ) /2])
    rotate([0,90,0]){
        CableHolder();
    }