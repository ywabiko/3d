//
// CE32A 1" Speaker Enclosure Type2 Rev.1
//
// by Yasuhiro Wabiko
//
// This work is licensed under a Creative Commons Attribution 4.0 International License.
// https://creativecommons.org/licenses/by/4.0/
//
// See
//    https://github.com/ywabiko/3d/blob/master/Speaker/README.md
// for build instructions.
//

use <speaker_stand.scad>
use <prim.scad>

// inner size of the box
size_x = 32+1.2;
size_y = 32+1.2;
size_z = 26;

// stand
stand_z = 40; // stand height

// other driver body sizes
driver_mount_thick = 2;
driver_mount_r  = 1.0;
driver_mount_r0 = 35+1.2;

// speaker wall sizes
wall_back_thick = 1.2;
wall_thick = 1.2;
wall_r = 2;

// design parameters
spfn_small  = 8;
spfn_medium = 16;
spfn_large  = 64;

// internal parameters
WELDING = 1; // offset to make sure two adjacent models welded.


// render target; this is meant to be overriden by Makefile
TARGET="default";

//
// top level logic
//
ce32a_main();

module ce32a_main(target=TARGET){
    
    if (target == "default") {
        ce32a(with_stand=0);
    }

    if (target == "with_stand") {
        ce32a(with_stand=1);
    }
}


module ce32a(with_stand=0){
    translate([0, 0, WELDING])
        ce32a_shell(size_x, size_y, size_z+WELDING, wall_r, wall_thick,
                        driver_mount_thick, driver_mount_r0, driver_mount_r,
                        spfn_small, spfn_medium, spfn_large, with_stand=with_stand);

    translate([0, 0, 0])
        #ce32a_backplate(size_x, size_y, wall_back_thick, wall_r, wall_thick,
                             driver_mount_thick, driver_mount_r0, driver_mount_r,
                             spfn_small, spfn_medium, spfn_large);

    if (with_stand) {
        translate([size_x+4,0,0]){
            speaker_stand(stand_z=40, base_x=(size_x-2)*0.8, base_y=(size_y-2)*0.8, base_z=4);
        }
    }
}


module ce32a_backplate(sx, sy, sz, wr, wt, dmt, dmr0, dmr,
                           fns, fnm, fnl){
    difference(){
        ce32a_round_hplate(sx+wt, sy+wt, sz, wr, fnm);
        #ce32a_backplate_negative_volume(sx, sy, sz, wt, fnm);
    }
}

module ce32a_backplate_negative_volume(sx, sy, sz, wt, fnm){
    // cable hole
    hull(){
        translate([sx/2+wt-6, 2.54/2, 0])
            cylinder(r=3.2/2, h=4, $fn=fnm, center=true);
        translate([sx/2+wt-6, -2.54/2, 0])
            cylinder(r=3.2/2, h=4, $fn=fnm, center=true);
    }
}

module ce32a_shell(sx, sy, sz, wr, wt, dmt, dmr0, dmr,
                       fns, fnm, fnl, with_stand=1){
    dd = dmr0/1.414/2; // 1.414 = sqrt(2); y- and z-axis distance from center to mount holes

    difference(){
        // outer shell
        ce32a_round_hplate(sx+wt, sy+wt, sz, wr, fnm);
        union() {
            // room for stuffing
            translate([0, 0, sz-dmt]) {
                ce32a_round_hplate(sx, sy, dmt+WELDING, wr, fnm);
            }

            // speaker driver hole
            translate([0, 0, 0])
                cylinder(r=32.2/2,h=sz+WELDING, $fn=fnl);

            // speaker driver mount holes
            translate([dd, dd, sz-2])
                cylinder(r=dmr, h=3*2, $fn=fnm, center=true);
            translate([dd, -dd, sz-2])
                cylinder(r=dmr, h=3*2, $fn=fnm, center=true);
            translate([-dd, dd, sz-2])
                cylinder(r=dmr, h=3*2, $fn=fnm, center=true);
            translate([-dd, -dd, sz-2])
                cylinder(r=dmr, h=3*2, $fn=fnm, center=true);

            if (with_stand) {
                translate([sx/2, 0, sz/2+wt/2]) {
                    rotate([0,90,0]) {
                        #cylinder(r = 3, $fn = 32, h = wt*4, center=true);
                    }
                }
            }
        }
    }
}


// px0,py0 = width(x-axis),height(y-axis), center at (0,0)
// pz = thickness (z-axis from z=0)
// pr = r
// fn = $fn
module ce32a_round_hplate(px0, py0, pz,  pr, pf)
{
    px = px0-pr*2;
    py = py0-pr*2;
    
    hull(){
        translate([-px/2,-py/2,0])
            cylinder(r=pr, h=pz, $fn=pf);
        translate([-px/2,+py/2,0])
            cylinder(r=pr,h=pz, $fn=pf);
        translate([+px/2,- py/2,0])
            cylinder(r=pr,h=pz, $fn=pf);
        translate([+px/2,+py/2,0])
            cylinder(r=pr, h=pz, $fn=pf);
    }
}
