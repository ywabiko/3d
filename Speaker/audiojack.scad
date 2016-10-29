//
// Adafruit Breadboard Friendly 3.5mm Stereo Headphone Jack Enclosure
//
// by Yasuhiro Wabiko
//
// This work is licensed under a Creative Commons Attribution 4.0 International License.
// https://creativecommons.org/licenses/by/4.0/
//

use <prim.scad>

// printer error related tweaks
//
// Recommended values:
//   - For Wood PLA, LID_ERROR = 0.8, HOLD_ERROR=0.
//   - For PLA, LID_ERROR= 0.0. HOLD_ERROR=0.4.
LID_ERROR  = 0.2; // if the lid does not fit, make this larger.
//HOLD_ERROR = 0.0; // if the board holder is too loose, make this larger.


// inner size of the box.
// typically, (x,y) = board size, z depends on how much space you need for cabling.
//
size_x = 12+0.8;
size_y = 12+0.4;
size_z = 10;
size_x2 = 7.5; // from back side edge to the front black legs

// shell dimensions
shell_thick = 0.6;       // thickness (of inner shell for 2-layer shell)
shell_outer_thick = 0.6; // thickness of outer shell (for 2-layer shell)
shell_outer_x_thick = 1.2; // thickness of outer shell (for 2-layer shell)
shell_r     = 1; // radius in minkowski transform

// board parameters
board_thick      = 7;      // board thickness, typically 2mm
arm_thick        = 1.5;    // arm thickness (overhang)
arm_up_z         = 2;      // arm upper part height (in z-axis)
arm_low_z        = 3;      // arm upper part height (in z-axis)
arm_side_low_z   = size_z; // arm left/right part height (in z-axis)
arm_center_up_y  = size_y; // arm (center) upper part height
arm_center_low_y = size_y; // arm (center) lower part height
arm_center_thick = 12;
arm_left_up_x    = size_x; // arm (left) upper part height
arm_left_low_x   = size_x; // arm (left) lower part height
arm_right_up_x   = size_x;      // arm (right) upper part height
arm_right_low_x  = size_x; // arm (right) lower part height
arm_r            = 0.4;    // radius in minkowski transform

pins_hole_y      = 12;

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
SHELL_LID_DIST = 2; // distance between shell and lid when print_ready_layout

// render target; this is meant to be overriden by Makefile
TARGET="default";

//
// top level logic
//
audiojack_main();

module audiojack_main(target=TARGET){

    if (target == "default") {
        audiojack(with_print=1, with_upsidedown=1);
    }

    if (target == "unit") {
        audiojack_unit(40, with_lid=0);
    }

    if (target == "body_test") {
        audiojack(with_lid=0);
    }

    if (target == "lid_test") {
        audiojack_unit_lid_only(with_print=1);
    }
}

// [Public]
// Minimum size enclosure.
//
// with_lid  = { 1: render the lid, 0: does not render the lid }
// with_vent = { 1: with ventilation slits, 0: without ventilation slits }
// with_print = { 1: print layout (models are rotated to be printable), 0: edit layout (no rotation) }
// with_shell = { 1: render the shell (outermost enclosure that matches the requested dimension). 0: does not render the shell.}
// with_open_roof = { 1: make a big opening on the 'roof' part (for debugging), 0: do not do that }
// with_upsidedown = { 1: rotate up-side-down (for compo scenario), 0: do not do that }
module audiojack(with_lid=1, with_vent=1, with_print=1, with_shell=1, with_open_roof=0, with_upsidedown=0){

    if (with_print) {
        rotate([0,-90,0]) {
            translate([size_x/2+shell_outer_thick, 0, 0]) {
                audiojack_body(with_vent=with_vent, with_shell=with_shell, with_open_roof=with_open_roof);
            }
        }
        if (with_lid) {
            translate([-(size_z*1.5+SHELL_LID_DIST),0,0])
                rotate([0,90,0])
                audiojack_lid(size_x, size_y, size_z, shell_r, shell_thick, shell_outer_thick,
                             spfn_small, spfn_medium, spfn_large);
        }
    } else {
        rr = 180*with_upsidedown;
//        translate([size_x/2+shell_outer_thick, -size_y/2, 0]) {
        translate([0, 0, 0]) {
            rotate([rr,0,0]) {
                audiojack_body(with_vent=with_vent, with_shell=with_shell, with_open_roof=with_open_roof);
            }
        }
        if (with_lid) {
            translate([SHELL_LID_DIST+10, 0, 0]) {
                rotate([rr,0,0]) {
                    audiojack_lid(size_x, size_y, size_z, shell_r, shell_thick, shell_outer_thick,
                                  spfn_small, spfn_medium, spfn_large);
                }
            }
        }
        }
}

// [Public]
// Variable size enclosure with support structure. Typically to be embededd in another project.
// 
// ox, oy, oz = dimension (this has to be equals to or larger than (size_x, size_y, size_z).
// with_lid  = { 1: render the lid, 0: does not render the lid }
// with_vent = { 1: with ventilation slits, 0: without ventilation slits }
// with_shell = { 1: render the shell (outermost enclosure that matches the requested dimension). 0: does not render the shell.}
// with_open_roof = { 1: make a big opening on the 'roof' part (for debugging), 0: do not do that }
module audiojack_unit(ox=0, with_lid=0, with_vent=0, with_shell=1, with_open_roof=0) {

    // support structure dimensions
    sx = ox - size_x - shell_thick;
//    sy = oy - size_y - shell_thick*2;
//    sz = oz - size_z - shell_thick*2;
    
    translate([-ox/2, 0, 0])
    rotate([180, 0, 180]) {
        translate([-size_x/2+ox/2,0,0]) {
            difference(){
                audiojack_shell_single_layer(size_x, size_y, size_z, size_x2, shell_r, shell_thick, shell_outer_thick,
                                             spfn_small, spfn_medium, spfn_large, with_lid=with_lid, with_vent=with_vent, with_shell=with_shell, with_open_roof=with_open_roof);
                audiojack_shell_negative_volume_single_layer(size_x, size_y, size_z, size_x2, shell_r, shell_thick, shell_outer_thick,
                                                             spfn_small, spfn_medium, spfn_large, with_lid=with_lid, with_vent=with_vent);


            }
            // support structure
            translate([-size_x/2-shell_thick-sx/2,0,0]) {
                #prim_round_xplate(sx, size_y+shell_thick*2, size_z+shell_thick*2, shell_r, spfn_medium);
            }
        }
    }
}

// [Public]
// Variable size enclosure with support structure. Typically to be embededd in another project.
// 
// ox, oy, oz = dimension (this has to be equals to or larger than (size_x, size_y, size_z).
// with_lid  = { 1: render the lid, 0: does not render the lid }
module audiojack_unit_lid_only(ox=0, with_lid=0, with_inner=1) {
    // support structure dimensions
    sx = ox - size_x - shell_thick;
//    sy = oy - size_y - shell_thick*2;
//    sz = oz - size_z - shell_thick*2;
    translate([lid_outer_x, 0, 0])
    rotate([0,0,180]) {
        difference() {
            audiojack_lid_body_single_layer(size_x, size_y, size_z, shell_r, shell_thick, lid_inner_x, lid_outer_x,
                                            spfn_small, spfn_medium, spfn_large, with_inner);
            translate([-lid_outer_x+WELDING,0,0]) // centering to match with positive volume
                audiojack_lid_negative_volume(size_x, size_y, size_z, shell_r, shell_thick, shell_outer_thick,
                                            spfn_small, spfn_medium, spfn_large);
        }
    }
}

// [Public]
// Negative volume of lid that can be shared with the outer model (useful when you are embedding this model in another project).
module audiojack_unit_lid_negative_volume(ox=0) {
    sx = ox - size_x - shell_thick;
    rotate([0, 0, 180]) {
        translate([-lid_outer_x+WELDING,0,0]) // centering to match with positive volume
            audiojack_lid_negative_volume(size_x, size_y, size_z, shell_r, shell_thick, shell_outer_thick,
                                          spfn_small, spfn_medium, spfn_large);
    }
}


// -------------------------
// Private Modules
// -------------------------

module audiojack_body(sx=size_x, sy=size_y, sz=size_z, wr=shell_r, wt=shell_thick,
                      wot=shell_outer_thick, woxt=shell_outer_x_thick, lix=lid_inner_x,
                      fns=spfn_small, fnm=spfn_medium, fnl=spfn_large, with_shell=1, with_vent=1, with_open_roof=0){

    if (with_shell){
        difference(){
            audiojack_shell(sx=sx, sy=sy, sz=sz, wr=wr, wt=wt, wot=wot, woxt=woxt,
                            fns=fns, fnm=fnm, fnl=fnl, with_open_roof=with_open_roof);
            audiojack_shell_negative_volume(sx=sx, sy=sy, sz=sz, wr=wr, wt=wt, wot=wot, woxt=woxt, lix=lix,
                                            fns=fns, fnm=fnm, fnl=fnl, with_vent=with_vent);
        }
    }
}


// single layer type shell
// (for unit mode only that is meant to be embedded in other project like Compo.)
//
module audiojack_shell_single_layer(sx, sy, sz, sx2, wr, wt, wot, 
                      fns, fnm, fnl, with_lid=0, with_vent=0, with_shell=1, with_open_roof=0){

    dx = with_lid*wt; // to support lid inner part
    dx0 = (1-with_lid)*wt/2;
    if (with_shell) {
        // inner shell
        translate([-dx0,0,0])
            difference() {
                prim_round_xplate(sx+wt+dx, sy+wt*2, sz+wt*2, wr, fnm);
            translate([wt, 0, 0])
                #prim_round_xplate(sx+wt+dx, sy, sz+10*with_open_roof, 0.1, fnm);
        }
    }
}


module audiojack_shell_negative_volume_single_layer(sx, sy, sz, sx2, wr, wt, wot,
                                      fns, fnm, fnl, with_lid=0, with_vent=0){
    // hole at the bottom of shell (single layer)
    translate([wt+arm_thick, 0, -sz/2]) {
        #prim_round_zplate0(sx+wt, 11, wt*2+WELDING, 1, fnm);
    }

    // from bottom slit to accomodate front black legs
    w = sx-sx2;
    translate([-sx/2+wt+sx2+w/2, 0, -sz/2]) {
        #prim_round_zplate0(w, sy+wt*2+WELDING, wt*2+WELDING, 1, fnm);
    }

    if (with_vent){
        for (i=[-2:1:2]) {
            translate([0, i*4, 0]) {
                #prim_round_zplate0(sx-4, 2, sz+wt*2+wot*2+2, 1, fnm);
            }
        }
        for (i=[0.5, -0.5]) {
            translate([0, 0, i*4]) {
                prim_round_yplate0(sx-4, sy+wt+wot+2, 2, 1, fnm);
            }
        }
//        translate([-sx/2-wt, 0, 0])
//          #prim_round_yplate0(wt*2+4, 16, 2.5, 1, fnm);
    }
    
}

// normal type shell (2-layer)
//   - inner shell layer to hold the audio jack.
//   - outer shell layer to hold the lid.
// center = center of outer dimension
//    i.e. ((sx+woxt)/2, (sy+wt*2+wot*2)/2, (sz+wt*2+wot*2)/2)
module audiojack_shell(sx, sy, sz, wr, wt, wot, woxt,
                      fns, fnm, fnl, with_open_roof=0){
    // outer shell
    translate([0, 0, 0]) {
        difference() {
            prim_round_xplate0(sx+woxt, sy+wt*2+wot*2, sz+wt*2+wot*2, wr, fnm);
            // remove space for inner stuffing
            translate([woxt, 0, 0]) {
                prim_round_xplate0(sx+woxt, sy, sz+10*with_open_roof, wr, fnm);
            }
        }
    }
}

module audiojack_shell_negative_volume(sx, sy, sz, wr, wt, wot, woxt, lix,
                                      fns, fnm, fnl, with_vent=1){
    // hole at the bottom of shell
    translate([wt+arm_thick, 0, -sz/2])
        prim_round_zplate0(sx+wt, pins_hole_y, wt*2+wot*2+WELDING, 1, fnm);

    // for overlapping part with lid_inner
    translate([(sx+wot)/2+WELDING/2, 0, 0])
        #prim_round_xplate(lix*2, sy+wot*2, sz+wot*2, wr, fnm);

    if (with_vent){
        vx = (sx-lix)*0.7;
        for (i=[-1:1:1]) {
            translate([woxt/2-lix/2, i*4, 0])
                #prim_round_zplate0(vx, 2, sz+wt+wot+2, 1, fnm);
                }
        for (i=[0.5, -0.5]) {
            translate([woxt/2-lix/2, 0, i*4])
            #prim_round_yplate0(vx, sy+wt+wot+2, 2, 1, fnm);
        }
//        translate([-sx/2-wt, 0, 0])
//          #prim_round_yplate0(wt*2+4, 16, 2.5, 1, fnm);
    }
    
}


module audiojack_lid(sx, sy, sz, wr, wt, wot,
                      fns, fnm, fnl){
    translate([-lid_outer_x, 0, 0])
    difference(){
        audiojack_lid_body(sx, sy, sz, wr, wt, wot,
                          fns, fnm, fnl);
        translate([lid_outer_x/2,0,0]) // centering to match with positive volume
            audiojack_lid_negative_volume(sx, sy, sz, wr, wt, wot,
                                         fns, fnm, fnl);
    }
}

module audiojack_lid_body(sx, sy, sz, wr, wt, wot,
                      fns, fnm, fnl){
    // inner
    translate([-lid_inner_x/2+WELDING/2,0,0])
    difference(){
        prim_round_xplate(lid_inner_x+WELDING, sy-LID_ERROR+wot*2, sz-LID_ERROR+wot*2, wr, fnm);
        translate([-WELDING, 0, 0])
            prim_round_xplate(lid_inner_x+WELDING*2, sy-wt*2+wot*2, sz-wt*2+wot*2, wr, fnm);
    }    

    // outer
    translate([lid_outer_x/2,0,0])
        prim_round_xplate(lid_outer_x, sy+wt*2+wot*2, sz+wt*2+wot*2, wr, fnm);

}

module audiojack_lid_body_single_layer(sx, sy, sz, wr, wt, lix, lox,
                      fns, fnm, fnl, with_inner=1){
    // inner
    if (with_inner) {
        translate([-lix/2,0,0])
            difference() {
            prim_round_xplate(lix, sy-LID_ERROR-wt*2, sz-LID_ERROR-wt*2, wr, fnm);
            translate([-WELDING, 0, 0]) {
                prim_round_xplate(lix+WELDING*2, sy-wt*2-wt*2, sz-wt*2-wt*2, wr, fnm);
            }
        }
    }

    // outer
    translate([lox/2,0,0])
        prim_round_xplate(lox, sy+wt*2, sz+wt*2, wr, fnm);

}

module audiojack_lid_negative_volume(sx, sy, sz, wr, wt, wot,
                                    fns, fnm, fnl){
    hole_r = 3.6;
    dz = (sz-hole_r*2)/2; // aligh to top edge of inner volume
    // audiojack in 
    translate([0, 0, dz])
        rotate([0, 90, 0])
            #cylinder(r=3.8, h=wt*8, $fn=fnl, center=true);
 }


