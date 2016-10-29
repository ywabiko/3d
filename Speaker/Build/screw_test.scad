use <../prim.scad>
//screw_hole_d2_h3(align="none", volume_type="positive");
//screw_hole_d2_h3(align="x", volume_type="negative");
//screw_hole_d2_h3(align="none", volume_type="positive", with_shell=1, shell_x=20,shell_y=20,shell_z=40);
//screw_hole_d2_h3(align="x", volume_type="positive", with_shell=1, shell_x=20,shell_y=20,shell_z=40);
//screw_hole_d2_h3(align="y", volume_type="positive", with_shell=1, shell_x=20,shell_y=20,shell_z=40);

translate([0,0,0])
screw_hole_d2_h3(align="z", volume_type="positive", with_shell=1, shell_x=6,shell_y=6,shell_z=38);
translate([20,0,0])
screw_hole_d28_h95(align="z", volume_type="positive", with_shell=1, shell_x=6,shell_y=6,shell_z=38);
