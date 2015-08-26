resulution = 100;

stand_thikness = 3;
stand_width = 20;
stand_depth = 30;

headphone_widht = 25;
headphone_heigth = 9;

table_width = 22;
table_stand_height = 50;
table_plate_support_insert = 12;
table_plate_support_height = 40;

cable_diameter = 3.5;
cable_holder_diameter = 6;


//HeadPhoneHolder();
HeadPhoneHolder();

module HeadPhoneHolder(){
    linear_extrude(height = stand_width){
        HeadPhoneHolderSideView();
    }
    
    translate([-15, 13.5, (stand_width ) /2])
        rotate([0,90,0]){
            CableHolder();
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

module CableHolder(){
    linear_extrude(height = 5){
        CableHolderSideView();
    }
}

module CableHolderSideView(){
    rotate([0,0,90])
    difference(){
        circle(cable_holder_diameter/2,  $fn=resulution);
        circle(cable_diameter/2, $fn=resulution);
        translate([-2, 0, 0])
            square(3, 3);
    }
}