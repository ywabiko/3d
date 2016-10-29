use <../PAM8403.scad>
translate([40,0,0]){
    pam8403_unit(ox=40, oy=38, oz=36, with_vent=0, with_cabling=1, with_lid=0, with_shell=1, with_holder=1, with_side=1);
}

pam8403_unit_lid_only(ox=40, oy=38, oz=36, with_vent=0, with_cabling=1, with_lid=0, with_shell=0, with_holder=0, with_hole=0, with_vent_lid=1);
