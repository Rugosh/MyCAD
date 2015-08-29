include <Properties.scad>;

HeadPhoneHolder();

module HeadPhoneHolder(){
    difference(){
    linear_extrude(height = stand_width){
        HeadPhoneHolderSideView();
    }    
    translate([-15, headphone_heigth - 1, (stand_width / 2) + (cable_holder_diameter / 2)])
    rotate([0,90,0]){
        linear_extrude(height = cable_stand_width){
            square([cable_stand_thikness, cable_stand_width + 2], false);
        }
    }
}
}

module HeadPhoneHolderSideView(){
    // Auflage
    square([headphone_widht, stand_thikness], false);
    // Bügel
    translate([headphone_widht, 0, 0])
        square([stand_thikness, headphone_heigth + stand_thikness], false);
    
    // TischKantenstütze
    translate([-stand_thikness, -table_width + headphone_heigth + stand_thikness, 0])
        square([stand_thikness, table_width], false);
    
    // Table Plate Top
    translate([-stand_depth, headphone_heigth, 0])
        square([stand_depth, stand_thikness], false);
    
    // Table Plate Bottom
    translate([-table_plate_support_insert, - table_width + headphone_heigth, 0])
        square([table_plate_support_insert, stand_thikness], false);
    
    // Table Plate Support
    translate([-table_plate_support_insert, - table_width + headphone_heigth -table_plate_support_height + stand_thikness, 0])
        square([stand_thikness, table_plate_support_height], false);
        
    // Stabalize
    color("red")
    polygon(points=[
        [0,0],
        [0,- table_width + headphone_heigth],
        [-table_plate_support_insert + stand_thikness, - table_width + headphone_heigth],
        [-table_plate_support_insert + stand_thikness, -table_plate_support_height - table_width + headphone_heigth + stand_thikness],
        [headphone_widht + stand_thikness, 0]]);
}

