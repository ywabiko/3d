//
// Adafruit Micro USB Breakout Board Enclosure
//
// by Yasuhiro Wabiko
// This is licensed under the Creative Commons - Attribution license.
//

use <prim.scad>

// inner size of the box.
// typically, (x,y) = board size, z depends on how much space you need for cabling.
//
size_x = 10;
size_y = 20.6; // 20.2 too small
size_z = 8;

// shell dimensions
shell_thick = 1; // thickness
shell_r     = 1; // radius in minkowski transform

// board parameters
board_thick      = 1.5;    // board thickness, typically 2mm
arm_thick        = 1.5;    // arm thickness (overhang)
arm_up_z         = 2;      // arm upper part height (in z-axis)
arm_low_z        = 2;      // arm upper part height (in z-axis)
arm_center_thick = 0.6;
arm_center_up_y  = size_y; // arm (center) upper part width
arm_center_low_y = size_y; // arm (center) lower part width
arm_left_up_x    = size_x; // arm (left) upper part height
arm_left_low_x   = size_x; // arm (left) lower part height
arm_right_up_x   = size_x;      // arm (right) upper part height
arm_right_low_x  = size_x; // arm (right) lower part height
arm_r            = 0.2;    // radius in minkowski transform
arm_z            = arm_low_z + board_thick + arm_up_z;

// lid dimensions
lid_outer_x = 1;
lid_inner_x = 2;

// misc design parameters
spfn_small  = 8;
spfn_medium = 16;
spfn_large  = 64;
lid_inner_thick = 2;

// internal parameters
WELDING = 0.1;
WELDING_SMALL = 0.3;
SHELL_LID_DIST = 10; // distance between shell and lid when print_ready_layout


//
// top level logic
//
microusb(with_vent=1, with_cabling=0, with_shell=1, with_print=1);
//microusb_unit_with_support(sh=36-8.5, with_vent=1, with_cabling=1, with_shell=0);
//rotate([0,90,0])
//microusb_unit_with_support(sh=40-size_x, with_vent=1, with_cabling=1, with_shell=0);


// -------------------------
// Public Modules
// -------------------------

// [Public]
// Minimum size enclosure.
//
// with_vent = { 1: with ventilation slits, 0: without ventilation slits }
// with_lid  = { 1: render the lid, 0: does not render the lid }
// with_cabling = { 1: render a big openings on the enclosure for easier cabling, 0: without such openings }
// with_shell = { 1: render the shell (outermost enclosure that matches the requested dimension). 0: does not render the shell.}
// with_print = { 1: print layout (models are rotated to be printable), 0: edit layout (no rotation) }
// with_open_roof = { 1: make a big opening on the 'roof' part (for debugging), 0: do not do that }
module microusb(with_vent=1, with_lid=1, with_cabling=0, with_shell=1, with_print=0, with_open_roof=0){

    if (with_print) {
        rotate([0,-90,0])
            translate([size_x/2+shell_thick+lid_inner_x/2, 0, 0])
            microusb_body(with_vent=with_vent, with_lid=with_lid, with_cabling=with_cabling, with_shell=with_shell, with_open_roof=with_open_roof);
        if (with_lid) {
            translate([size_z+shell_thick*2+SHELL_LID_DIST,0,0])
                rotate([0,90,0])
                microusb_lid(size_x, size_y, size_z, shell_r, shell_thick,
                             spfn_small, spfn_medium, spfn_large);
        }
    } else {
        // debug
        translate([0, 0, 0]) {
            // debug
            difference() {
                union() {
                    translate([0, 0, 0])
                        microusb_body(with_vent=with_vent, with_lid=with_lid, with_cabling=with_cabling, with_shell=with_shell, with_open_roof=with_open_roof);
                    if (with_lid) {
                        microusb_lid(size_x, size_y, size_z, shell_r, shell_thick,
                                     spfn_small, spfn_medium, spfn_large);
                    }
                }
                // debug
                translate([-size_x/2, size_y/2+shell_thick/2, 0]) {
                    //#cube([size_x*4, shell_thick, arm_z], center=true);
                }
            }
        }
    }
}

// [Public]
// Variable size enclosure(in x-axis only). Typically to be embededd in another project.
// 
// ox, oy, oz = dimension (this has to be equals to or larger than (size_x, size_y, size_z).
// with_vent = { 1: with ventilation slits, 0: without ventilation slits }
// with_lid  = { 1: render the lid, 0: does not render the lid }
// with_cabling = { 1: render a big openings on the enclosure for easier cabling, 0: without such openings }
// with_shell = { 1: render the shell (outermost enclosure that matches the requested dimension). 0: does not render the shell.}
// with_print = { 1: print layout (models are rotated to be printable), 0: edit layout (no rotation) }
// with_open_roof = { 1: make a big opening on the 'roof' part (for debugging), 0: do not do that }
module microusb_unit(ox=0, with_vent=0, with_cabling=0, with_shell=0, with_support=1, with_arm=1, with_open_roof=0) {
    microusb_unit_with_support(ox-size_x, with_vent=with_vent, with_cabling=with_cabling, with_shell=with_shell, with_support=with_support, with_arm=with_arm, with_open_roof=with_open_roof);
}



// [Public]
// Lid
module microusb_unit_lid_only() {
    rotate([0,0,180]) {
        microusb_lid(size_x, size_y, size_z, shell_r, shell_thick,
                     spfn_small, spfn_medium, spfn_large);
    }
    
}

// [Public]
// Negative volume of lid that can be shared with the outer model (useful when you are embedding this model in another project).
module microusb_unit_lid_negative_voume() {
    rotate([0,0,180]) {
        translate([-lid_outer_x, 0, 0]) {
            translate([lid_outer_x/2,0,0]) {// centering to match with positive volume
                #microusb_lid_negative_volume(size_x, size_y, size_z, shell_r, shell_thick,
                                             spfn_small, spfn_medium, spfn_large);
            }
        }
    }
}

// -------------------------
// Private Modules
// -------------------------

module microusb_body(with_vent=0, with_lid=0, with_cabling=0, with_shell=0, with_arm=1, with_open_roof=0){
    dx = (with_cabling)*lid_inner_x;
    union() {
        difference() {
            union() {
                cube([0,0,0]); // dummy cube to make difference() work regardless of conditions
                if (with_shell){
                    microusb_shell(size_x, size_y, size_z, shell_r, shell_thick,
                                   spfn_small, spfn_medium, spfn_large, with_open_roof=with_open_roof);
                }
                // side support. (if with_shell=1, it is embedded inside shell, so invisible.)
                for (i=[-1,1]) {
                    //translate([-size_x/2-shell_thick*2+WELDING_SMALL+arm_left_up_x/2, (-size_y/2-shell_thick+WELDING_SMALL)*i, -board_thick]) {
                    //cube([arm_left_up_x, WELDING_SMALL*2, arm_z], center=true);
                    //}
                }
            }
            union() {
                if (with_shell) {
                    microusb_shell_negative_volume(size_x, size_y, size_z, shell_r, shell_thick,
                                                   spfn_small, spfn_medium, spfn_large, with_vent, with_cabling, with_shell);
                }
            }
        }

        if (with_arm) {
            translate([-shell_thick+dx/2,0,-shell_thick]){
                microusb_shell_arm(size_x, size_y, size_z, shell_r, shell_thick,
                                   spfn_small, spfn_medium, spfn_large);
            }
        }
    }
}


module microusb_unit_with_support(sh=0, with_vent=0, with_cabling=0, with_shell=0, with_support=1, with_arm=1, with_open_roof=0) {
    // for debug
    // translate([size_x+sh-2,-size_y/2,arm_z/2-arm_low_z])
    //translate([0, -size_y/2,-2])
    {
        difference() { // cut unnecessary welding at the top and bottom
            union() {
                if (with_support) {
                    // support structure
                    difference(){
                        translate([-(size_x+sh)/2, 0, 0]) {
                            prim_round_xplate0(size_x+sh, size_y+shell_thick*2, size_z, 0.1, spfn_medium);
                        }
                        translate([-sh-size_x/2-WELDING_SMALL, 0, 0]) {
                            #prim_round_xplate0(size_x+WELDING_SMALL*2, size_y, size_z+WELDING, 0.1, spfn_medium);
                        }
                    }
                }

                translate([-sh-size_x/2,0,0]) {
                    rotate([0,0,180]) {
                        microusb_body(with_vent=with_vent, with_cabling=with_cabling, with_shell=with_shell, with_arm=with_arm, with_open_roof=with_open_roof);
                    }
                }
            }
            union() { // unnecessary parts at the top and bottom
                translate([-(size_x+sh)/2, 0, -arm_z-shell_thick]) {
                    #cube([size_x+sh, size_y+shell_thick*4, arm_z], center=true);
                }
                translate([-(size_x+sh)/2, 0, arm_z-shell_thick]) {
                    #cube([size_x+sh, size_y+shell_thick*4, arm_z], center=true);
                }

            }
        }
    }
}



//
// (sx,sy,sz) = dimension of stuffing
//
// centered at the center of stuffing (excluding lid_inner_x)
//
module microusb_shell(sx, sy, sz, wr, wt,
                      fns, fnm, fnl, with_open_roof=0){

    // requested dimensions
    ox = sx+wt+lid_inner_x;
    oy = sy+wt*2;
    oz = sz+wt*2;
    
    translate([ox/2-sx/2-wt-lid_inner_x/2, oy/2-sy/2-wt, oz/2-sz/2-wt]) {
        difference(){
            // shell outer frame
            translate([0,0,0]){
                prim_round_xplate0(ox, oy, oz, wr, fnm);
            }
            // shell space for stuffing
            translate([wt, 0, 0]) {
                #prim_round_xplate0(sx+lid_inner_x+wt, sy, sz+10*with_open_roof, wr, fnm);
            }
        }
    }

}

module microusb_shell_arm(sx, sy, sz, wr, wt,
                      fns, fnm, fnl){
    // requested dimensions
    ox = sx+wt+lid_inner_x;
    oy = sy+wt*2;
    oz = sz+wt*2;

    with_center = 1;
    with_right = 1;
    with_left = 1;
    
    for (i=[0,1]){ // i = { 0:arm lower, 1:arm upper }
        dz = (arm_low_z/2+board_thick+arm_up_z/2+WELDING)*i;
        rx = [arm_right_low_x, arm_right_up_x][i];
        lx = [arm_left_low_x, arm_left_up_x][i];
        cy = [arm_center_low_y, arm_center_up_y][i];
        echo (rx=rx);
        translate([-wt, 0, -sz/2+wt+arm_low_z/2-WELDING/2+dz]){

            // center
            if (with_center) {
                y0 = -size_y/2+cy/2;
                translate([-sx/2+arm_center_thick/2-WELDING+wt, y0, 0]) {
                    prim_round_yplate0(arm_center_thick+WELDING, arm_center_low_y+WELDING*2, arm_low_z+WELDING, 0.1, fnm);
                }
            }

            // left
            if (with_left) {
                x0 = -size_x/2+lx/2+wt;
                translate([x0-WELDING/2, -sy/2+arm_thick/2-WELDING/2, 0]) {
                    prim_round_xplate0(lx+WELDING, arm_thick+WELDING, arm_low_z+WELDING, arm_r, fnm);
                }
            }

            // right
            if (with_right) {
                x0 = -size_x/2+rx/2+wt;
                translate([x0-WELDING/2, sy/2-arm_thick/2+WELDING/2, 0]) {
                    prim_round_xplate0(rx+WELDING, arm_thick+WELDING, arm_low_z+WELDING, arm_r, fnm);
                }
            }
        }
    }
}

module microusb_shell_negative_volume(sx, sy, sz, wr, wt,
                                      fns, fnm, fnl, with_vent=0, with_cabling=0, with_shell=0){
    // cable hole at the top of shell
    if (with_cabling) {
        translate([0, 0, sz/2])
            prim_round_zplate0(sx*2, sy*2, sz*0.5, 1, fnm);
    }

    // cable hole at the bottom of shell
    if (with_cabling) {
        for (i=[-2:1:2]) {
            translate([0, i*2.54, 0])
                prim_round_zplate0(sx*0.9, 2.0, sz+wt*2+WELDING, 1, fnm);
        }
    }

    if (with_vent){
        // top/bottom vent
        for (i=[-2:1:2]) {
            translate([0, i*3.5, 0])
                #prim_round_zplate0(sx*0.8, 2, sz+wt+2, 1, fnm);
                }

        // side vent
//        for (i=[0.5]) {
//            translate([0, 0, i*4])
//                #prim_round_yplate0(sx*0.8, sy+wt+2, 2, 1, fnm);
//        }

        // front vent
        vz = sz-arm_z;
        for (i=[0.5]) {
            translate([0, 0, -sz/2+arm_z+vz/2])
                #prim_round_xplate0(sx+wt*2+2, sy*0.8, vz, 1, fnm);
        }
    }
    
    // front
    if (with_shell) {
        translate([-sx/2-wt, 0, -sz/2+arm_low_z+board_thick/2]) {
            //prim_round_xplate0(wt*2+4, 16, board_thick, 0.1, fnm);
        }
    }
}


module microusb_lid(sx, sy, sz, wr, wt,
                      fns, fnm, fnl){
    translate([-lid_outer_x, 0, 0])
    difference(){
        microusb_lid_body(sx, sy, sz, wr, wt,
                          fns, fnm, fnl);
        union() {
            translate([lid_outer_x/2,0,0]) { // centering to match with positive volume
                microusb_lid_negative_volume(sx, sy, sz, wr, wt,
                                             fns, fnm, fnl);
                microusb_lid_negative_volume_private(sx, sy, sz, wr, wt,
                                                     fns, fnm, fnl);
            }
        }
    }
}

module microusb_lid_body(sx, sy, sz, wr, wt,
                      fns, fnm, fnl){

    // inner
    translate([-lid_inner_x/2,0,0])
    difference(){
        prim_round_xplate(lid_inner_x, sy-WELDING_SMALL, sz-WELDING_SMALL, wr, fnm);
        translate([0, 0, 0])
            prim_round_xplate(lid_inner_x+WELDING*2, sy-wt-WELDING_SMALL, sz-wt-WELDING_SMALL, wr, fnm);
    }    

    // outer
    translate([lid_outer_x/2,0,0])
        prim_round_xplate(lid_outer_x, sy+wt*2, sz+wt*2, wr, fnm);

}

// shared with lid outer
module microusb_lid_negative_volume(sx, sy, sz, wr, wt,
                                    fns, fnm, fnl){
    // microusb in 
    translate([0,0,0.85]) {
        #prim_round_xplate(lid_outer_x+WELDING*2, 8, 4, wr, fnm);
    }
}

// with lid inner
module microusb_lid_negative_volume_private(sx, sy, sz, wr, wt,
                                    fns, fnm, fnl){

    // slit to accomodate board edge
    translate([-lid_outer_x-lid_inner_x/2, 0, -sz/2+arm_low_z+board_thick/2]) {
        #prim_round_xplate(lid_outer_x+WELDING*2, sy, 2, 0.2, fnm);
    }
        
}
