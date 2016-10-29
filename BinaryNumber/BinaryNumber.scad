//
// SIJP Binary Number Cards
//
// cf. max print size
//  - QIDI 225x145
//  - Shapeways 285x150 (PLA)
//

// ----- bulk print (production) -----

gap = 4;           // gap between cards (in mm).
card_width  = 30;  // card width (in mm).
card_height = 50;  // card height (in mm).
num_x = 5;         // number of cards in X axis.
num_y = 25;         // number of cards in Y axis.
side = 1;          // side (1=front, 0=back).
connect = 0;       // connect parts by 1mm-thick lines to reduce printing cost.

binary_number_cards(card_width, card_height, num_x, num_y, side, gap, connect);

// ----- single print (test print) -----

//plate1(0);  // back side
//plate1(1);  // front side 1
//plate1(2);  // front side 2
//plate1(4);  // front side 4
//plate1(8);  // front side 8
//plate1(16); // ftont side 16


// ----- other misc tests -----

//logo(card_width, card_height); // print logo part only


module binary_number_cards(mx, my, cx, cy, side, gap, connect) {

    px = mx+gap;
    py = my+gap;
    
    for (ix = [0:cx-1]) {
        if (connect == 1) { 
            color([1, 0, 0]) translate([ix*px, 0, 0]) cube([1, cy*(2+gap)-gap, 1]);
        }
        for (iy = [0:cy-1]) {
            if (connect == 1) {
                color([1, 0, 0]) translate([0, iy*(2+gap), 0]) cube([cx*px-gap, 1, 1]);
            }
            if (side == 0) {
                    translate([ix*px, iy*(2+gap)+2, 0]) rotate([90, 0, 0]) plate1(0, mx, my);
            } else {
                if (((ix+iy*cx) % 5) == 0) {
                    translate([ix*px, iy*(2+gap)+2, 0]) rotate([90, 0, 0]) plate1(1, mx, my);
                }
                if (((ix+iy*cx) % 5) == 1) {
                    translate([ix*px, iy*(2+gap)+2, 0]) rotate([90, 0, 0]) plate1(2, mx, my);
                }
                if (((ix+iy*cx) % 5) == 2) {
                    translate([ix*px, iy*(2+gap)+2, 0]) rotate([90, 0, 0]) plate1(4, mx, my);
                }
                if (((ix+iy*cx) % 5) == 3) {
                    translate([ix*px, iy*(2+gap)+2, 0]) rotate([90, 0, 0]) plate1(8, mx, my);
                }
                if (((ix+iy*cx) % 5) == 4) {
                    translate([ix*px, iy*(2+gap)+2, 0]) rotate([90, 0, 0]) plate1(16, mx, my);
                }
            }
        }
    }
}

//
// SIJP logo
//
module logo(w, h) {
    t = 1;
    cx = w/2;
    cy = h/2;
    px = 12;
    py = 12;
    difference() {
        translate([0, 0, 0]) cube([11, 11, 1]);
        union() {
            translate([0.6, 0.6, -0.2]) cube([4.6, 4.6, 1.4]);
            translate([5.8, 0.6, -0.2]) cube([4.6, 4.6, 1.4]);
            translate([5.8, 5.8, -0.2]) cube([4.6, 4.6, 1.4]);
            translate([0.6, 5.8, -0.2]) cube([4.6, 4.6, 1.4]);
        }
    }
    linear_extrude(height = 1, center = false, convexity = 10,
                           twist = 0, slices = 20, scale = 1.0) {
        translate([2.8, 6.3, 0])
            text(text = "S", font = "Consolas:style=Bold", halign = "center", valign="baseline", size = 4);
        
        translate([8.0, 6.3, 0])
            text(text = "I", font = "Consolas:style=Bold", halign = "center", valign="baseline", size = 4);

        translate([2.8, 1.1, 0])
            text(text = "J", font = "Consolas:style=Bold", halign = "center", valign="baseline", size = 4);
        
        translate([8.0, 1.1, 0])
            text(text = "P", font = "Consolas:style=Bold", halign = "center", valign="baseline", size = 4);
    }                      
}                    

//
// sub module to print a single card
//   m = number index (0 = back side, 1-5 = 1,2,4,8,16 respectively.)
//   w = width
//   h = height
//
module plate1(m, w, h) {
    t = 1;
    cx = w/2;
    cy = h/2;

    union() {
        translate([0, 0, 0]) cube([w, h, t]);
        if (m != 0) {
            translate([0, 0, 0]) pin(m, w, h, 1, 0); 
        }
            
        translate([0, h-2.0, 1.0]) rotate([-45,0,0]) cube([w,1.4,1.4]);
        translate([0, 0, 1])
            linear_extrude(height = 1, center = false, convexity = 10,
                           twist = 0, slices = 20, scale = 1.0) {
                translate([0,   h-1, 2]) square(size = [w, 1]);
                translate([0,   0,   2]) square(size = [w, 1]);
                translate([0,   0,   2]) square(size = [1, h]);
                translate([w-1, 0,   2]) square(size = [1, h]);
            if (m != 0) {
                translate([w/2, 5, 2]) 
                    text(text = "1", font = "Consolas", halign = "center", size = 10);
                }
            if (m == 0) {
                translate([w/2, 5, 3])
                    text(text = "0", font = "Consolas", halign = "center", size = 10);
            }
        }
        
        if (m == 0) {
            //translate([w*0.792, h*0.83, 1]) scale([0.6, 0.6, 1.0]) rotate([0, 0, 20]) logo(w,h);
            //translate([w*0.65, h*0.71, 1]) scale([1.0, 1.0, 1.0]) rotate([0, 0, 20]) logo(w,h);
            translate([w*0.65, h*0.71, 1]) scale([1.0, 1.0, 0.2]) rotate([0, 0, 20]) logo(w,h);
            //translate([w*0.265, h*0.4, 1]) scale([2.12, 2.12, 0.2]) rotate([0, 0, 20]) logo(w,h);
        }
    }
}


//
// sub module to print pins on a card.
// 
//   w = width
//   h = height
//   t = thickness
//   m = number index (1-5 = 1,2,4,8,16 respectively.)
//
module pin(num, w, h, t, m) {
    if (num == 1)  pin1 (w, h, t, m);
    if (num == 2)  pin2 (w, h, t, m);
    if (num == 4)  pin4 (w, h, t, m);
    if (num == 8)  pin8 (w, h, t, m);
    if (num == 16) pin16(w, h, t, m);
}

// sub module to print 16 pins
module pin16(w, h, t, m) {
    cx = w/2;
    cy = h/2;
    oz = 1;
    ot = t;
    for (ix = [0:3]) 
    {
        for (iy = [0:3]) 
        {
            //color([1, 0.5, 0.5])
            translate([cx-9+6*ix, cy+6*iy, 1])  cylinder(r = 2, h = ot);
        }
    }
}

// sub module to print 8 pins
module pin8(w, h, t, m) {
    cx = w/2;
    cy = h/2;
    oz = 1;
    ot = 1;
    for (ix = [0:1]) 
    {
        for (iy = [0:3]) 
        {
            //color([1, 0.5, 0.5])
            translate([cx-9+6*ix+6, cy+6*iy, 1])  cylinder(r = 2, h = ot);
        }
    }
}

// sub module to print 4 pins
module pin4(w, h, t, m) {
    cx = w/2;
    cy = h/2;
    oz = 1;
    ot = 1;
    for (ix = [0:1]) 
    {
        for (iy = [0:1]) 
        {
            //color([1, 0.5, 0.5])
            translate([cx-9+6*ix+6, cy+6*iy+6, 1])  cylinder(r = 2, h = ot);
        }
    }
}

// sub module to print 2 pins
module pin2(w, h, t, m) {
    cx = w/2;
    cy = h/2;
    oz = 1;
    ot = 1;
    for (iy = [0:1]) 
    {
        //color([1, 0.5, 0.5])
        translate([cx-9+9, cy+6*iy+6, 1])  cylinder(r = 2, h = ot);
    }
}

// sub module to print 1 pin
module pin1(w, h, t, m) {
    cx = w/2;
    cy = h/2;
    oz = 1;
    ot = 1;
    //color([1, 0.5, 0.5])
    translate([cx-9+9, cy+6, 1])  cylinder(r = 2, h = ot);
}
