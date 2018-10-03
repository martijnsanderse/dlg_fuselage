





module tab() {
    tab_x = 4.7;
    tab_y = 8.3; // same as box_y
    tab_z = 1.1;
    
    difference() {
        cube([tab_x, tab_y, tab_z]);
        translate([tab_x/2, tab_y/2, -1])
            cylinder(d=2.0, h=tab_z+2);
    }
}

module es9051() {
    // dimensions
    box_x = 19.8; // mm
    box_y = 8.3;
    box_z = 19.7;
    
    tab_offset_x1 = 4.7; // same as tab_x
    tab_offset_z = 15.0;
    
    axle_box_z = 3.15; //22.85 - 19.7
    axle_d = 4.0;
    axle_h = 6.0;
    
    // center box
    cube([box_x, box_y, box_z], [0,0,0]);
    
    // left tab
    translate([-tab_offset_x1, 0, tab_offset_z]) {
        tab();
    }
    
    // right tab
    translate([box_x, 0, tab_offset_z]) {
        tab();
    }
    
    // axle unit
    translate([box_y/2, box_y/2, box_z]) {
        union() {
            translate([3.0, 0, 0]) cylinder(d=6.0, h=axle_box_z);
            cylinder(d=box_y, h=axle_box_z);
            cylinder(d=axle_d, h=axle_h); // axle
        }
    }
    
}