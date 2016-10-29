use <../prim.scad>

board_x = 42;
board_y = 33;
board_z = 2;

arm_below_z = 2;
arm_lo_z = 2;
arm_up_z = 2;
arm_above_z = 8;
arm_left_t = 1;
arm_right_t = 1;
arm_front_t = 0;

stuff_x = board_x;
stuff_y = board_y;
stuff_z = board_z+arm_lo_z+arm_up_z+arm_below_z+arm_above_z;

holder_wall_t = 1;
holder_x = stuff_x + holder_wall_t;
holder_y = stuff_y + holder_wall_t*2;
holder_z = stuff_z + holder_wall_t*2;
holder_bottom_cutouts=[[8,10,4],[8,-10,4]];
holder_front_cutouts = [[6, 3.8], [-6, 3.8]];

audiojack_r = 3.8;

WELDING=0.1;

newcase1_main(target="default");

function front_center(sx, tx) = [-sx/2+tx/2, 0, 0];
function left_center(sy, ty)  = [0, -sy/2+ty/2, 0];
function right_center(sy, ty) = [0, sy/2-ty/2, 0];
function top_center(sz, tz) = [0, 0, sz/2-tz/2];
function bottom_center(sz, tz) = [0, 0, -sz/2+tz/2];

module caller_hook() {
    echo("this is caller_hook");}

// bbox: (x,y,z) = (same as board_x, same as board_y, board_z + space above*below it)
module newcase1_main(target="default"){

    newcase1_holder(holder_y=36, with_round=1);
    newcase1_arm(with_welding=1);
}

module newcase1_arm(with_welding=1, left_cut_outs=[], right_cutouts=[]) {
// x,y-center of model = center of board
    // z-center of model = center of board space (i.e. board thickness + space above and below board)
    dx = with_welding*WELDING;
    dy = with_welding*WELDING;
    dz = with_welding*WELDING;

    translate([-dx/2, 0, 0]) {
        difference() {
            cube([stuff_x+dx, stuff_y+dy, stuff_z+dz], center=true);
            union() {
                translate([arm_front_t, arm_left_t/2-arm_right_t/2, 0]) {
                    cube([board_x+WELDING, board_y-arm_left_t-arm_right_t, stuff_z*2], center=true);
                }
                translate([0, 0, -holder_z/2+arm_below_z+arm_lo_z+board_z/2]) {
                    #cube([board_x+WELDING, board_y+WELDING, board_z], center=true);
                }

                // left cut out
                translate(left_center(board_y, arm_left_t)) {
                    #cube([1, arm_left_t+WELDING,10], center=true);
                }

                // right cut out
                translate(right_center(board_y, arm_right_t)) {
                    #cube([1, arm_right_t+WELDING,10], center=true);
                }

                // top (above-arm) cut out
                translate(top_center(stuff_z, 0)) {
                    #cube([stuff_x+dx, stuff_y+dy, arm_above_z*2], center=true);
                }
                
            }
        }
    }
}

module newcase1_holder(holder_x=holder_x, holder_y=holder_y,
                       front_cutouts=holder_front_cutouts,
                       bottom_cutouts=holder_bottom_cutouts,
                       with_open_roof=0, with_open_bottom=0, with_round=0, with_round_innder=1) {
    
    translate([-holder_wall_t/2,0,0]) {
        difference() {
            union() {
                if (with_round) {
                    prim_round_xplate0(holder_x, holder_y, holder_z, 1, 32);
                } else {
                    cube([holder_x, holder_y, holder_z], center=true);
                }
            }
            union() {
                translate([+holder_wall_t/2+WELDING/2,0,0]) {
                    if (with_round_innder) {
                        prim_round_xplate0(stuff_x+WELDING, stuff_y, stuff_z, 1, 32);
                    } else {
                        cube([stuff_x+WELDING, stuff_y, stuff_z], center=true);
                    }
                }

                if (with_open_roof) {
                    // open roof
                    translate(top_center(holder_z, holder_wall_t)) {
                        cube([holder_x*2, holder_y*2, holder_wall_t+WELDING], center=true);
                    }
                }
                if (with_open_bottom) {
                    // open bottom
                    translate(bottom_center(holder_z, holder_wall_t)) {
                        #cube([holder_x*2, holder_y*2, holder_wall_t+WELDING], center=true);
                    }
                }

                // front cut outs
                translate(front_center(board_x, arm_front_t+WELDING)) {
                    for (cutout=front_cutouts){
                        cpos_x = cutout[0];
                        cwidth = cutout[1];
                        cr = cutout[1];
                        translate([0, cpos_x, 0]) {
                            //#cube([arm_front_t+WELDING+WELDING, cwidth, 10], center=true);
                            rotate([0,90,0]) {
                                #cylinder(r=audiojack_r, h=cr, fn=16, center=true);
                            }
                        }
                    }
                }
                
                // bottom cut out
                translate(bottom_center(holder_z, holder_wall_t)) {
                    for (cutout=bottom_cutouts) {
                        pos_x = cutout[0];
                        pos_y = cutout[1];
                        width = cutout[2];
                        translate([holder_wall_t+pos_x/2,pos_y,0]){
                            #cube([holder_x-pos_x, width, holder_wall_t+WELDING], center=true);
                        }
                    }
                }
                
                
            }
        }
    }

}
