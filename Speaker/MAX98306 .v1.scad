//
// Adafruit MAX98306 3.7W Stereo Amplifier Board Enclosure
//
// by Yasuhiro Wabiko
//
// This work is licensed under a Creative Commons Attribution 4.0 International License.
// https://creativecommons.org/licenses/by/4.0/
//

use <prim.scad>

// inner size of the box.
// typically, (x,y) = board size, z depends on how much space you need for cabling.
//
size_x = 24+0.1;
size_y = 28+0.1;
size_z = 10;

// holder dimensions
holder_thick = 1; // thickness
holder_r     = 1; // radius in minkowski transform
shell_thick = 1; // thickness

// board parameters
board_thick      = 2.0;    // board thickness, typically 2mm
arm_thick        = 1.5;    // arm thickness (overhang)
arm_up_z         = 2;      // arm upper part height (in z-axis)
arm_low_z        = 2;      // arm upper part height (in z-axis)
arm_center_thick = 0.6;
arm_center_up_y  = size_y; // arm (center) upper part width
arm_center_low_y = size_y; // arm (center) lower part width
arm_left_up_x    = size_x; // arm (left) upper part height
arm_left_low_x   = size_x; // arm (left) lower part height
arm_right_up_x   = 6;      // arm (right) upper part height
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


// render target; this is meant to be overriden by Makefile
TARGET="compo_lid_test";

//
// top level logic
//
max98306_main();

module max98306_main(target=TARGET){
    
    if (target == "default") {
        max98306(with_vent=1, with_cabling=0, with_holder=1, with_print=1);
    }

    if (target == "novent") {
        max98306(with_vent=0, with_holder=1, with_lid=1, with_print=1);
    }

    if (target == "unit_test") {
        max98306_unit(ox=40, with_cabling=1, with_vent=1, with_holder=0, with_lid=0, with_cut=0, with_support=1);
    }

    if (target == "unit_lid_test") {
        max98306_unit(ox=40, with_cabling=1, with_vent=1, with_holder=0, with_lid=1, with_body=0, with_cut=0, with_support=1);
    }

    if (target == "compo_test") {
        max98306_unit(ox=40, oy=36, oz=36, dz=8, with_cabling=1, with_vent=1, with_holder=1, with_shell=1, with_lid=1, with_cut=0, with_support=0);
    }

    if (target == "compo_body_test") {
        max98306_unit(ox=40, oy=36, oz=36, dz=8, with_cabling=1, with_vent=1, with_holder=1, with_shell=1, with_lid=0, with_cut=0, with_support=0);
    }

    if (target == "compo_lid_test") {
        max98306_unit(ox=40, oy=36, oz=36, dz=8, with_cabling=1, with_vent=1, with_holder=0, with_shell=0, with_lid=1, with_body=0, with_cut=0, with_support=0);
    }

}


// -------------------------
// Public Modules
// -------------------------

// [Public]
// Minimum size enclosure.
//
// with_vent = { 1: with ventilation slits, 0: without ventilation slits }
// with_lid  = { 1: render the lid, 0: does not render the lid }
// with_cabling = { 1: render a big openings on the enclosure for easier cabling, 0: without such openings }
// with_holder = { 1: render the holder (minimum enclosure that matches the board size). 0: does not render the holder.}
// with_shell =  { 1: render the shell (outermost enclosure that matches the requested dimension). 0: does not render the shell.}
// with_print = { 1: print layout (models are rotated to be printable), 0: edit layout (no rotation) }
// with_open_roof = { 1: make a big opening on the 'roof' part (for debugging), 0: do not do that }
module max98306(with_vent=1, with_lid=1, with_cabling=0, with_holder=1, with_shell=0, with_print=0, with_open_roof=0){

    if (with_print) {
        rotate([0,-90,0])
            translate([size_x/2+holder_thick+lid_inner_x/2, 0, 0])
            max98306_body(with_vent=with_vent, with_lid=with_lid, with_cabling=with_cabling, with_holder=with_holder, with_open_roof=with_open_roof);
        if (with_lid) {
            translate([size_z+holder_thick*2+SHELL_LID_DIST,0,0])
                rotate([0,90,0])
                max98306_lid(sx=size_x, sy=size_y, sz=size_z, wr=holder_r, wt=holder_thick, lox=lid_outer_x, lix=lid_inner_x,
                             fns=spfn_small, fnm=spfn_medium, fnl=spfn_large);
        }
    } else {
        // debug
        translate([0, 0, 0]) {
            // debug
            difference() {
                union() {
                    translate([0, 0, 0])
                        max98306_body(with_vent=with_vent, with_lid=with_lid, with_cabling=with_cabling, with_holder=with_holder, with_open_roof=with_open_roof);
                    if (with_lid) {
                        max98306_lid(sx=size_x, sy=size_y, sz=size_z, wr=holder_r, wt=holder_thick, lox=lid_outer_x, lix=lid_inner_x,
                                     fns=spfn_small, fnm=spfn_medium, fnl=spfn_large);
                    }
                }
                // debug
                translate([-size_x/2, size_y/2+holder_thick/2, 0]) {
                    //#cube([size_x*4, holder_thick, arm_z], center=true);
                }
            }
        }
    }
}

// [Public]
// Variable size enclosure(in x-axis only). Typically to be embededd in another project.
// 
// ox, oy, oz = dimension (this has to be equals to or larger than (size_x, size_y, size_z).
//   - ox is used when with_support=1.
//   - oy and oz are used only when with_shell=1.
// with_vent = { 1: with ventilation slits, 0: without ventilation slits }
// with_lid  = { 1: render the lid, 0: does not render the lid }
// with_cabling = { 1: render a big openings on the enclosure for easier cabling, 0: without such openings }
// with_holder = { 1: render the shell (outermost enclosure that matches the requested dimension). 0: does not render the shell.}
// with_shell =  { 1: render the shell (outermost enclosure that matches the requested dimension). 0: does not render the shell.}
// with_print = { 1: print layout (models are rotated to be printable), 0: edit layout (no rotation) }
// with_open_roof = { 1: make a big opening on the 'roof' part (for debugging), 0: do not do that }
module max98306_unit(ox=0, oy=0, oz=0, dz=0, with_vent=0, with_lid=1, with_body=1, with_cabling=0, with_holder=1, with_shell=0, with_support=1, with_arm=1, with_open_roof=0, with_cut=0) {
    bx = size_x + with_holder*holder_thick + lid_inner_x; // body size
    sx = ox - bx;
    dtx = (1-with_support)*(sx-holder_thick/2); // when no support, align the holder to the front.
    echo (bx=bx);
//    translate([0,-size_y/2+arm_thick,-1-WELDING]) { // debug
    translate([0,0,0]) {
//        rotate([0,0,0]) 
        rotate([0,0,180]) 
        {
            if (with_shell) {
                max98306_shell(ox=ox, oy=oy, oz=oz, st=shell_thick, with_vent=with_vent, with_cabling=with_cabling);
            }

            if (with_body) {
                translate([-dtx, 0, dz]) { // X-axis: when no support, align the holder to the front. Z-axis: requested by the caller.
                    max98306_unit_with_support(ox=ox, sh=sx, with_vent=with_vent, with_cabling=with_cabling, with_holder=with_holder, with_support=with_support, with_arm=with_arm, with_open_roof=with_open_roof, with_cut=with_cut);
                }
            }
            if (with_lid) {
                translate([-ox/2-size_z/2-5,0,0]) {
                    max98306_unit_lid_only();
                }
            }

        }
    }
}
    
module max98306_shell(ox, oy, oz, st, with_vent=1, with_cabling=1) {
    shell_thick = 1;
    difference() {
        prim_round_xplate0(ox, oy, oz, 1, 32);
        //translate([0,0,0]) { // debug
        translate([shell_thick,0,0]) {
            prim_round_xplate0(ox+WELDING, oy-shell_thick, oz-shell_thick, 1, 32);
        }
        max98306_shell_negative_volume(ox, oy, oz, shell_thick, with_vent, with_cabling);
    }
}

// [Public]
// Lid
module max98306_unit_lid_only() {
    rotate([0,0,180]) {
        max98306_lid(sx=size_x, sy=size_y, sz=size_z, wr=holder_r, wt=holder_thick, lox=lid_outer_x, lix=lid_inner_x,
                     fns=spfn_small, fnm=spfn_medium, fnl=spfn_large);
    }
}

// [Public]
// Negative volume of lid that can be shared with the outer model (useful when you are embedding this model in another project).
module max98306_unit_lid_negative_voume() {
    rotate([0,0,180]) {
        translate([-lid_outer_x, 0, 0]) {
            translate([lid_outer_x/2,0,0]) {// centering to match with positive volume
                #max98306_lid_negative_volume(size_x, size_y, size_z, holder_r, holder_thick,
                                             spfn_small, spfn_medium, spfn_large);
            }
        }
    }
}

// -------------------------
// Private Modules
// -------------------------

module max98306_shell_negative_volume(sx, sy, sz, st, with_vent, with_cabling) {
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

module max98306_body(with_vent=0, with_lid=0, with_cabling=0, with_holder=0, with_arm=1, with_open_roof=0){
    dx = (with_cabling)*lid_inner_x;
    union() {
        difference() {
            union() {
                cube([0,0,0]); // dummy cube to make difference() work regardless of conditions
                if (with_holder){
                    max98306_holder(sx=size_x, sy=size_y, sz=size_z, wr=holder_r, wt=holder_thick,
                                   fns=spfn_small, fnm=spfn_medium, fnl=spfn_large, with_open_roof=with_open_roof);
                }
                // side support. (if with_holder=1, it is embedded inside shell, so invisible.)
                for (i=[-1,1]) {
                    //translate([-size_x/2-holder_thick*2+WELDING_SMALL+arm_left_up_x/2, (-size_y/2-holder_thick+WELDING_SMALL)*i, -board_thick]) {
                    //cube([arm_left_up_x, WELDING_SMALL*2, arm_z], center=true);
                    //}
                }
            }
            union() {
                if (with_holder) {
                    max98306_holder_negative_volume(sx=size_x, sy=size_y, sz=size_z, wr=holder_r, wt=holder_thick,
                                                   fns=spfn_small, fnm=spfn_medium, fnl=spfn_large, with_vent=with_vent, with_cabling=with_cabling, with_holder=with_holder);
                }
            }
        }

        if (with_arm) {
            translate([0,0,-holder_thick]){
                max98306_holder_arm(size_x, size_y, size_z, holder_r, holder_thick,
                                   spfn_small, spfn_medium, spfn_large);
            }
        }
    }
}


module max98306_unit_with_support(ox=size_x, sh=0, with_vent=0, with_cabling=0, with_holder=0, with_support=1, with_arm=1, with_open_roof=0, with_cut=0) {
    bx = size_x + with_holder*holder_thick + lid_inner_x; // body size
    // when (!with_cut), match height with shell dimension
    dz = holder_thick*2*(1-with_cut);
    dx = (1-with_holder)*holder_thick;
    esh = sh; // effective support height
    echo(esh=esh);
    echo(with_support=with_support);
    // centering
//     translate([ox/2,0,0])
     translate([bx/2+esh-(bx+esh)/2,0,0]) // centering
//     translate([-lid_inner_x+(bx+esh)/2,0,size_z/2+holder_thick])
    {
        difference() { // cut unnecessary welding at the top and bottom
            union() {
                if (with_support) {
                    // support structure
                    difference(){
                        translate([-bx/2-esh/2, 0, 0]) {
                            prim_round_xplate0(esh, size_y+holder_thick*2, size_z+holder_thick*2, 1, spfn_medium);
                        }
                        translate([-esh-size_x/2-WELDING_SMALL, 0, 0]) {
                            //#prim_round_xplate0(size_x+WELDING_SMALL*2, size_y, size_z+WELDING, 0.1, spfn_medium);
                        }
                    }
                }

                translate([0,0,0]) {
                    cube([0,0,0],center=true);// dummy
                    max98306_body(with_vent=with_vent, with_cabling=with_cabling, with_holder=with_holder, with_arm=with_arm, with_open_roof=with_open_roof);
                    }

            }
            union() { // cut unnecessary parts at the top and bottom
                cube([0,0,0]); // dummy
                if (with_cut) {
                    // bottom
                    translate([-(size_x+esh)/2, 0, -arm_z-holder_thick*2]) {
                        #cube([size_x+esh, size_y+holder_thick*4, arm_z], center=true);
                    }
                    // top
                    translate([-(size_x+esh)/2, 0, arm_z-holder_thick*2]) {
                        #cube([size_x+esh, size_y+holder_thick*4, arm_z], center=true);
                    }
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
module max98306_holder(sx, sy, sz, wr, wt,
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

module max98306_holder_arm(sx, sy, sz, wr, wt,
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
        translate([-wt*2, 0, -sz/2+wt+arm_low_z/2-WELDING/2+dz]){

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



module max98306_holder_negative_volume(sx, sy, sz, wr, wt,
                                      fns, fnm, fnl, with_vent=0, with_cabling=0, with_holder=0){
    with_cabling_top = with_cabling;
    with_cabling_bottom = 0;

    // cable hole at the top of shell
    if (with_cabling_top) {
        translate([0, 0, sz/2])
            prim_round_zplate0(sx*2, sy*2, sz*0.5, 1, fnm);
    }

    // cable hole at the bottom of shell
    if (with_cabling_bottom) {
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
    if (with_holder) {
        translate([-sx/2-wt, 0, -sz/2+arm_low_z+board_thick/2]) {
            //prim_round_xplate0(wt*2+4, 16, board_thick, 0.1, fnm);
        }
    }
}


module max98306_lid(sx, sy, sz, wr, wt, lox, lix,
                      fns, fnm, fnl){
    translate([-lox, 0, 0])
    difference(){
        max98306_lid_body(sx, sy, sz, wr, wt,
                          fns, fnm, fnl);
        union() {
            translate([lid_outer_x/2,0,0]) { // centering to match with positive volume
                max98306_lid_negative_volume(sx=sx, sy=sy, sz=sz, wr=wr, wt=wt, lox=lox,
                                             fns=fns, fnm=fnm, fnl=fnl);
                max98306_lid_negative_volume_private(sx=sx, sy=sy, sz=sz, wr=wr, wt=wt, lox=lox, lix=lix,
                                                     fns=fns, fnm=fnm, fnl=fnl);
            }
        }
    }
}

module max98306_lid_body(sx, sy, sz, wr, wt,
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
module max98306_lid_negative_volume(sx, sy, sz, wr, wt, lox,
                                    fns, fnm, fnl){
    // speaker out
    for (i=[-1,1]) {
        translate([0,i*(sy*0.2),3.1]) {
            #prim_round_xplate(lox+WELDING*2, 4, 2.2, wr, fnm);
        }
    }    

    // power in 
    translate([0,-(sy*0.3),0]) {
        #prim_round_xplate(lox+WELDING*2, 2.54*2, 2.2, wr, fnm);
    }
    
    // audio in
    translate([0,+(sy*0.1),0]) {
        #prim_round_xplate(lox+WELDING*2, 2.54*3, 2.2, wr, fnm);
    }

}

// with lid inner
module max98306_lid_negative_volume_private(sx, sy, sz, wr, wt, lox, lix,
                                    fns, fnm, fnl){

    // slit to accomodate board edge
    translate([-lox-lix/2, 0, -sz/2+arm_low_z+board_thick/2]) {
        #prim_round_xplate(lox+WELDING*2, sy, 2, 0.2, fnm);
    }
        
}
