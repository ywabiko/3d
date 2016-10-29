//
// Aura NSW1-205 1" Speaker Enclosure Rev.1
//
// by Yasuhiro Wabiko
//
// This work is licensed under a Creative Commons Attribution 4.0 International License.
// https://creativecommons.org/licenses/by/4.0/
//
use <speaker_stand.scad>
use <prim.scad>

// printer error related tweaks
LID_ERROR   = 0.0; // if the lid does not fit, make this larger.
                   // Wood PLA: 0.8 (0.1-0.4 too small). 0.8 a bit too loose.
                   // PLA: 0.0 (0.8 too large.)

SHELL_ERROR = 0.0; // if the speaker driver does not fit, make this larger.

// shape parameters
wall_t = 1.0;  // wall wall_tness
spfn =  8;   // minkowski resolution

// inner size of the box
size_x = 40;
size_dx = 10; // extra front wall thickness inside size_x
size_y = 38.8;
size_z = 38.8;

// outer size of the box
shell_x = 46;
shell_y = 42;
shell_z = 42;
shell_r = 2;
    

lid_inner_x = 2.0; // thickness of lid inner part
lid_wall_t = 2.0;
lid_arm_r = 2.0;
lid_hole_y = 3.0;
lid_hole_z = 2.0;

// further customization example: make a hole on the front surface
// coordinates are from left-bottom edge of inner space

// speaker center hole
speaker_dia = 36.6; // speaker diameter
front_hole_r0 = speaker_dia/2;
front_spfn   = 64;  // minkowski resolution

// spaker mount holes at corners
MOUNT_DIA    = 43;  // mount holes layout diameter
front_hole_r = 2; // mount hole radius
mount_spfn   = 16;  // minkowski resolution

// a hole on the lid side
lid_hole_y = 3;
lid_hole_z = 3;
lid_hole_r = 2;

//
// internals
//
WELDING = 0.1;

// render target; this is meant to be overriden by Makefile
TARGET="unit_lid_test";

//
// top level logic
//
aura205_main();

module aura205_main(target=TARGET){
    
    if (target == "default") {
        aura205(with_stand=0, with_print=1);
    }

    if (target == "body_only") {
        rotate([0, 90, 0]) {
            aura205_unit_body_only(shell_x, shell_y, shell_z, with_stand=1);
        }
    }

    if (target == "with_stand") {
        aura205(with_stand=1, with_print=1);
    }

    if (target == "stand_only") {
        oy=36;
        translate([-oy-3, -oy/2+3, 0]) {
            aura205_unit_stand();
        }
    }

    if (target == "unit_test") {
        translate([40,0,0]) {
            aura205_unit_body_only(shell_x, shell_y, shell_z);
        }
        aura205_unit_lid_only(shell_x,  shell_y, shell_z, with_hole=0);
    }

    if (target == "unit_lid_test") {
        rotate([0,-90,0]) {
            aura205_unit_lid_only(shell_x, shell_y, shell_z, lid_wall_t=2, with_hole=1);
        }
    }

    if (target == "stand_test") {
        translate([0, 3, 0]) {
            aura205_unit_stand();
        }
    }

    if (target == "joint_test") {
        // render small joint only for joint testing
        translate([3,0,0]) {
            aura205_unit_stand();
        }
    }
    
}


// -------------------------
// Public Modules
// -------------------------

// [Public]
// Minimum size enclosure.
//
// with_print = { 0: edit layout, 1: print layout}
module aura205(with_print=1, with_stand=0, with_lid=1){
    aura205_unit(ox=shell_x, oy=shell_y, oz=shell_z, with_print=with_print, with_hole=1, with_stand=with_stand, with_lid=with_lid);
}

// [Public]
// Variable size enclosure. Typically to be embededd in another project.
// 
// ox, oy, oz = dimension (this has to be equals to or larger than (size_x, size_y, size_z).
// with_print = { 0: edit layout, 1: print layout}
module aura205_unit(ox, oy, oz, lid_wall_t=lid_wall_t, with_print=1, shell_error=SHELL_ERROR, lid_error=LID_ERROR,
                  stand_height=40,
                  with_stand=0, with_hole=0, with_body=1, with_lid=1){
    if (with_print) {
        if (with_body) {
            translate([0, oy/2, ox/2]) {
                rotate([0, 90, 0]) {
                    aura205_unit_body_only(ox=ox, oy=oy, oz=oz, shell_error=shell_error, with_stand=with_stand, with_hole=with_hole);
                }
            }
        }
        if (with_lid) {
            translate([-oy-3, oy/2, 0]) {
                rotate([0, -90, 0]) {
                    aura205_unit_lid_only(ox, oy, oz, lid_wall_t=lid_wall_t, shell_error=shell_error, lid_error=lid_error, with_hole=with_hole);
                }
            }
        }
        if (with_stand) {
            translate([oy+3, oy/2, 0]) {
                rotate([0,0,0]) {
                    aura205_unit_stand(stand_z=40, base_x=(ox-2)*0.8, base_y=(oy-2)*0.8, base_z=4);
                }
            }
        }
    } else {
        aura205_unit_body_only(ox=ox, oy=oy, oz=oz, shell_error=shell_error, with_stand=with_stand);
        translate([-ox,0,0]) {
            aura205_unit_lid_only(ox, oy, oz, lid_wall_t=lid_wall_t, shell_error=shell_error, lid_error=lid_error, with_hole=with_hole);
        }
        if (with_stand) {
            translate([40,0,0]) {
                rotate([0,90,0]) {
                    aura205_unit_stand(stand_z=40, base_x=(ox-2)*2, base_y=(oy-2)*2, base_z=4);
                }
            }
        }
    }
}

module aura205_unit_stand(stand_z=40, base_x=36, base_y=36, base_z=4){
    speaker_stand(stand_z=stand_z, base_x=base_x, base_y=base_y, base_z=base_z);
}

// [Public]
// Variable size enclosure (body only). Typically for testing purpose.
// 
// ox, oy, oz = dimension (this has to be equals to or larger than (size_x, size_y, size_z).
module aura205_unit_body_only(ox, oy, oz, shell_error=SHELL_ERROR, with_stand=0){
    fn = 32;
    difference(){
        translate([0, 0, 0]) {
            prim_round_xplate0(ox, oy, oz, shell_r, fn);
        }
        translate([-size_dx, 0, 0])
            aura205_shell_negative_volume(sx=ox, sy=size_y, sz=size_z, dx=size_dx, st=wall_t, sr0=front_hole_r0, sr=front_hole_r, shr=shell_r, sf=fn, se=shell_error, with_stand=with_stand);
    }
}

// [Public]
// Variable size enclosure (lid only). Typically for testing purpose.
// 
// ox, oy, oz = dimension (this has to be equals to or larger than (size_x, size_y, size_z).
// with_hole  = { 0: without hole, 1: with hole } // a hole for cables
// with_arm   = { 0: without arm, 1: with arm }   // arms to support the speaker driver (experimental)
module aura205_unit_lid_only(ox, oy, oz, lid_wall_t=wall_t, with_hole=0, with_arm=0, shell_error=SHELL_ERROR, lid_error=LID_ERROR){
    // arm
    if (with_arm) {
        translate([0,0,0]) {
            aura205_lid_arm(ox, oy-wall_t*2, oz-wall_t*2, wall_t, lid_arm_r, spfn);
        }
    }

    // lid
    translate([lid_wall_t/2,0,0]) {
        difference(){
            aura205_lid_body(ox=ox, oy=oy, oz=oz, sx=size_x, sy=size_y, sz=size_z, st=wall_t, lix=lid_inner_x, lt=lid_wall_t, sr=shell_r, shr=shell_r, sf=spfn, se=shell_error, le=lid_error, with_hole=with_hole);
            aura205_lid_negative_volume(ox=ox, oy=oy-wall_t*2.1, oz=oz-wall_t*2.1, sx=size_x, sy=size_y, sz=size_z, hy=lid_hole_y, hz=lid_hole_z, lix=lid_inner_x, lt=lid_wall_t, with_hole=with_hole);
        }
            
    }
}


// -------------------------
// Private Modules
// -------------------------

// cube inner volume (negative volume. this part will be subtracted to make room for stuffings.)
module aura205_shell_negative_volume(sx, sy, sz, dx, st, sr0, sr, shr, sf, se=SHELL_ERROR, with_stand=1) {
    translate([-wall_t,0,0]) {
        #prim_round_xplate0(sx, sy+se, sz+se, shr, sf);
    }

    // center speaker hole
    translate([sx/2, 0, 0]) {
        rotate([0, 90, 0]) {
            #cylinder(r = sr0, $fn = 64, h=st*3+dx*2, center=true);
            }
    }

    dd = MOUNT_DIA/1.414/2; // 1.414 = sqrt(2); y- and z-axis distance from center to mount holes
    
    // corner mount holes
    translate([sx/2+st/2, 0, 0]) {
        for (ix=[-1,1]) {
            for (iy=[-1,1]) {
                translate([0, dd*ix, dd*iy]) {
                    rotate([0, 90, 0]) {
                        #cylinder(r = sr, $fn = 16, h = st*4+dx*2, center=true);
                    }
                }
            }
        }
    }

    if (with_stand) {
        translate([dx, 0, sz/2+st/2]) {
            #cylinder(r = 3, $fn = 32, h = st*4, center=true);
        }
    }

}

// experimental: arms to support speaker driver
module aura205_lid_arm(sx, sy, sz, st, sr, sf) {
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

module aura205_lid_body(ox, oy, oz, sx, sy, sz, st, lix, lt, sr, shr, sf, se=SHELL_ERROR, le=LID_ERROR, with_hole=0) {
    fn = 32;
    // outer
    prim_round_xplate0(lt, oy, oz, shr, fn);

    // inner
    translate([lt/2+lix/2-WELDING,0,0]) {
        difference(){
            prim_round_xplate0(lix, sy+se-le, sz+se-le, shr, fn);
            translate([WELDING,0,0]) {
                prim_round_xplate0(lix+WELDING, sy+se-le-lt*2, sz+se-le-lt*2, shr, fn);
            }
        }
    }
}


module aura205_lid_negative_volume(ox, oy, oz, sx, sy, sz, hy, hz, lt, with_hole=1) {
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

