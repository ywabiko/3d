use <../CE32A_Rev1.scad>
translate([40,0,0]) {
    ce32a_unit_body_only(40, 36, 36);
}
ce32a_unit_lid_only(40,  36, 36, with_hole=0);
