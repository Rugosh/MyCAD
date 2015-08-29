include <Properties.scad>;

//CableHolder();

module CableHolder(){
    linear_extrude(height = cable_stand_width){
        CableHolderSideView();
    }
}

module CableHolderSideView(){
    rotate([0,0,180])
        difference(){
            CableHolderSideViewBase();
            circle(cable_diameter/2, $fn=resulution);
            translate([-1.25, 0, 0])
                square([3, 3], false);
        }
}

module CableHolderSideViewBase(){
    circle(cable_holder_diameter/2,  $fn=resulution);
    translate([cable_diameter/2, 0, 0])
        square([cable_stand_thikness, stand_thikness + cable_holder_diameter/2], false);
}