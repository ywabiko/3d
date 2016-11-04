//
// TinySine Bluetooth Audio Receiver Board Enclosure
//
// by Yasuhiro Wabiko
//
// This work is licensed under a Creative Commons Attribution 4.0 International License.
// https://creativecommons.org/licenses/by/4.0/
//

use <prim.scad>

board_x = 42+2; // including 3.5mm jack (2mm depth)
board_y = 33.4;
board_z = 2;

arm_below_z = 2+2;
arm_lo_z = 2;
arm_up_z = 2;
arm_above_z = 7; // 6 too small
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
holder_bottom_cutouts = [[14, 7.5, 4], [14, -7.5, 4]]; // bottom cable slits
holder_front_cutouts = [[10.5, 3], [-10.5, 3]]; // front 3.5mm jacks

lid_x = 2;
lid_inner_x = 2;
lid_inner_t = 1;

audiojack_r = 3.2;

WELDING=0.1;
print_rotation = [[0, 0, 0],[0, -90, 0]];

TARGET="default";

btaudio_main(target=TARGET);

function front_center(sx, tx) = [-sx/2+tx/2, 0, 0];
function back_center(sx, tx) = [sx/2, 0, 0];
function left_center(sy, ty)  = [0, -sy/2+ty/2, 0];
function right_center(sy, ty) = [0, sy/2-ty/2, 0];
function top_center(sz, tz) = [0, 0, sz/2-tz/2];
function bottom_center(sz, tz) = [0, 0, -sz/2+tz/2];
function board_surface_z(sz, tz) = [0, 0, -sz/2+tz];


// bbox: (x,y,z) = (same as board_x, same as board_y, board_z + space above*below it)
module btaudio_main(target="default"){

    if (target == "default") {
        with_print = 1;
        rotate(print_rotation[with_print]) {
            translate([stuff_x/2+holder_wall_t,0,0]){
                btaudio_holder(holder_y=36, holder_x=45, with_round=1, with_hole_front=1, with_hole_bottom=0, with_screw=0);
                btaudio_arm(with_welding=1);
            }
        }
        
        translate([holder_z+4,0,0]) {
            rotate(print_rotation[with_print]) {
                btaudio_lid();
            }
        }
    }

    if (target == "unit_test") {
        with_print = 1;
        rotate(print_rotation[with_print]) {
            btaudio_unit();
        }
    }

    if (target == "unit_fit_test") {
        with_print = 1;
        rotate(print_rotation[with_print]) {
            difference() {
                union() {
                    btaudio_unit();
                }
                union() {
                    translate([-holder_x+14,0,0]) {
                        cube([holder_x,holder_y*2,holder_z*2], center=true);
                    }
                    translate([holder_x-29,0,0]) {
                        cube([holder_x,holder_y*2,holder_z*2], center=true);
                    }
                }
            }
        }
    }

    if (target == "screw_negative_test") {
        with_print = 1;
        rotate(print_rotation[with_print]) {
            btaudio_screw(volume_type="negative");
        }
    }

    if (target == "unit_lid_negative_test") {
        with_print =0;
        rotate(print_rotation[with_print]) {
            btaudio_unit_lid_negative_volume();
        }
    }

    if (target == "lid_test") {
        with_print = 1;
        rotate(print_rotation[with_print]) {
            btaudio_lid();
        }
    }
}

module btaudio_unit() {
    translate([-holder_x, 0, holder_z/2]) {
        rotate([0,0,180]) {
            translate([holder_wall_t/2-holder_x/2,0,0]) {
                rotate([180,0,0]) {
                    btaudio_holder(holder_y=36, holder_x=45, with_round=1, with_hole_front=0, with_hole_bottom=1, with_vent=0, with_screw=1);
                    btaudio_arm(with_welding=1);
                }
            }
        }
    }
}

module btaudio_unit_lid_negative_volume() {
    translate([0, 0, holder_z/2]) {
        rotate([0,0,180]) {
            translate([holder_wall_t/2-holder_x/2-2,0,0]) {
                rotate([180,0,0]) {
                    btaudio_holder(holder_y=36, holder_x=45, with_round=1, with_hole_front=0, with_hole_bottom=1, with_vent=0, with_screw=1);
                    btaudio_arm(with_welding=1, with_board_part=1);
                    scale([1.1,1,1])
                    btaudio_screw(volume_type="negative");

                    usb_z = 3;
                    usb_y = 8;
                    translate([board_x/2, 0, usb_z/2]) {
                        translate(board_surface_z(holder_z, board_z+arm_below_z+arm_lo_z)) {
                            #prim_round_xplate(holder_wall_t*6, usb_y, usb_z, 1, 16);
                        }
                    }
                    
                }
            }
        }
    }
}

module btaudio_arm(with_welding=1, left_cut_outs=[], right_cutouts=[],
                    with_cutout_left=0, with_cutout_right=0, with_board_part=0) {
// x,y-center of model = center of board
    // z-center of model = center of board space (i.e. board thickness + space above and below board)
    dx = with_welding*WELDING;
    dy = with_welding*WELDING;
    dz = with_welding*WELDING;

    translate([-dx/2, 0, 0]) {
        // materialize board space if required (this is used to remove this volume from lid)
        if (with_board_part) {
            translate([0, 0, -holder_z/2+arm_below_z+arm_lo_z+board_z/2]) {
                #cube([board_x+WELDING, board_y+WELDING, board_z+WELDING], center=true);
            }
        }
        difference() {
            union() {
                cube([stuff_x+dx, stuff_y+dy, stuff_z+dz], center=true);

            }
            union() {
                translate([arm_front_t, arm_left_t/2-arm_right_t/2, 0]) {
                    cube([board_x+WELDING, board_y-arm_left_t-arm_right_t, stuff_z*2], center=true);
                }
                // cut board space
                translate([0, 0, -holder_z/2+arm_below_z+arm_lo_z+board_z/2]) {
                    #cube([board_x+WELDING+10, board_y+WELDING, board_z], center=true);
                }

                // left cut out
                if (with_cutout_left) {
                translate(left_center(board_y, arm_left_t)) {
                    #cube([1, arm_left_t+WELDING,10], center=true);
                }
                }

                // right cut out
                if (with_cutout_right) {
                translate(right_center(board_y, arm_right_t)) {
                    #cube([1, arm_right_t+WELDING,10], center=true);
                }
                }

                // top (above-arm) cut out
                translate(top_center(stuff_z, 0)) {
                    #cube([stuff_x+dx, stuff_y+dy, arm_above_z*2], center=true);
                }
                
            }
        }
    }
}


// with_round = { 1: round the corners of holder's outer surface, 0: sharp (normal cube) edge. }
// with_round_inner = { 1: round the corners of holder's inner surface, 0: sharp (normal cube) edge. }
module btaudio_holder(holder_x=holder_x, holder_y=holder_y,
                      front_cutouts=holder_front_cutouts,
                      bottom_cutouts=holder_bottom_cutouts,
                      with_screw=0,
                      with_hole_front=1,
                      with_hole_bottom=1,
                      with_vent=1,
                      with_vent_top=1,
                      with_vent_bottom=1,
                      with_vent_side=1,
                      with_open_roof=0, with_open_bottom=0, with_round=0, with_round_innder=1) {

    holder_wall_ty = (holder_y - stuff_y)/2;
    holder_wall_tz = (holder_z - stuff_z)/2;
    holder_wall_tx = (holder_x - stuff_x)/2;
    
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

                if (with_screw) {
                    #btaudio_screw(volume_type="negative");
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
                if (with_hole_front) {
                    translate(front_center(board_x, arm_front_t+WELDING)) {
                        translate(board_surface_z(holder_z, board_z+arm_below_z+arm_lo_z-1)) {
                            for (cutout=front_cutouts){
                                cpos_x = cutout[0];
                                cr = cutout[1];
                                translate([0, cpos_x, audiojack_r]) {
                                    //#cube([arm_front_t+WELDING+WELDING, cwidth, 10], center=true);
                                    rotate([0,90,0]) {
                                        #cylinder(r=audiojack_r, h=cr, $fn=16, center=true);
                                    }
                                }
                            }
                        }
                    }
                }
                
                // bottom cut out
                if (with_hole_bottom) {
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

                // vent
                if (with_vent) {
                    // top vent
                    if (with_vent_top) {
                        translate(top_center(holder_z, holder_wall_tz)) {
                            for (iy=[-3, -2, -1, 0, 1, 2, 3]) {
                                translate([0, iy*4, 0]) {
                                    prim_round_zplate0(holder_x*0.7, 2, holder_wall_tz*2, 1, 16);
                                }
                            }
                        }
                    }
                    // bottom vent
                    if (with_vent_bottom) {
                        translate(bottom_center(holder_z, holder_wall_tz)) {
                            for (iy=[-3, -2, -1, 0, 1, 2, 3]) {
                                translate([0, iy*4, 0]) {
                                    prim_round_zplate0(holder_x*0.7, 2, holder_wall_tz*2, 1, 16);
                                }
                            }
                        }
                    }
                    // side vent
                    if (with_vent_side) {
                        for (vp=[left_center(holder_y, holder_wall_ty),
                                 right_center(holder_y, holder_wall_ty)]) {
                            translate(vp) {
                                for (iz=[0.5, 1.5]) {
                                    translate([0, 0, iz*4]) {
                                        #prim_round_yplate0(holder_x*0.7, holder_wall_ty*2, 2, 1, 16);
                                    }
                                }
                            }
                        }
                    }
                }
            } // union
        } // difference
        if (with_screw) {
            btaudio_screw(volume_type="positive");
        }
    } // translate
}

module btaudio_screw(volume_type="positive") {
    holder_wall_ty = (holder_y - stuff_y)/2;
    holder_wall_tz = (holder_z - stuff_z)/2;
    holder_wall_tx = (holder_x - stuff_x)/2;

    translate([holder_x/2,0, -holder_z/2+3]){
        for (vp=[left_center(holder_y, holder_wall_ty+4.5),
                 right_center(holder_y, holder_wall_ty+4.5)]) {
            translate(vp) {
                screw_hole_d2_h3(align="x", volume_type=volume_type,
                                 shell_x=6, shell_y=6, shell_z=holder_x-2, with_shell=1);
            }
        }
    }
}

module btaudio_lid(holder_x=holder_x, holder_y=holder_y,
                      front_cutouts=holder_front_cutouts,
                      bottom_cutouts=holder_bottom_cutouts,
                      with_screw=0,
                      with_hole_front=1,
                      with_hole_bottom=1,
                      with_vent=1,
                      with_vent_top=1,
                      with_vent_bottom=1,
                      with_vent_side=1,
                      with_welding = 1,
                      with_open_roof=0, with_open_bottom=0, with_round=0, with_round_innder=1) {

    holder_wall_ty = (holder_y - stuff_y)/2;
    holder_wall_tz = (holder_z - stuff_z)/2;
    holder_wall_tx = (holder_x - stuff_x)/2;
    dx = with_welding*WELDING;

    difference() {
        union() {
            translate([lid_x/2,0,0]) {
                prim_round_xplate0(lid_x, holder_y, holder_z, 1, 32);
                translate([lid_x/2+lid_inner_x/2,0,0]) {
                    difference() {
                        prim_round_xplate0(lid_inner_x+WELDING, holder_y-holder_wall_ty*2, holder_z-holder_wall_tz*2, 1, 32);
                        prim_round_xplate0(lid_inner_x+WELDING, holder_y-holder_wall_ty*2-lid_inner_t*2, holder_z-holder_wall_tz*2-lid_inner_t*2, 0.1, 32);
                    }
                }
            }
        }
        union() {
            translate([(stuff_x+dx)/2+lid_x,0, 0]) {
                btaudio_arm(with_welding=1,with_board_part=1);
            }

            usb_z = 3;
            usb_y = 8;
            translate([0, 0, usb_z/2]) {
                translate(board_surface_z(holder_z, board_z+arm_below_z+arm_lo_z)) {
                    #prim_round_xplate(holder_wall_t*6, usb_y, usb_z, 1, 16);
                }
            }
        }
    }
}
