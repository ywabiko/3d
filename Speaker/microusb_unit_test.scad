use <microusb.scad>
translate([45,0,0]) {
    microusb_unit(ox=40, with_vent=1, with_cabling=1, with_shell=0);
}

microusb_unit_lid_only();

translate([-2,0,0]) {
    difference() {
        cube([0,0,0]);
        microusb_unit_lid_negative_voume();
    }
}
