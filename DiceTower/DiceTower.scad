// TODO
// - Ramps

// Params
finger_size = 10;
thickness = 3;

height = 140;
width = 7 * finger_size; // Funktioneirt für alle ungeraden Vielfachen von finger_size

show_debug = false;
debug_offset = 1;

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

// Ramp params & calculation
ramp_angle = 45;
ramp_width = 50;
ramp_a = width*tan(ramp_angle);
ramp_correction = thickness*tan(ramp_a);

bottom_angle = 30;
bottom_a = width*tan(bottom_angle);
bottom_correction = thickness*tan(bottom_a);
bottom_c = sqrt(bottom_a*bottom_a + width*width) - bottom_correction;

// Side Module
module side() {
    if(show_debug){
        color("LightGreen"){
            // Top Ramp
            translate([0, height-ramp_correction, debug_offset]){
                rotate([0,0,-ramp_angle]){
                    square([ramp_width, thickness]);
                }
            }
            
            // Middle Ramp
            translate([width - ramp_width*cos(ramp_angle), height * 0.4, debug_offset]){
                rotate([0, 0, ramp_angle]){
                    square([ramp_width, thickness]);
                }
            }
            
            // Bottom Ramp
            translate([0, bottom_a, debug_offset]){
                rotate([0,0,-bottom_angle]){
                    square([bottom_c, thickness]);
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
                translate([width, i, 0]){
                    square([thickness, finger_size]);
                }
            }
            for(i = [finger_size: finger_size * 2: width - finger_size]){
                translate([i,thickness * -1,0]){
                    square([finger_size, thickness]);
                }
            }
        }
        // Top Ramp
        translate([0, height-ramp_correction, 0]){
            rotate([0,0,-ramp_angle]){
                for(i = [0: finger_size * 2: ramp_width]){
                    translate([i, 0, 0]){
                        square([finger_size, thickness]);
                    }
                }
            }
        }
        
        // Middle Ramp
        translate([width - ramp_width*cos(ramp_angle), height * 0.4, 0]){
            rotate([0, 0, ramp_angle]){
                for(i = [0: finger_size * 2: ramp_width]){
                    translate([i, 0, 0]){
                        square([finger_size, thickness]);
                    }
                }
            }
        }
        
        // Bottom Ramp Holder
        translate([0, bottom_a, 0]){
            rotate([0,0,-bottom_angle]){
                for(i = [0: finger_size * 2: bottom_c]){
                    translate([i, 0, 0]){
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
    square([bottom_c, width]);
    for(i = [0:finger_size * 2:bottom_c]){
        translate([i,-thickness,0]){
            square([finger_size, thickness]);
        }
        translate([i,width,0]){
            square([finger_size, thickness]);
        }
    }
}

// Ramp
module Ramp(){
    square(ramp_width, width);
    for(i = [0:finger_size * 2:ramp_width]){
        translate([i,-thickness,0]){
            square([finger_size, thickness]);
        }
        translate([i,ramp_width,0]){
            square([finger_size, thickness]);
        }
    }
}
translate([spacing,-ramp_width - thickness, 0]){
    Ramp();
}

translate([width * 2 + spacing * 2, -ramp_width - thickness - spacing, 0]){
    Ramp();
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