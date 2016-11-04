//
// "Compo" Tiny Audio System
//
// by Yasuhiro Wabiko
//
// This work is licensed under a Creative Commons Attribution 4.0 International License.
// https://creativecommons.org/licenses/by/4.0/
//

use <CE32A_Rev1.scad>
use <PAM8403.scad>
use <MAX98306.scad>
use <audiojack.scad>
use <microusb.scad>
use <btaudio.scad>
use <prim.scad>

speaker_x = 40;
speaker_y = 36;
speaker_z = 36;
amp_x = 40;
amp_y = 36;
amp_z = 36;
audiojack_y = 12.4;
audiojack_z = 12;
microusb_y = 20.6+2;
microusb_z = 8+2;
shell_t = 1;    // shell thickness
screw_hole_x = 6;
screw_hole_y = 6;
btaudio_x = 45;


// render target; this is meant to be overriden by Makefile
TARGET="btaudio";

//
// top level logic
//
compo_main();

module compo_main(target=TARGET){
    
    if (target == "default") {
        compo(amp_type=0); // PAM8403
    }

    if (target == "max98306") {
        compo(amp_type=1);
    }

    if (target == "btaudio") {
        compo(amp_type=1, with_btaudio=1, with_lid=1, with_print=1);
    }

    if (target == "btaudio_lid_test") {
        compo(amp_type=1, with_btaudio=1, with_lid=1, with_body=0, with_print=1);
    }

    if (target == "lid_test") {
        rotate([0,-90,0])
            compo_lid();
    }
    
    if (target == "screw_test") {
        translate([0,-speaker_y-20,0])
        compo(amp_type=0, with_min=1); // PAM8403, amp part only
    }

    if (target == "screw_test_amp1") {
        translate([0,-speaker_y,0])
        compo(amp_type=1, with_min=1); // MAX98306, amp part only
    }

    if (target == "lid_screw_test") {
        rotate([0,-90,0])
            compo_lid(with_min=1);
    }
    
}


// -------------------------
// Public Modules
// -------------------------

// [Public]
// Minimum size enclosure.
// amp_type = { 0: PAM8403, 1:MAX98306 }
// with_print = { 1: print layout (models are rotated to be printable), 0: edit layout (no rotation) }
module compo(amp_type=0, with_print=1, with_min=0, with_btaudio=0, with_body=1, with_lid=1) {
    if (with_print) {
        if (with_body) {
            translate([5,0,0]) {
                rotate([0,90,0]) {
                    compo_body(amp_type=amp_type, with_min=with_min, with_btaudio=with_btaudio);
                }
            }
        }
        if (with_lid) {
            translate([0,0,0]) {
                rotate([0,-90,0]) {
                    compo_lid(amp_type=amp_type, with_min=with_min, with_btaudio=with_btaudio);
                }
            }
        }
    } else {
        if (with_body) {
            translate([speaker_x*2+5,0,0]) {
                compo_body(amp_type=amp_type, with_min=with_min, with_btaudio=with_btaudio);
            }
        }
        if (with_lid) {
            translate([0,0,0]) {
                compo_lid(amp_type=amp_type, with_min=with_min, with_btaudio=with_btaudio);
            }
        }
    }
}


// -------------------------
// Private Modules
// -------------------------

// amp_type = { 0: PAM8403, 1:MAX98306 }
module compo_body(amp_type=0, with_min=0, with_btaudio=0){
    difference(){
        compo_body_shell(amp_type=amp_type, with_min=with_min, with_btaudio=with_btaudio);
        #compo_body_negative_volume(0);
    }
}

module compo_lid(amp_type=0, with_min=0, with_btaudio=0){
    difference(){
        compo_lid_shell(amp_type=amp_type, with_min=with_min, with_btaudio=with_btaudio);
//        translate([1.2,0,0])
//        #compo_body_negative_volume(30);
    }
}

// amp_type = { 0: PAM8403, 1:MAX98306 }
module compo_body_shell(amp_type=0, with_min=0, with_btaudio=0){
    shell_x = with_btaudio ? btaudio_x : speaker_x;
    if (!with_min) {
        // left speaker
        translate([-shell_x/2, speaker_y/2, speaker_z/2])
            ce32a_unit_body_only(shell_x, speaker_y, speaker_z);
    }

    // amp complex with audio jack and micro usb jack
    translate([-amp_x/2-2.5, speaker_y+amp_y/2, amp_z/2])  {
        if (amp_type == 0) {
            pam8403_unit(ox=shell_x, oy=amp_y, oz=amp_z, with_vent=0, with_cabling=1, with_lid=0, with_shell=1, with_holder=1, with_side=1, with_print=0);
        }
        if (amp_type == 1) {
            max98306_unit(ox=shell_x, oy=36, oz=36, dz=8, with_cabling=1, with_vent=0, with_holder=1, with_shell=1, with_lid=0, with_cut=0, with_support=0, with_print=0);
        }
    }

    if (with_btaudio) {
        translate([0, speaker_y+amp_y/2, 0])  {
            btaudio_unit();
        }
    } else {
        translate([0, speaker_y+shell_t+audiojack_y/2, audiojack_z/2])
            audiojack_unit(amp_x, with_lid=0);
        translate([0, speaker_y+amp_y-microusb_y/2, microusb_z/2])
            microusb_unit(40, with_vent=1, with_cabling=1, with_shell=0, with_cut=1, with_screw=1);
    }
        
    if (!with_min) {
    // right speaker
    translate([-shell_x/2, speaker_y+amp_y+speaker_y/2, speaker_z/2])
        ce32a_unit_body_only(shell_x, speaker_y, speaker_z);
    }    
}

module compo_lid_shell(amp_type=0, with_min=0, with_btaudio=0){

    if (!with_min) {
    // left spaker's lid
    translate([0, speaker_y/2, speaker_z/2]) {
        ce32a_unit_lid_only(speaker_x,  speaker_y, speaker_z, lid_thick=2, with_hole=0);
    }
}
    
    // amp's lid
    difference(){
        translate([0, speaker_y+amp_y/2, amp_z/2]) {
//            if (amp_type==0) {
            need_arm = with_btaudio ? 0 : 1;
            pam8403_unit_lid_only(ox=amp_x, oy=amp_y, oz=amp_z, with_vent=0, with_cabling=1, with_lid=0, with_shell=0, with_holder=0, with_hole=0, with_vent_lid=1, lid_thick=2, with_arm=need_arm, with_vent_style=1);
//            } else {
//                max98306_unit(ox=amp_x, oy=amp_y, oz=amp_z, dz=8, with_cabling=1, with_vent=1, with_holder=1, with_shell=0, with_lid=1, with_cut=0, with_support=0);
//            }

        }
        union(){
            if (with_btaudio) {
                translate([0, speaker_y+amp_y/2, 0]) {
                    #btaudio_unit_lid_negative_volume();
                }
            } else {
                // audio jack hole
                translate([0, speaker_y+shell_t+audiojack_y/2, audiojack_z/2]) {
                    rotate([180,0,0]) audiojack_unit_lid_negative_volume(amp_x, with_lid=1);
                }
                // microusb hole
                translate([1, speaker_y+amp_y-microusb_y/2, microusb_z/2]) {
                    microusb_unit_lid_negative_voume(with_screw=1, with_scale=1, scale_factor=2.0);
                }
                // remove lid inner support to accomodate audio jack shell
                translate([4, speaker_y+amp_y/4+1, 0]) {
                    #prim_round_xplate0(4, amp_y/2, 20, 1, 32);
                }
                // remove lid inner support to accomodate microusb shell
                translate([4, speaker_y+amp_y-3, 0]) {
                    #prim_round_xplate0(4, 6, 28, 1, 32);
                }
            }
        }
    }
    
    if (!with_min) {
    // right speaker's lid
    translate([0, speaker_y+amp_y+speaker_y/2, speaker_z/2]) {
        ce32a_unit_lid_only(speaker_x, speaker_y, speaker_z, lid_thick=2, with_hole=0);
    }
    }
}


module compo_body_negative_volume(dh){
    translate([-speaker_x, speaker_y+amp_y/2, speaker_z*0.8])
        #compo_cable_hole(dh);
//    translate([-28, 36+36/2+0.5, 18])
//        #prim_round_zplate0(6, 27, 4, 0.4, 8);
//    translate([-20, 36+36/2+7, 8])
//        #prim_round_zplate0(22, 18, 4, 0.4, 8);
}


module compo_cable_hole(dh){
    hull(){
        rotate([90,0,0])
            cylinder(r=1.6, h=80, $fn=16, center=true);
        translate([2+dh,0,0])
            rotate([90,0,0])
            cylinder(r=1.6, h=80, $fn=16, center=true);
    }
}
