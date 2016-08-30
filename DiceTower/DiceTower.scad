// TODO
// - Ramps

// Params
finger_size = 10;
thickness = 3;

angle = 30;

height = 140;
width = 7 * finger_size; // Funktioneirt für alle ungeraden Vielfachen von finger_size

show_debug = false;
debug_offset = -1;

// Spacing between parts
spacing = thickness * 2 + 1;

// Front
ejection_slot_height = 30;
translate([0,ejection_slot_height,0]){
    square([width, height - ejection_slot_height]);
}
front_offset = 4 * finger_size;
for(i = [front_offset:finger_size * 2:height - finger_size]){
    translate([thickness * -1,i,0]){
        square([thickness, finger_size]);
    }
    translate([width,i,0]){
        square([thickness, finger_size]);
    }
}

a = width*tan(angle);
substract = thickness*tan(30);
correction = thickness*tan(30);
c = sqrt(a*a + width*width) - correction;
module side() {
    if(show_debug){
        color("LightGreen"){
            translate([0, a, debug_offset]){
                rotate([0,0,-angle]){
                    square([c, thickness]);
                }
            }
        }
    }
    difference(){
        translate([0,0,0]){
            square([width, height]);
            for(i = [finger_size:finger_size * 2:height - finger_size]){
                translate([thickness * -1,i,0]){
                    square([thickness, finger_size]);
                }
            }
            for(i = [front_offset - finger_size:finger_size * 2:height - finger_size]){
                translate([width,i,0]){
                    square([thickness, finger_size]);
                }
            }
            for(i = [finger_size:finger_size * 2:width - finger_size]){
                translate([i,thickness * -1,0]){
                    square([finger_size, thickness]);
                }
            }
        }
        translate([0, a, 0]){
            rotate([0,0,-angle]){
                for(i = [0:finger_size * 2:c]){
                    translate([i,0,0]){
                        square([finger_size, thickness]);
                    }
                }
            }
        }
    }
}

// Left Site
translate([(width + spacing) * -1, 0, 0]){
    side();
}

// Right Site
translate([(width * 2 + spacing), 0, 0]){
    rotate([0,180,0]){
        side();
    }
}

// Bottom ramp
translate([(width + spacing) * -1, (width + spacing) * -1, 0]){
    square([c, width]);
    for(i = [0:finger_size * 2:c]){
        translate([i,-thickness,0]){
            square([finger_size, thickness]);
        }
        translate([i,width,0]){
            square([finger_size, thickness]);
        }
    }
}

// Backsite
translate([width * 2 + spacing * 2,0,0]){
    square([width, height]);
    for(i = [0:finger_size * 2:height - finger_size]){
        translate([thickness * -1,i,0]){
            square([thickness, finger_size]);
        }
        translate([width,i,0]){
            square([thickness, finger_size]);
        }
    }
    for(i = [finger_size:finger_size * 2:width - finger_size]){
        translate([i,thickness * -1,0]){
            square([finger_size, thickness]);
        }
    }
}

// Bottom
translate([width + spacing, (width + spacing) * -1, 0]){
    square([width, width]);
    for(i = [0:finger_size * 2:width]){
        translate([i,width,0]){
            square([finger_size, thickness]);
        }
    }
    
    for(i = [0:finger_size * 2:width]){
        translate([i,-thickness,0]){
            square([finger_size, thickness]);
        }
    }
    for(i = [0:finger_size * 2:width]){
        translate([width,i,0]){
            square([thickness, finger_size]);
        }
    }
}