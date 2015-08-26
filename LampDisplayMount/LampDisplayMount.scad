resolution = 100;
Stand(30 / 2, 37 / 2, 5, 14 / 2, 40, resolution);

module Stand(diameterStand, diameterStandTop, 
    lenghtStandTop, diamenterLampMount, lenghtLampMount, resolution){
    difference() {
        StandBase(diameterStand, diameterStandTop, lenghtStandTop, lenghtLampMount, resolution);
        
        translate([0, 0, -1]){
            linear_extrude(height = lenghtLampMount +2, $fn=resolution){
                circle(diamenterLampMount);
            }
        }
    }
}

module StandBase(diameterStand, diameterStandTop, lenghtStandTop, lenghtLampMount, resolution){
    lenghtStand = lenghtLampMount - lenghtStandTop;
    
    color("white"){
        linear_extrude(height = lenghtLampMount - lenghtStandTop, $fn=resolution){
            circle(diameterStand);
        }

        translate([0, 0, lenghtStand]){
            linear_extrude(height = lenghtStandTop, $fn=resolution){
                circle(diameterStandTop);
            }
        }
    }
}