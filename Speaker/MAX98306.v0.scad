//
// Adafruit MAX98306 3.7W Stereo Amplifier Board Enclosure
//
// by Yasuhiro Wabiko
// This is licensed under the Creative Commons - Attribution license.
//

use <prim.scad>

// printer error related tweaks
//
// Recommended values:
//   - For Wood PLA, LID_ERROR = 0.8, HOLD_ERROR=0.
//   - For PLA, LID_ERROR= 0.0. HOLD_ERROR=0.4.
LID_ERROR  = 0.2; // if the lid does not fit, make this larger. 0.1-0.4 too small
//HOLD_ERROR = 0.4; // if the board holder is too loose, make this larger. 0.4 or 0.6

// global mode switches

// inner size of the box.
// typically, (x,y) = board size, z depends on how much space you need for cabling.
//
size_x = 24+0.1;
size_y = 28+0.1;
size_z = 10;

// shell dimensions
shell_thick = 1; // thickness
shell_r     = 1; // radius in minkowski transform

// board parameters
board_thick      = 2;      // board thickness, typically 2mm
arm_thick        = 1.5;    // arm thickness (overhang)
arm_up_z         = 2;      // arm upper part height (in z-axis)
arm_low_z        = 2;      // arm upper part height (in z-axis)
arm_center_up_y  = size_y; // arm (center) upper part height
arm_center_low_y = size_y; // arm (center) lower part height
arm_left_up_x    = size_x; // arm (left) upper part height
arm_left_low_x   = size_x; // arm (left) lower part height
arm_right_up_x   = 6;      // arm (right) upper part height
arm_right_low_x  = size_x; // arm (right) lower part height
arm_r            = 0.4;    // radius in minkowski transform

// lid dimensions
lid_outer_x = 1;
lid_inner_x = 2;

// misc design parameters
spfn_small  = 8;
spfn_medium = 16;
spfn_large  = 64;
lid_inner_thick = 2;

// internal parameters
WELDING = 0.6;
SHELL_LID_DIST = 4; // distance between shell and lid when print_ready_layout

//
// top level logic
//
max98306(with_vent=1, with_shell=1, with_lid=1, with_arm=1, with_open_roof=0, with_print=1);

// -------------------------
// Public Modules
// -------------------------

// [Public]
// Minimum size enclosure.
//
// with_vent = { 1: with ventilation slits, 0: without ventilation slits }
// with_shell = { 1: render the shell (outermost enclosure that matches the requested dimension). 0: does not render the shell.}
// with_lid  = { 1: render the lid, 0: does not render the lid }
// with_arm  = { 1: render the arm to support the board, 0: does not render the support }
// with_open_roof = { 1: make a big opening on the 'roof' part (for debugging), 0: do not do that }
// with_print = { 1: print layout (models are rotated to be printable), 0: edit layout (no rotation) }
module max98306(with_vent=1, with_shell=1, with_lid=1, with_arm=1, with_open_roof=0, with_print=1){

    if (with_print) {
        rotate([0,-90,0])
            translate([size_x/2+shell_thick+lid_inner_x/2, 0, 0])
            max98306_body(with_vent=with_vent, with_shell=with_shell, with_arm=with_arm, with_open_roof=with_open_roof);
        if (with_lid) {
            translate([size_z+shell_thick*2+SHELL_LID_DIST,0,0])
                rotate([0,90,0])
                max98306_lid(size_x, size_y, size_z, shell_r, shell_thick,
                             spfn_small, spfn_medium, spfn_large);
        }
    } else {
        translate([-size_x/2-shell_thick-6, 0, 0])
            max98306_body(with_vent=with_vent, with_shell=with_shell, with_arm=with_arm, with_open_roof=with_open_roof);
        if (with_lid) {
            max98306_lid(size_x, size_y, size_z, shell_r, shell_thick,
                         spfn_small, spfn_medium, spfn_large);
            }
    }
}

module max98306_unit(ox=40, with_vent=1, with_lid=1, with_arm=1, with_open_roof=0, with_print=1){
    bx = size_x + shell_thick*2 + lid_inner_x; // body x
    sx = ox - bx; // support x
    sy = size_y + shell_thick*2; // body y
    translate([-bx/2+ox,0,0])
    difference(){
        union() {
            max98306_shell(size_x, size_y, size_z, shell_r, shell_thick,
                           spfn_small, spfn_medium, spfn_large, with_shell=0, with_arm=with_arm, with_open_roof=with_open_roof);
            translate([-bx/2-sx/2+WELDING/2,0,0]) {
                prim_round_xplate0(sx+WELDING, sy, size_z, 1, 32);
            }
        }
        max98306_shell_negative_volume(size_x, size_y, size_z, shell_r, shell_thick,
                                       spfn_small, spfn_medium, spfn_large, with_vent=with_vent);
    }
    
}

module max98306_body(with_vent=1, with_shell=1, with_arm=1, with_open_roof=0){
    if (with_shell){
        difference(){
//    translate([0,0,-size_z/2-shell_thick])
            max98306_shell(size_x, size_y, size_z, shell_r, shell_thick,
                           spfn_small, spfn_medium, spfn_large, with_shell=with_shell, with_arm=with_arm, with_open_roof=with_open_roof);
            max98306_shell_negative_volume(size_x, size_y, size_z, shell_r, shell_thick,
                                           spfn_small, spfn_medium, spfn_large, with_vent=with_vent);
        }
    }
}

module max98306_lid(sx, sy, sz, wr, wt,
                      fns, fnm, fnl){
    translate([-lid_outer_x, 0, 0])
    difference(){
        max98306_lid_body(sx, sy, sz, wr, wt,
                          fns, fnm, fnl);
        translate([lid_outer_x/2,0,0]) // centering to match with positive volume
            max98306_lid_negative_volume(sx, sy, sz, wr, wt,
                                         fns, fnm, fnl);
    }
}

module max98306_lid_body(sx, sy, sz, wr, wt,
                      fns, fnm, fnl){

    // inner
    translate([-lid_inner_x/2,0,0])
    difference(){
        prim_round_xplate(lid_inner_x, sy-LID_ERROR, sz-LID_ERROR, wr, fnm);
        translate([-WELDING, 0, 0])
            prim_round_xplate(lid_inner_x+WELDING*2, sy-wt-LID_ERROR, sz-wt-LID_ERROR, wr, fnm);
    }    

    // outer
    translate([lid_outer_x/2,0,0])
        prim_round_xplate(lid_outer_x, sy+wt*2, sz+wt*2, wr, fnm);

}

module max98306_lid_negative_volume(sx, sy, sz, wr, wt,
                                    fns, fnm, fnl){
    // speaker out
    for (i=[-1,1]) {
        translate([0,i*(sy*0.2),3.1])
            #prim_round_xplate(lid_outer_x+WELDING*2, 4, 2.2, wr, fnm);
    }    

    // power in 
    translate([0,-(sy*0.3),0])
        #prim_round_xplate(lid_outer_x+WELDING*2, 2.54*2, 2.2, wr, fnm);

    // audio in
    translate([0,+(sy*0.1),0])
        #prim_round_xplate(lid_outer_x+WELDING*2, 2.54*3, 2.2, wr, fnm);
 }

module max98306_shell_negative_volume(sx, sy, sz, wr, wt,
                                      fns, fnm, fnl, with_vent=1){
    if (with_vent){
        for (i=[-2:1:2]) {
            translate([0, i*4,])
                #prim_round_zplate0(sx-4, 2, sz+wt+2, 1, fnm);
                }
        for (i=[0.5, -0.5]) {
            translate([0, 0, i*4])
            #prim_round_yplate0(sx-4, sy+wt+2, 2, 1, fnm);
        }

    }
    
}

module max98306_shell(sx, sy, sz, wr, wt,
                      fns, fnm, fnl, with_shell=1, with_arm=1, with_open_roof=0){
    if (with_shell) {
        translate([0,0,0])
            difference(){
            prim_round_xplate(sx+wt*2+lid_inner_x, sy+wt*2, sz+wt*2, wr, fnm);
            translate([wt, 0, 0])
                prim_round_xplate(sx+wt*2+lid_inner_x, sy, sz+10*with_open_roof, wr, fnm);
        }
    }

    if (with_arm){
    
        // arm lower
        // center
        translate([-sx/2-wt-WELDING, -WELDING/2, -sz/2-WELDING])
            prim_round_cube(arm_thick+WELDING, arm_center_low_y+WELDING*2, arm_low_z+WELDING, arm_r, fns);

        // left
        translate([-wt, -sy/2-WELDING, -sz/2-WELDING])
            rotate([0,0,90])
            prim_round_cube(arm_thick+WELDING, arm_left_low_x+WELDING*2-lid_inner_thick, arm_low_z+WELDING, arm_r, fns);

        // right
        translate([-wt, sy/2+WELDING, -sz/2-WELDING])
            rotate([0,0,-90])
            prim_round_cube(arm_thick+WELDING, arm_right_low_x+WELDING*2-lid_inner_thick, arm_low_z+WELDING, arm_r, fns);

        // arm upper
        // ceneter
        translate([-sx/2-wt-WELDING, -WELDING/2, -sz/2+arm_low_z+board_thick])
            prim_round_cube(arm_thick+WELDING, arm_center_up_y+WELDING*2, arm_up_z, arm_r, fns);

        // left
        translate([-wt, -sy/2-WELDING, -sz/2+arm_low_z+board_thick])
            rotate([0,0,90])
            prim_round_cube(arm_thick+WELDING, arm_left_up_x+WELDING*2-lid_inner_thick, arm_up_z, arm_r, fns);

        // right
        translate([-sx/2-wt+arm_right_up_x/2+WELDING*2, sy/2+WELDING, -sz/2+arm_low_z+board_thick])
            rotate([0,0,-90])
            prim_round_cube(arm_thick+WELDING, arm_right_up_x+WELDING*2, arm_up_z, arm_r, fns);
    }
}
