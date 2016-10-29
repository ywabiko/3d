//
// CE32A 1" Speaker Enclosure Type3 Rev.1
//
// by Yasuhiro Wabiko
//
// This work is licensed under a Creative Commons Attribution 4.0 International License.
// https://creativecommons.org/licenses/by/4.0/
//

use <prim.scad>

print_ready_layout = 1;
render_open_roof = 1;
render_outer_shell = 1;


size_x = 26;
size_y = 32;
size_z = 32;
shell_r = 1;
shell_thick = 1;
driver_r = 29/2;
arm_thick = 0.4; // x-axis
arm_height = 4;  // y-axis or y-zxis
arm_depth = 2;  // z-axis or y-zxis
// spaker mount holes at corners
mount_dia    = 35;  // mount holes layout diameter

lid_inner_z = 2.0; // thickness of lid inner part
FN_LARGE = 64;
FN_MEDIUM = 32;
WELDING = 0.4;

//ce32a_body();
//ce32a_unit(36,36,36);
ce32a_unit(34,34,34); // minimum size

module ce32a_body() {
    difference() {
        ce32a_shell(size_x, size_y, size_z, shell_thick, shell_r);
        #ce32a_shell_negative_volume(size_x, size_y, size_z, shell_thick, shell_r, driver_r);
    }
    ce32a_shell_arm(size_x, size_y, size_z, shell_thick, shell_r, arm_height, arm_depth);
}

module ce32a_unit(order_x, order_y, order_z) {
    ce32a_unit_body_only(order_x, order_y, order_z);
    ce32a_unit_lid_only(order_x, order_y, order_z);
}

module ce32a_unit_body_only(order_x, order_y, order_z) {
    if (print_ready_layout) {
        translate([0, order_y/2, order_z])
        rotate([0,180,180])
            ce32a_unit_body(order_x, order_y, order_z);
    } else {
        ce32a_unit_body(order_x, order_y, order_z);
    }
}

module ce32a_unit_lid_only(order_x, order_y, order_z) {
    if (print_ready_layout) {
        translate([-order_x, order_y/2, 0])
            ce32a_unit_lid(order_x, order_y, order_z);
    } else {
        translate([-order_x,0,0])
            ce32a_unit_lid(order_x, order_y, order_z);
    }
}


module ce32a_unit_body(order_x, order_y, order_z) {

    ox = order_x - shell_thick*2;
    oy = order_y - shell_thick*2;
    oz = order_z - shell_thick*2;

    
    translate([0,0,oz/2+shell_thick])
    {
        if (render_outer_shell) {
            // outer shell to meet order
            translate([-ox/2-shell_thick,0,0]) {
                difference() {
                    difference() {
                        ce32a_shell(ox, oy, oz, shell_thick, shell_r);
                        // open front so that inner shell takes care of driver/mount holes
                        translate([ox/2,0,0])
                            prim_round_xplate(shell_thick*2, size_y, size_z, shell_r, FN_MEDIUM);
                    }
                    // for debugging
                    //#cube([ox*1.2, oy*1.2, oz*2.0],center=true);
                        }
            }
        }

        // inner body
        translate([-size_x/2-shell_thick, 0, 0]){
            difference(){
                difference() {
                    ce32a_shell(size_x, size_y, size_z, shell_thick, shell_r);
                    ce32a_shell_negative_volume(size_x, size_y, size_z, shell_thick, shell_r, driver_r);
                }
                // open back side
                union(){
                    translate([-order_x+size_x/2+shell_thick*2,0,0]) {
                        #prim_round_xplate(shell_thick*2, size_y+shell_thick*2, size_z+shell_thick*2, shell_r, FN_MEDIUM);
                    }
                    translate([-size_x/2+size_x/2+shell_thick-6,0,0]) {
                        prim_round_xplate(size_x-2, size_y+shell_thick*2, size_z+shell_thick*2+20, shell_r, FN_MEDIUM);
                    }
                }
            }
            // speaker driver holder arm
            translate([size_x/2-arm_height/2-2,0,0]){
                ce32a_shell_arm(size_x, size_y, size_z, shell_thick, shell_r, arm_height, arm_depth);
            }
        }
    }
}    


// center=[0,0,0]
module ce32a_unit_lid(order_x, order_y, order_z) {
//    ox = order_x - shell_thick*2;
//    oy = order_y - shell_thick*2;
//    oz = order_z - shell_thick*2;

    translate([-order_x,0,shell_thick/2]){
        translate([0,0,0]){
            prim_round_zplate0(order_x, order_y, shell_thick, shell_r, FN_MEDIUM);
        }
        translate([0,0,shell_thick-WELDING]){
            difference(){
                prim_round_zplate0(order_x-shell_thick*2, order_y-shell_thick*2, shell_thick*2, shell_r, FN_MEDIUM);
                prim_round_zplate0(order_x-shell_thick*4, order_y-shell_thick*4, shell_thick*2, shell_r, FN_MEDIUM);
            }
        }
        translate([order_x/2-shell_thick-arm_thick-4, 0, order_z/2-shell_thick/2-WELDING]) {
            rotate([180,0,0]){
                ce32a_shell_arm(size_x, size_y, size_z, shell_thick, shell_r, arm_height, arm_depth);
            }
        }
    }
}

// center=[0,0,0]
module ce32a_shell(sx, sy, sz, st, sr) {

    translate([0,0,0])
    difference() {
        prim_round_xplate(sx+st*2, sy+st*2, sz+st*2, sr, FN_MEDIUM);
        translate([0,0,-st])
            prim_round_xplate(sx, sy, sz+st*2, sr, FN_MEDIUM);
    }
}

// center=[0,0,0]
module ce32a_shell_arm(sx, sy, sz, st, sr, ah, ad) {

    // left top (vertical)
    translate([0, sy/2-ad/2, sz/2-ah/2+WELDING]) {
        prim_round_cube0(2, ad+WELDING, ah+WELDING, 0.2, FN_MEDIUM);
    }
    // left top (horizontal)
    translate([0, sy/2-ah/2, sz/2-ad/2+WELDING]) {
        prim_round_cube0(2, ah+WELDING, ad+WELDING, 0.2, FN_MEDIUM);
    }

    // right top (vertical)
    translate([0, -sy/2+ad/2, sz/2-ah/2+WELDING]) {
        prim_round_cube0(2, ad+WELDING, ah+WELDING, 0.2, FN_MEDIUM);
    }
    // right top (horizontal)
    translate([0, -sy/2+ah/2, sz/2-ad/2+WELDING]) {
        prim_round_cube0(2, ah+WELDING, ad+WELDING, 0.2, FN_MEDIUM);
    }
}


module ce32a_shell_negative_volume(sx, sy, sz, st, sr, hr) {
    dt = 0;
    dtx = 10;

    if (render_open_roof){
        translate([0,0,0])
            prim_round_xplate(sx-dtx, sy, sz+10, sr, FN_MEDIUM);
            prim_round_xplate(sx-dtx, sy+10, sz, sr, FN_MEDIUM);
            translate([-sx/2,0,0])
                #prim_round_xplate(sx*2-4*2-2,  sy+10, sz+10, sr, FN_MEDIUM);
    }

    // bottom hole for lid
    translate([0, 0,-sz/2]) {
        #prim_round_zplate0(sx, sy+6, lid_inner_z*8, sr, FN_MEDIUM);
    }

    // front side holes
    translate([sx/2+st/2,0,0]) {
        // speaker driver hole
        rotate([0,90,0]) {
            cylinder(h=st+WELDING, r=hr, $fn=FN_LARGE, center=true);
        }

        dd = mount_dia/1.414/2; // 1.414 = sqrt(2); y- and z-axis distance from center to mount holes
        // speaker driver mount holes
        for (ix=[-1,1]) {
            for (iy=[-1,1]) {
            translate([0, dd*ix, dd*iy])
                rotate([0,90,0])
                cylinder(h=st+WELDING, r=2, $fn=FN_MEDIUM, center=true);
                }
        }
    }
    
}
