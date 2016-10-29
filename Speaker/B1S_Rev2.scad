//
// HiVi B1S 1" speaker enclosure
//
// by Yasuhiro Wabiko
//
// This work is licensed under a Creative Commons Attribution 4.0 International License.
// https://creativecommons.org/licenses/by/4.0/
//

use <speaker_stand.scad>
use <prim.scad>

// printer error related tweaks
LID_ERROR   = 0.4; // if the lid does not fit, make this larger.
                   // Wood PLA: 0.8 (0.1-0.4 too small). 0.8 a bit too loose.
                   // PLA: 0.4 (0.8 too large.)

SHELL_ERROR = 0.0; // if the speaker driver does not fit, make this larger.

// shape parameters
thick = 1.0;  // wall thickness
mink =  0.4;  // minkowski radius
spfn =  8;   // minkowski resolution

// inner size of the box
size_x = 30;
size_y = 36;
size_z = 36;
shell_r = 2;

lid_inner_x = 2.0; // thickness of lid inner part
lid_arm_r = 2.0;
lid_hole_y = 3.0;
lid_hole_z = 2.0;

// further customization example: make a hole on the front surface
// coordinates are from left-bottom edge of inner space

// speaker center hole
speaker_dia = 29; // speaker diameter
front_hole_r0 = speaker_dia/2;
front_spfn   = 64;  // minkowski resolution

// spaker mount holes at corners
MOUNT_DIA    = 39;  // mount holes layout diameter
front_hole_r = 1.2; // mount hole radius
mount_spfn   = 16;  // minkowski resolution
mount_mink   = 0.2;

// a hole on the lid side
lid_hole_y = 3;
lid_hole_z = 3;
lid_hole_r = 2;

//
// internals
//
WELDING = 0.1;

// render target; this is meant to be overriden by Makefile
TARGET="default";

//
// top level logic
//
b1s_main();

module b1s_main(target=TARGET){
    
    if (target == "default") {
        b1s(with_stand=1, with_print=1);
    }

    if (target == "with_stand") {
        b1s(with_print=1, with_stand=1);
    }

    if (target == "lid_only") {
        b1s(with_body=0, with_stand=0);
    }
}
    
// -------------------------
// Public Modules
// -------------------------

// [Public]
// Minimum size enclosure.
//
// with_print = { 0: edit layout, 1: print layout}
module b1s(with_print=1, with_stand=0, with_body=1, with_lid=1, with_hole=1){
    b1s_unit(40, 40, 40, with_print=with_print, with_stand=with_stand, with_body=with_body, with_lid=with_lid, with_hole=with_hole);
}

// [Public]
// Variable size enclosure. Typically to be embededd in another project.
// 
// ox, oy, oz = dimension (this has to be equals to or larger than (size_x, size_y, size_z).
// with_print = { 0: edit layout, 1: print layout}
module b1s_unit(ox, oy, oz, lid_thick=thick, with_print=1, shell_error=SHELL_ERROR, lid_error=LID_ERROR,
                  stand_height=40,
                  with_stand=0, with_hole=0, with_body=1, with_lid=1){
    if (with_print) {
        if (with_body) {
            translate([0, oy/2, ox/2]) {
                rotate([0, 90, 0]) {
                    b1s_unit_body_only(ox, oy, oz, shell_error=shell_error, with_stand=with_stand);
                }
            }
        }
        if (with_lid) {
            translate([-oy-3, oy/2, 0]) {
                rotate([0, -90, 0]) {
                    b1s_unit_lid_only(ox, oy, oz, lid_thick=lid_thick, shell_error=shell_error, lid_error=lid_error, with_hole=with_hole);
                }
            }
        }
        if (with_stand) {
            translate([oy+3, oy/2, 0]) {
                rotate([0,0,0]) {
                    speaker_stand(stand_z=40, base_x=(ox-2)*0.8, base_y=(oy-2)*0.8, base_z=4);
                }
            }
        }
    } else {
        b1s_unit_body_only(ox, oy, oz, shell_error=shell_error, with_stand=with_stand);
        translate([-ox,0,0]) {
            b1s_unit_lid_only(ox, oy, oz, lid_thick=lid_thick, shell_error=shell_error, lid_error=lid_error, with_hole=with_hole);
        }
        if (with_stand) {
            translate([40,0,0]) {
                rotate([0,90,0]) {
                    speaker_stand(stand_z=40, base_x=ox-2, base_y=oy-2, base_z=4);
                }
            }
        }
    }
}

// [Public]
// Variable size enclosure (body only). Typically for testing purpose.
// 
// ox, oy, oz = dimension (this has to be equals to or larger than (size_x, size_y, size_z).
module b1s_unit_body_only(ox, oy, oz, shell_error=SHELL_ERROR, with_stand=0){
    fn = 32;
    difference(){
        translate([0, 0, 0]) {
            prim_round_xplate0(ox, oy, oz, shell_r, fn);
        }
        translate([0, 0, 0])
            b1s_shell_negative_volume(sx=ox, sy=size_y, sz=size_z, st=thick, sr0=front_hole_r0, sr=front_hole_r, shr=shell_r, sf=fn, se=shell_error, with_stand=with_stand);
    }
}

// [Public]
// Variable size enclosure (lid only). Typically for testing purpose.
// 
// ox, oy, oz = dimension (this has to be equals to or larger than (size_x, size_y, size_z).
// with_hole  = { 0: without hole, 1: with hole } // a hole for cables
// with_arm   = { 0: without arm, 1: with arm }   // arms to support the speaker driver (experimental)
module b1s_unit_lid_only(ox, oy, oz, lid_thick=thick, with_hole=0, with_arm=0, shell_error=SHELL_ERROR, lid_error=LID_ERROR){
    // arm
    if (with_arm) {
        translate([0,0,0]) {
            b1s_lid_arm(ox, oy-thick*2, oz-thick*2, thick, lid_arm_r, spfn);
        }
    }

    // lid
    translate([lid_thick/2,0,0]) {
        difference(){
            b1s_lid_body(ox, oy, oz, size_x, size_y, size_z, lid_thick, lid_inner_x, mink, shell_r, spfn, se=shell_error, le=lid_error, with_hole=with_hole);
            b1s_lid_negative_volume(ox, oy-thick*2.1, oz-thick*2.1, size_x, size_y, size_z, lid_hole_y, lid_hole_z, lid_thick, lid_inner_x, mink, shell_r, spfn, with_hole=with_hole);
        }
            
    }
}


// -------------------------
// Private Modules
// -------------------------

// cube inner volume (negative volume. this part will be subtracted to make room for stuffings.)
module b1s_shell_negative_volume(sx, sy, sz, st, sr0, sr, shr, sf, se=SHELL_ERROR, with_stand=1) {
    translate([-thick,0,0]) {
        #prim_round_xplate0(sx, sy+se, sz+se, shr, sf);
    }

    // center speaker hole
    translate([sx/2, 0, 0]) {
        rotate([0, 90, 0]) {
            #cylinder(r = sr0, $fn = 64, h=st*3, center=true);
            }
    }

    dd = MOUNT_DIA/1.414/2; // 1.414 = sqrt(2); y- and z-axis distance from center to mount holes
    
    // corner mount holes
    translate([sx/2+st/2, 0, 0]) {
        for (ix=[-1,1]) {
            for (iy=[-1,1]) {
                translate([0, dd*ix, dd*iy]) {
                    rotate([0, 90, 0]) {
                        #cylinder(r = sr, $fn = 16, h = st*4, center=true);
                    }
                }
            }
        }
    }

    if (with_stand) {
        translate([0, 0, sz/2+st/2]) {
            #cylinder(r = 3, $fn = 32, h = st*4, center=true);
        }
    }

}

// experimental: arms to support speaker driver
module b1s_lid_arm(sx, sy, sz, st, sr, sf) {
    dx = 4;
    dy = sy/2-st-sr*1.1;
    dz = sz/2-st-sr*1.1;
    translate([-dx/2, 0, 0]) {
        for (iy=[-1,1]) {
            for (iz=[-1,1]) {
                translate([0, dy*iy, dz*iz]) {
                    rotate([0, 90, 0]) {
                        cylinder(r = sr, $fn = 16, h = sx-dx, center=true);
                    }
                }
            }
        }
    }
}

module b1s_lid_body(ox, oy, oz, sx, sy, sz, st, lt, sr, shr, sf, se=SHELL_ERROR, le=LID_ERROR, with_hole=0) {
    fn = 32;
    // outer
    prim_round_xplate0(st, oy, oz, shr, fn);

    // inner
    translate([lt-WELDING,0,0]) {
        difference(){
            prim_round_xplate0(lt*2, sy-le+se, sz-le+se, shr, fn);
            translate([WELDING,0,0]) {
                prim_round_xplate0(lt*2+WELDING, sy-st-le+se, sz-st-le+se, shr, fn);
            }
        }
    }
}


module b1s_lid_negative_volume(ox, oy, oz, sx, sy, sz, hy, hz, st, lt, sr, shr, sf, with_hole=1) {
    y3 = 6; // 3-cable width (22 AWG)
    y2 = 4.5; // 2-cable width (22 AWG)
    z1 = 3.2; // 1-cable height (22 AWG)

    // cable hole
    if (with_hole) {
        translate([lt,-sy*0.3,-sz*0.3]) {
            #prim_round_xplate0(lt*3, y2, z1, 1, 16);
        }
    }
}

