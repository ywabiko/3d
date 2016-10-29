//
// CE32A 1" speaker enclosure rev.2
//
// by Yasuhiro Wabiko
//
// This work is licensed under a Creative Commons Attribution 4.0 International License.
// https://creativecommons.org/licenses/by/4.0/
//

// global mode switches
print_ready_layout = 1; // layout flag = { 0: edit layout, 1: print ready layout (i.e. rotate appropriately) }
open_roof          = 0; // open roof part for debugging/fitting purpose
open_bottom        = 0; // open bottom part for debugging/fitting purpose
render_body        = 1; // flag to render the body part = { 1: yes, 0: no }
render_lid         = 1; // flag to render the lid part = { 1: yes, 0: no }
render_lid_hole    = 1; // flag to render the lid's cable hole = { 1: yes, 0: no }
render_support     = 1; // flag to render support = { 1: yes, 0: no }

// inner size of the box
size_x = 26;
size_y = 32+1.0; // 1.6 too large 0.8 too small
size_z = 32+1.0;
error_correction = 1.0; // 1.0 for normal PLA, 0.4 for wood PLA

// further customization example: make a hole on the front surface
// coordinates are from left-bottom edge of inner space
// ***volume knob hole***
front_hole_y    = size_y/2;
front_hole_z    = size_z/2;
front_hole_r    = 29/2;
front_hole_spfn = 64;

// spaker mount holes at corners
mount_dia    = 35;  // mount holes layout diameter
mount_r      = 1.0; // mount hole radius
mount_spfn   = 16;  // minkowski resolution
mount_mink   = 0.2;

// a hole on the lid side
// ***cable holes***
lid_hole_y = 2.3;
lid_hole_z = 6;
lid_hole_r = 1.3;

// other shape parameters
thick = 0.4;  // wall thickness
mink =  0.4;  // minkowski radius
spfn =  16;   // minkowski resolution
lidinner   = 2.0; // thickness of lid inner part

//
// internals
//

// internal configurations
difoff   = thick+mink*3;  // offset to apply difference correctly for the inner space
lidoff   = -6; // x-offset to locate the lid
size_x_room = size_x + lidinner + mink; // size_x that lidinner takes into account. (this may or may not be necessary depending on shape of stuffing.)
concat_offset = 0.2;


//
// main logic
//

if (print_ready_layout) {
    if (render_body){
        rotate([0,90,0])
            translate([-(size_x_room+(thick+mink*2)*2), 0, 0])
            ce32a_body();
    }
    if (render_lid){
        translate([lidoff, 0, 0])
            rotate([0,-90,0])
            ce32a_lid();
    }
} else {
    if (render_body){
        ce32a_body();
    }
    if (render_lid){
        translate([lidoff, 0, 0])
            translate([mink, 0, 0])
            ce32a_lid();
    }
}

module ce32a_body(){
    // cube
    difference(){
        minkowski(){
            difference(){
                translate([mink, mink, mink])
                    cube([size_x_room+thick*2+mink*2, size_y+thick*2+mink*2, size_z+thick*2+mink*2]);
                ce32a_negative_volume();
            }
            sphere(r = mink, $fn = spfn);
        }

        ce32a_negative_volume_mount_holes(); // no need for minkowski
    }
}

// cube inner volume (negative volume. this part will be subtracted to make room for stuffings.)
module ce32a_negative_volume() {
    hole_height = thick+mink/2+difoff;

    translate([-difoff, thick+mink*2, thick+mink*2-open_bottom*(thick+mink*2)*2])
        cube([size_x_room+thick+mink*2+difoff, size_y, size_z+open_roof*(thick+mink*2)*2+open_bottom*(thick+mink*2)*2]);

    // front speaker hole
    translate([size_x_room+thick*2+mink*4, thick+mink+front_hole_y, thick+mink+front_hole_z])
        rotate([0, 90, 0])
        #cylinder(r = front_hole_r+mink, $fn = front_hole_spfn, h=(thick+mink*2)*2*1.1, center=true);

}  

module ce32a_negative_volume_mount_holes() {
    cy = thick+mink*2+size_y/2;
    cz = thick+mink*2+size_z/2;
    dd = mount_dia/1.414/2; // 1.414 = sqrt(2); y- and z-axis distance from center to mount holes

    // corner mount holes
    translate([size_x_room+thick*2+mink*2, cy+dd, cz+dd])
        rotate([0, 90, 0])
        #cylinder(r = mount_r+mink, $fn = mount_spfn, h=(thick+mink*2)*2*1.1, center=true);
        translate([size_x_room+thick*2+mink*2, cy+dd, cz-dd])
        rotate([0, 90, 0])
        #cylinder(r = mount_r+mink, $fn = mount_spfn, h=(thick+mink*2)*2*1.1, center=true);
        translate([size_x_room+thick*2+mink*2, cy-dd, cz+dd])
        rotate([0, 90, 0])
        #cylinder(r = mount_r+mink, $fn = mount_spfn, h=(thick+mink*2)*2*1.1, center=true);
        translate([size_x_room+thick*2+mink*2, cy-dd, cz-dd])
        rotate([0, 90, 0])
        #cylinder(r = mount_r+mink, $fn = mount_spfn, h=(thick+mink*2)*2*1.1, center=true);

        }    


module ce32a_lid(){
    difference(){
        minkowski(){
            ce32a_lid_body();
            sphere(r = mink, $fn = spfn);
        }
        if (render_lid_hole) {
            ce32a_lid_negative_volume2();
        }
    }
    if (render_support) {
        ce32a_lid_support2();
    }
}

module ce32a_lid_nohole(){
    minkowski(){
        ce32a_lid_body();
        sphere(r = mink, $fn = spfn);
    }
    if (render_support) {
        ce32a_lid_support2();
    }
}

module ce32a_lid_draft(){

    difference(){
        minkowski(){
            ce32a_lid_body();
            sphere(r = mink, $fn = spfn);
        }
        if (render_lid_hole) {
            ce32a_lid_negative_volume2();
        }
    }
}

module ce32a_lid_negative_volume2(){
    hole_height = (lidinner+thick*2+mink*4)*2*1.1;

    // cable hole
    for (v = [[1,1]]){
        y = v[0];
        w = v[1]*2.54;
        translate([0, thick+mink+lid_hole_y+lid_hole_r+y*2.54, thick+mink+lid_hole_z+lid_hole_r])
            rotate([0, 90, 0])
            hull() {
            translate([0, w, 0])
                #cylinder(r = lid_hole_r+mink, $fn = spfn, h=hole_height, center=true);
                #cylinder(r = lid_hole_r+mink, $fn = spfn, h=hole_height, center=true);
                }
    }
}

module ce32a_lid_body(){
    translate([(thick+mink*2)/2, size_y/2+thick+mink*2, size_z/2+thick+mink*2])
        cube([thick, (size_y+thick*2+mink*2), size_z+thick*2+mink*2], center=true);
}

module ce32a_lid_support2(){

    // lower part
    difference(){
        ce32a_lid_support2_impl(0,   0,   2);
        ce32a_lid_support2_impl(0.9, 0.9, 2);
    }

    // inner walls
    difference(){
        ce32a_lid_support2_impl(0.2, 0.2, size_x-7.5 + lidinner+mink*2);
        ce32a_lid_support2_impl(0.9, 2.0, size_x-7.5 + lidinner+mink*2);
    }
}

module ce32a_lid_support2_impl(dsy,dsz,sh){

    //x0 = (thick+mink*2)+(lidinner+mink*2)-concat_offset*2;
    x0 = (thick+mink*2)-concat_offset*2;
    y0 = size_y/2+thick+mink*2;
    z0 = size_z/2+thick+mink*2;
    dr = 0.8;
    dy = (size_y-mink*2-error_correction-dr*2)/2-dsy;
    dz = (size_z-mink*2-error_correction-dr*2)/2-dsz;

    hull(){
        hull() {
            translate([x0, y0-dy, z0-dz])
                rotate([0,90,0])
                cylinder(r=0.4+dr, h=sh, $fn=16);

            translate([x0, y0-dy, z0+dz])
                rotate([0,90,0])
                cylinder(r=0.4+dr, h=sh, $fn=16);
        }

        hull(){
            translate([x0, y0+dy, z0-dz])
                rotate([0,90,0])
                cylinder(r=0.4+dr, h=sh, $fn=16);

            translate([x0, y0+dy, z0+dz])
                rotate([0,90,0])
                cylinder(r=0.4+dr, h=sh, $fn=16);
        }
    }
}
