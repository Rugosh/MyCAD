// Params
finger_size = 10;
thickness = 3;

height = 175;
width = 75;

show_debug = false;
debug_offset = 1;

// Spacing between parts
spacing = thickness * 2 + 1;

// Front
ejection_slot_height = 30;
front_offset = 4 * finger_size;

// Ramp params & calculation
ramp_angle = 45;
ramp_width = 50;
ramp_a = width*tan(ramp_angle);
ramp_correction = thickness*tan(ramp_a);

bottom_angle = 30;
bottom_a = width*tan(bottom_angle);
bottom_correction = thickness*tan(bottom_a);
bottom_c = sqrt(bottom_a*bottom_a + width*width) - bottom_correction;

module Front(){
    translate([0,ejection_slot_height,0]){
        square([width, height - ejection_slot_height]);
    }

    // Left Fingers
    rotate([0,0,90]){
        FingerRow(height, front_offset);
    }

    // Right Fingers
    translate([thickness + width,0,0]){
        rotate([0,0,90]){
            FingerRow(height, front_offset);
        }
    }
}

// Side Module
module Side() {
    // DEBUG INFOS
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
            // Left Line
            translate([0,0,0]){
                rotate([0,0,90]){
                    FingerRow(height, finger_size);
                }
            }
            
            // Right Line
            translate([width + thickness,0,0]){
                rotate([0,0,90]){
                    FingerRow(height, front_offset - finger_size);
                }
            }
            
            // Bottom Finger Line
            translate([width,0,0]){
                rotate([0,0,180]){
                    FingerRow(width, finger_size);
                }
            }
        }
        // Top Ramp
        translate([0, height-ramp_correction, 0]){
            rotate([0,0,-ramp_angle]){
                FingerRow(ramp_width);
            }
        }
        
        // Middle Ramp
        translate([width - ramp_width*cos(ramp_angle), height * 0.4, 0]){
            rotate([0, 0, ramp_angle]){
                FingerRow(ramp_width);
            }
        }
        
        // Bottom Ramp Holder
        translate([0, bottom_a, 0]){
            rotate([0,0,-bottom_angle]){
                FingerRow(bottom_c);
            }
        }
    }
}

// Bottom ramp
module BottomRamp(){
    square([bottom_c, width]);
    translate([0,-thickness,0]){
        FingerRow(bottom_c);
    }
    translate([0,width,0]){
        FingerRow(bottom_c);
    }
}

// Ramp
module Ramp(){
    rotate([0,0,90]){
        square([ramp_width, width]);
        translate([0,-thickness,0]){
            FingerRow(ramp_width);
        }
        translate([0,width,0]){
            FingerRow(ramp_width);
        }
    }
}

// Backsite
module Back(){
    square([width, height]);
    rotate([0,0,90]){
        FingerRow(height, 0);
    }
    
    translate([width + thickness,0,0]){
        rotate([0,0,90]){
            FingerRow(height, 0);
        }
    }
    translate([0,thickness * -1,0]){
        FingerRow(width, finger_size);
    }
}

// Bottom
module Bottom(){
    square([width, width]);
    // Mount for the left side
    translate([0,width,0]){
        FingerRow(width);
    }
    
    // Mount for the right side
    translate([0,-thickness,0]){
        FingerRow(width);
    }
    
    // Mount for the back
    translate([width +thickness ,0,0]){
        rotate([0,0,90]){
            FingerRow(width);
        }
    }
}

// >>> Set Parts
Front();

// Left Site
translate([(width + spacing) * -1, 0, 0]){
    Side();
}

// Right Site
translate([(width * 2 + spacing), 0, 0]){
    rotate([0,180,0]){
        Side();
    }
}

// Back
translate([width * 2 + spacing * 2,0,0]){
    Back();
}

// Bottom
translate([width + spacing, (width + spacing) * -1, 0]){
    Bottom();
}

// Bottom Ramp
translate([(bottom_c + spacing) * -1, (width + spacing) * -1, 0]){
    BottomRamp();
}

// Ramps
translate([width, -ramp_width - spacing + ejection_slot_height, 0]){
    Ramp();
}

translate([width,(-ramp_width - spacing) * 2 + ejection_slot_height,0]){
    Ramp();
}
// <<< Set Parts


// >>> Helper
module FingerRow(row_length, insertion = 0){
    for(i = [insertion: finger_size * 2: row_length]){
        translate([i, 0, 0]){
            if(i + finger_size > row_length){
                square([row_length - i, thickness]);
            } else {
                square([finger_size, thickness]);
            }
        }
    }
}

// <<< Helper