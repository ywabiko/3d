//
// PAM8403-based tiny amplifier board enclosure
//
// This work is licensed under a Creative Commons Attribution 4.0 International License.
// https://creativecommons.org/licenses/by/4.0/
//

use <prim.scad>

// printer error related tweaks
//
// Recommended values:
//   - For Wood PLA, LID_ERROR=0.8, HOLD_ERROR=0.0.
//   - For PLA,      LID_ERROR=0.0, HOLD_ERROR=0.4.
LID_ERROR  = 0.8; // if the lid does not fit, make this larger. 0.1-0.4 too small
HOLD_ERROR = 0.0; // if the board holder is too loose, make this larger. 0.4 or 0.6

// inner size of the box
size_x = 24;
size_y = 31-HOLD_ERROR;
size_z = 17;
shell_thick = 1;
shell_extend = 2; // extension length for lid

arm_cut_y = 8;
arm_thick = 1;
arm_board_thick = 2;
arm_lo_z  = 2;
arm_up_z  = 2;
arm_up_z0 = arm_lo_z + arm_board_thick + arm_up_z/2;
arm_z     = arm_lo_z + arm_board_thick + arm_up_z;

// volume knob hole (front)
front_hole_dz = 10.5; // distance from left-bottom corner (looking from frontside)
front_hole_dy = 5.5;   // distance from left-bottom corner (looking from frontside)
front_hole_r  = 3.5;  // radius

// lid
lid_inner_x = 2;
lid_inner_thick = 1;

// other shape configurations
mink_error = 0.2; // 0.2 for normal PLA, 0.4 for wood PLA
lidinner = 2.0; // thickness of lid inner part

// further customization example: make a hole on the front surface
// coordinates are from left-bottom edge of inner space
// ***volume knob hole***
//front_hole_y=3.0;
//front_hole_z=8.0;

// a hole on the lid side
// ***cable holes***
lid_hole_y=2.3;
lid_hole_z=6;
lid_hole_r=0.9;
lid_vent_r=0.7;

// other shape parameters
thick = 0.4;  // wall thickness
mink =  0.4;  // minkowski radius
spfn =  16;   // minkowski resolution

// internal configurations
difoff   = thick+mink*3;  // offset to apply difference correctly for the inner space
lidoff   = -6; // x-offset to locate the lid
size_x_room = size_x + lidinner + mink; // size_x that lidinner takes into account. (this may or may not be necessary depending on shape of stuffing.)
WELDING= 0.4;

// render target; this is meant to be overriden by Makefile
//TARGET="default";
TARGET="unit_lid_test";

//
// top level logic
//
pam8403_main();

module pam8403_main(target=TARGET){
    
    if (target == "default") {
//        pam8403_unit(ox=40, oy=38, oz=36, with_vent=1, with_cabling=1, with_lid=1, with_shell=1, with_holder=1);
        pam8403(with_vent=1);
    }

    if (target == "novent") {
        pam8403(with_vent=0);
    }

    if (target == "body_only") {
        pam8403(with_body=1, with_lid=0);
    }

    if (target == "lid_only") {
        pam8403(with_body=0, with_lid=1);
    }

    if (target == "unit_test") {
        translate([40,0,0]){
            pam8403_unit(ox=40, oy=38, oz=36, with_vent=0, with_cabling=1, with_lid=0, with_shell=1, with_holder=1, with_side=1);
        }
        pam8403_unit_lid_only(ox=40, oy=38, oz=36, with_vent=0, with_cabling=1, with_lid=0, with_shell=0, with_holder=0, with_hole=0, with_vent_lid=1);
    }
    
    if (target == "unit_lid_test") {
        pam8403_unit_lid_only(ox=40, oy=38, oz=36, lid_thick=3, with_vent=0, with_cabling=1, with_lid=0, with_shell=0, with_holder=0, with_hole=0, with_vent_lid=1, with_arm=1);
    }
    
}


// -------------------------
// Public Modules
// -------------------------

// [Public]
// Minimum size enclosure.
//
// with_vent = { 1: with ventilation slits, 0: without ventilation slits }
// with_vent_lid = { 1: with ventilation slits on the lid, 0: without ventilation slits on the lid }
// with_lid  = { 1: render the lid, 0: does not render the lid }
// with_body = { 1: render the body, 0: does not render the body }
// with_print = { 1: print layout (models are rotated to be printable), 0: edit layout (no rotation) }
module pam8403(with_vent=1, with_vent_lid=0, with_lid=1, with_body=1, with_print=1){

    ox = size_x + shell_thick*2;
    oy = size_y + shell_thick*2;
    oz = size_z + shell_thick*2;

    if (with_body) {
        translate([size_x+shell_thick,0,size_x/2]) {
            rotate([0,90,0]) {
                pam8403_unit_body_only(ox=ox, oy=oy, oz=oz, with_vent=with_vent, with_cabling=0, with_lid=1, with_shell=0, with_holder=1, with_side=0, with_print=with_print);
            }
        }
    }

    if (with_lid) {
        rotate([0,-90,0]) {
            pam8403_unit_lid_only(ox=ox, oy=oy, oz=oz, lid_thick=shell_thick, with_vent=with_vent, with_cabling=0, with_lid=1, with_shell=0, with_holder=1, with_side=0, with_vent_lid=with_vent_lid, with_print=with_print);
        }
    }
}

// [Public]
// Variable size enclosure. Typically to be embededd in another project.
// 
// ox, oy, oz = dimension (this has to be equals to or larger than (size_x, size_y, size_z).
// with_body = { 1: render the body, 0: does not render the body }
// with_lid  = { 1: render the lid, 0: does not render the lid }
// with_vent = { 1: with ventilation slits, 0: without ventilation slits }
// with_vent_lid = { 1: with ventilation slits on the lid, 0: without ventilation slits on the lid }
// with_cabling = { 1: render a big openings on the enclosure for easier cabling, 0: without such openings }
// with_shell = { 1: render the shell (outermost enclosure that matches the requested dimension). 0: does not render the shell.}
// with_holder = { 1: render the holder to support PAM8403 board. 0: without holder (testing purpose). }
// with_side   = { 1: fill in the side space between the shell and the holder (to avoid oozing). 0: does not do that. }
// with_print = { 1: print layout (models are rotated to be printable), 0: edit layout (no rotation) }
module pam8403_unit(ox, oy, oz, lid_thick=shell_thick, with_vent, with_cabling, with_lid, with_shell, with_holder, with_side=0, with_vent_lid=0, with_print=1, with_open_roof=0){
    if (with_print){
        rotate([0,90,0]) {
            //translate([-ox/2,oy/2-10,oz/2]) {
            translate([0,0,0]) {
                pam8403_unit_body_only(ox=ox, oy=oy, oz=oz, with_vent=with_vent, with_cabling=with_cabling, with_lid=with_lid, with_shell=with_shell, with_holder=with_holder, with_side=with_side, with_open_roof=with_open_roof);
            }
        }
    } else {
        pam8403_unit_body_only(ox=ox, oy=oy, oz=oz, with_vent=with_vent, with_cabling=with_cabling, with_lid=with_lid, with_shell=with_shell, with_holder=with_holder, with_side=with_side, with_open_roof=with_open_roof);
    }

    if (with_lid) {
        translate([-ox/2,0,0]) {
            pam8403_unit_lid_only(ox=ox, oy=oy, oz=oz, lid_thick=lid_thick, with_vent=with_vent, with_cabling=with_cabling, with_lid=with_lid, with_shell=with_shell, with_holder=with_holder, with_vent_lid=with_vent_lid);
        }
    }
}

// [Public]
// Variable size enclosure(body only). Typically to be embededd in another project.
// 
// ox, oy, oz = dimension (this has to be equals to or larger than (size_x, size_y, size_z).
// with_body = { 1: render the body, 0: does not render the body }
// with_lid  = { 1: render the lid, 0: does not render the lid }
// with_vent = { 1: with ventilation slits, 0: without ventilation slits }
// with_vent_lid = { 1: with ventilation slits on the lid, 0: without ventilation slits on the lid }
// with_cabling = { 1: render a big openings on the enclosure for easier cabling, 0: without such openings }
// with_shell = { 1: render the shell (outermost enclosure that matches the requested dimension). 0: does not render the shell.}
// with_holder = { 1: render the holder to support PAM8403 board. 0: without holder (testing purpose). }
// with_side   = { 1: fill in the side space between the shell and the holder (to avoid oozing). 0: does not do that. }
// with_print = { 1: print layout (models are rotated to be printable), 0: edit layout (no rotation) }
module pam8403_unit_body_only(ox, oy, oz, with_vent, with_cabling, with_lid, with_shell, with_holder, with_side=0, with_open_roof=0){
    // put holder at the left-top corner (looking from back side) = right-top corner (looking from front side)
    hx = ox/2 - size_x/2 - shell_thick;
    hy = 0;
    hz = oz/2 - size_z/2 - shell_thick;
    dz = shell_thick*with_shell;
    
    translate([0,0,0]) {
        if (with_shell) {
            difference(){
                union() {
                    pam8403_shell(ox, oy, oz, shell_thick, with_vent, with_cabling);
                }
                // put the negative volume at exactly same position as holder
                translate([-shell_thick, hy, hz-dz+shell_thick]) {
                    rotate([0,0,0]) {
                        #pam8403_holder_negative_volume(ox, size_y, size_z, shell_extend, shell_thick, with_vent, with_cabling);
                    }
                }
            }
        }
        if (with_holder) {
            translate([hx, hy, hz-dz]) {
                rotate([0,0,0]) {
                    pam8403_holder(size_x, size_y, size_z, ox, oy, oz, shell_extend, shell_thick, with_vent=with_vent, with_cabling=with_cabling, with_side=with_side, with_open_roof=with_open_roof);
                }
            }            
        }
    }
}

// [Public]
// Variable size enclosure(lid only). Typically to be embededd in another project.
// 
// ox, oy, oz = dimension (this has to be equals to or larger than (size_x, size_y, size_z).
// with_body = { 1: render the body, 0: does not render the body }
// with_lid  = { 1: render the lid, 0: does not render the lid }
// with_vent = { 1: with ventilation slits, 0: without ventilation slits }
// with_vent_lid = { 1: with ventilation slits on the lid, 0: without ventilation slits on the lid }
// with_cabling = { 1: render a big openings on the enclosure for easier cabling, 0: without such openings }
// with_shell = { 1: render the shell (outermost enclosure that matches the requested dimension). 0: does not render the shell.}
// with_holder = { 1: render the holder to support PAM8403 board. 0: without holder (testing purpose). }
// with_side   = { 1: fill in the side space between the shell and the holder (to avoid oozing). 0: does not do that. }
// with_print = { 1: print layout (models are rotated to be printable), 0: edit layout (no rotation) }
module pam8403_unit_lid_only(ox, oy, oz, lid_thick=shell_thick, with_vent, with_cabling, with_lid, with_shell, with_holder, with_hole=1, with_vent_lid=0, with_arm=0, with_vent_style=0){
    // put holder at the left-top corner (looking from back side) = right-top corner (looking from front side)
    hx = ox/2 - size_x/2 - shell_thick;
    hy = 0;
    hz = oz/2 - size_z/2 - shell_thick;
    sx = size_x;
    sy = size_y;
    sz = size_z;
    st = shell_thick;

    translate([lid_thick/2,0,0]) {
        difference() {
            union() {
                // lid outer
                prim_round_xplate(lid_thick, oy, oz, 1, 16);

                // lid inner
                translate([lid_thick-WELDING,0,0]) {
                    difference(){
                        prim_round_xplate(lid_inner_x+WELDING, oy-shell_thick*2-LID_ERROR, oz-shell_thick*2-LID_ERROR, 1, 16);
                        prim_round_xplate(lid_inner_x+WELDING, oy-shell_thick*4, oz-shell_thick*4, 1, 16);
                    }
                }
            }

            union() {
                // cable holes
                if (with_hole) {
                    y3 = 6; // 3-cable width (22 AWG)
                    y2 = 4; // 2-cable width (22 AWG)
                    z1 = 3; // 1-cable height (22 AWG)

                    // audio input (3-cable)
                    translate([0, -sy/2+shell_thick*2+2+y3/2, -sz/2+shell_thick+arm_lo_z+arm_board_thick+arm_up_z]) {
                        #prim_round_xplate(st*6, y3, 3, 1, 16);
                    }
                    // power input (2-cable)
                    translate([0, y2/2, -sz/2+shell_thick+arm_lo_z+arm_board_thick+arm_up_z]) {
                        #prim_round_xplate(st*6, y2, 3, 1, 16);
                    }

                    // audio output left (2-cable)
                    translate([0, 3+y2/2, sz/2-shell_thick*2-3]) {
                        #prim_round_xplate(st*6, y2, 3, 1, 16);
                    }

                    // audio output right (2-cable)
                    translate([0, -3-y2/2, sz/2-shell_thick*2-3]) {
                        #prim_round_xplate(st*6, y2, 3, 1, 16);
                    }
                }
                
                // lid vent holes (4x3)
                if (with_vent_lid) {
                    if (with_vent_style==0) {
                        for (iz=[  -0.3, 0.9, 2.1]) {
                            for (iy=[-1.8, -0.6, 0.6, 1.8]) {
                                translate([0, 6*iy, 6*iz+1]) {
                                    rotate([0, 90, 0]) {
                                        cylinder(h=lid_thick*2, r=2, $fn=16, center=true);
                                    }
                                }
                            }
                        }
                    }
                    if (with_vent_style==1) {
                        for (iz=[-2.3, 0, 1, 2]) {
                            for (iy=[-1.1, 0, 1.1]) {
                                translate([0, 6*iy, 6*iz]) {
                                    rotate([0, 90, 0]) {
                                        cylinder(h=lid_thick*2, r=2, $fn=16, center=true);
                                    }
                                }
                            }
                        }
                        for (iz=[-2.3, 1, 2]) {
                            for (iy=[-2.2, 2.2]) {
                                translate([0, 6*iy, 6*iz]) {
                                    rotate([0, 90, 0]) {
                                        cylinder(h=lid_thick*2, r=2, $fn=16, center=true);
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        }

        if (with_arm) {
            // lid inner arm (to hold the board)
            ah = ox - size_x - shell_thick*2 + lid_inner_x;
            az = oz/2-shell_thick-sz+arm_lo_z + arm_board_thick/2;
            ay = 4;
            az = 3;
            echo (ah=ah, az=az);
            translate([0, 0, 0.3*6+1]) {
                for (iy = [-1,1]) {
                    translate([0, (sy/2-shell_thick)*iy, 0]) {
                        translate([ah/2-WELDING, (-ay/2)*iy, 0]) {
                            prim_round_xplate(ah, ay, 3, 1, 16);
                        }

                        hull(){
                        for (iz = [-1,1]) {
                            translate([ah/2-WELDING, (-2/2)*iy, 2*iz]) {
                                rotate([0, 90, 0]) {
                                    cylinder(h=ah, r=1, $fn=16, center=true);
                                }
                            }
                        }
                        }
                    }
                }
            }
        }
    }
}

// -------------------------
// Private Modules
// -------------------------

module pam8403_shell(ox, oy, oz, st, with_vent, with_cabling) {
    // outer shell
    difference(){
        difference(){
            prim_round_xplate(ox, oy, oz, 1, 16);
            translate([-shell_thick,0,0])
                prim_round_xplate(ox, oy-shell_thick*2, oz-shell_thick*2, 1, 16);
        }
        pam8403_shell_negative_volume(ox, oy, oz, shell_thick, with_vent, with_cabling);
    }

}

module pam8403_shell_negative_volume(sx, sy, sz, st, with_vent, with_cabling) {
    with_cabling_type0 = 0;
    // vent top
    if (with_cabling) {
        translate([0,0,sz/2]) {
            for (iy=[-2,-1,0,1,2]) {
                translate([0,iy*5.9,0]) {
                    if (with_cabling_type0) { 
                        prim_round_zplate0(sx*0.6, 3, st*3, 1, 16);
                    } else {
                        for (ix=[-2,-1,0,1,2]) {
                            translate([ix*5.9, 0, 0]) {
                                cylinder(h=st*4, r=1.6, $fn=16, center=true);
                            }
                        }
                    }
                }
            }
        }
    }

    // vent side
    if (!with_cabling) {
        if (with_vent) {
            translate([0,0,0]) {
                for (i=[-2,-1,0,1,2,3]) {
                    translate([0,0,i*5-2]) {
                        prim_round_yplate0(sx*0.6, sy*2, 2, 1, 16);
                    }
                }
            }
        }
    }
}


// holder extension to support lid
module pam8403_lid_holder_extension(sx, sy, sz, sh, st, with_vent, with_cabling) {
    // inner holder
    translate([-sx/2-st,0,0]) {
        difference(){
            prim_round_xplate(sh*2, sy+st*2, sz+st*2, 1, 16);
            #prim_round_xplate(sh*2.5, sy, sz, 1, 16);
        }
    }
}

// holder to support PAM8403 board
module pam8403_holder(sx, sy, sz, ox, oy, oz, sh, st, with_vent, with_cabling, with_side=0, with_open_roof=0) {
    dy = (oy-sy-st*2)*with_side;
    // inner holder
    translate([st/2,0,st])
        union(){
        difference(){
            union(){
                difference(){
                    prim_round_xplate(sx+st, sy+st*2+dy, sz+st*2, 1, 16);
                    translate([-st,0,0])
                        prim_round_xplate(sx+st, sy, sz, 1, 16);
                }
                if (sh > 0) { // extend shell in x-axis to support lid
                    pam8403_lid_holder_extension(sx, sy, sz, sh, st, with_vent, with_cabling);
                }
                translate([WELDING,0,0]) {
                    pam8403_hold_arm(sx, sy, sz, with_vent);
                }
            }
            union() {
                pam8403_holder_negative_volume(sx, sy, sz, sh, st, with_vent=with_vent, with_cabling=with_cabling); // shared with shell
                pam8403_holder_negative_volume_private(sx, sy, sz, sh, st, with_vent=with_vent, with_cabling=with_cabling, with_open_roof=with_open_roof); // private to holder
            }
        }
    }
}

// negative volume that could be shared with outer shell (like the front knob hole)
module pam8403_holder_negative_volume(sx, sy, sz, sh, st, with_vent, with_cabling) {
    // front knob hole
    translate([sx/2, -sy/2+front_hole_dy, -sz/2+front_hole_dz]) {
        rotate([0,90,0]) {
            #cylinder(r = front_hole_r*1.1, $fn = 64, h=st*4, center=true);
        }
    }
}

// negative volume that does not need to be shared with outer shell (like vent slits)
module pam8403_holder_negative_volume_private(sx, sy, sz, sh, st, with_vent, with_cabling, with_open_roof=0) {
    // open roof
    if (with_open_roof) {
        translate([-sx/2, 0, sz/2+st]) {
            #prim_round_zplate0(sx*2, sy, st*2+WELDING, 2, 16);
        }
    }

    // open top/bottom for compo scenario
    if (with_cabling) {
        // bottom
        translate([-sx/2-shell_thick-sh, 0, -sz/2-st]) {
            #prim_round_zplate0(sx*0.8, sy*0.9, st*2+WELDING, 2, 16);
        }
        // top
        translate([-sx/2-shell_thick-sh, 0, sz/2+st]) {
            #prim_round_zplate0(sx*1.9, sy*0.9, st*2+WELDING, 2, 16);
        }
    }

    if (with_vent) {
        // side vent
        for (i=[0.5,2]) {
            translate([-st*1.5,0,i*3.5-2]) {
                #prim_round_yplate0(sx*0.8, sy+st*2+WELDING, 3, 1.4, 16);
            }
        }

        // top/bottom vent
        for (i=[-2,-1,0,1,2]) {
            translate([-st*1.5,i*5.5,0]) {
                #prim_round_zplate0(sx*0.8, 3, sz+st*2+WELDING, 1.4, 16);
            }
        }
    }
    
    // vent
}


module pam8403_hold_arm(ox, oy, oz, with_vent){
    // for debug
    //translate([-size_x*1.6,0,0])
    {
        // 
        translate([-arm_thick, 0, -size_z/2+arm_z/2]) {
            difference(){
                // outer shell is slightly larger for WELDING (considering compo scenario)
                translate([0,0,-WELDING]) {
                    cube([size_x+WELDING*2, size_y+WELDING*2, arm_z+WELDING*2], center=true);
                }
                union(){
                    // wide open it
                    translate([-arm_thick*2-2,0,-WELDING]) {
                        #prim_round_zplate0(size_x+arm_thick*2, size_y-arm_thick*2, arm_z+WELDING*2, 2, 16);
                    }

                    // make board slot in the middle (in z-axis)
                    translate([-WELDING-2, 0, 0]) {
                        // board slot
                        cube([size_x+WELDING+WELDING*2, size_y+WELDING*1, arm_board_thick], center=true);
                        // (for debug)
                        //cube([size_x*2, size_y*2, 1], center=true);
                    }

                    // misc cuts
                    translate([size_x/2-arm_thick-shell_thick-arm_thick, -size_y/2+arm_thick/2, arm_board_thick]) {
                        #cube([size_x*2,arm_up_z*2+WELDING,arm_up_z+0.01], center=true);
                    }
                    translate([size_x/2-arm_thick-shell_thick-arm_thick, -size_y/2+arm_thick/2+arm_cut_y/2, arm_board_thick]) {
                        #cube([size_x*2,arm_cut_y+shell_thick*2, arm_up_z], center=true);
                    }
                    
                    translate([-size_x/2-arm_thick, 0, 0]) {
                        #cube([arm_thick*2, size_y*2, 8], center=true);
                    }
                }
            }
        }
    }
}
