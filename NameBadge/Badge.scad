//
// SIJP Name Badge
// cf. max print size
//  - QIDI 225x145
//  - Shapeways 285x150 (PLA)
//

width = 100;      // 名札のサイズ(X)
height = 60;      // 名札のサイズ(Y)
grid_width = 20;  // 罫線の間隔(X)
grid_height = 20; // 罫線の間隔(Y)
thick = 1;        // 罫線の太さ(mm)
thick_outer = 5;  // 名札外周の太さ(mm)
grid_cx = width / grid_width;   // 罫線の本数(X)
grid_cy = height / grid_height; // 罫線の本数(Y)

// 使い方
//
// badge(name, [ offset1, offset_2, ....  ], fontsize_offset);
//     名札を生成する。
//
//   where
//     name   = 名前の文字列
//     offsetN = N文字目の位置の補正値
//             = [ offset_x, offset_y ]
//                 where 
//                     offset_x = X方向補正値(mm)
//                     offset_y = Y方向補正値(mm)
//     fontsize_offset = フォントサイズ補正値(mm)
//
//
// badge_support(ix, iy, direction) 
//     特殊なケースに緊急対応するためのアドホック格子部品。
//     1マスサイズの格子（縦 or 横）を追加する。
//
//   where
//     ix, iy = 格子座標
//         where ix = 0,1,2,3,4, iy = 0,1,2 ただし左下が (0,0)
//     direction = 1 (縦) or 2 （横)

translate([0, 0]) {
    badge("わびこ", [ [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], ], 0);
}
translate([110, 74]) {
    badge("こうき", [ [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], ], 0);
    badge_support(2, 2, 2);    
}
translate([0, 74]) {
    badge("りゅうたろう", [ [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], ], 0);
}
translate([110, 0]) {
    badge("まり", [ [ 0, 0 ], [ 0, 0 ], ], -10);
}



//
// 以下、サブモジュール
//

module badge(name, offsets, fontsize_offset) {

    badge_body();
    height_list = [3, 0.5];
    pass = 0;
    scaler = len(name)*len(name);
    //for (pass = [0 : 1]) {
        minkowski() {
            linear_extrude(height = height_list[pass], center = false, convexity = 10,
                               twist = 0, slices = 20, scale = 1.0) {

                for (i = [0 : len(name)-1]) {
                    namechar = name[i];
                    offset = offsets[i];
                    offset_x = offset[0];
                    offset_y = offset[1];
                    bboxsize = (width-thick_outer*4/scaler)/len(name);       
                    fontsize = bboxsize*0.9 + fontsize_offset;
                    pos_x = bboxsize/2 + i*bboxsize + thick_outer*4/scaler;
                    pos_y = (height-bboxsize)/2 + bboxsize*0.2; // - thick_outer*4/scaler;

                    echo(i=i, namechar=namechar, offset_x=offset_x,offset_y=offset_y, bboxsize=bboxsize, fontsize=fontsize, pos_x=pos_x, pos_y=pos_y);

                    translate([pos_x+offset_x, pos_y+offset_y, 0])
                        text(text = namechar, font = "IPAexゴシック",
                             halign = "center", valign="baseline", size = fontsize);

                }
            }
            //if (pass == 0) {
                sphere(r = 1.0, $fn = 8);
            //} else if (pass == 1) {
            //    cube([3, 3, 0.1], center=true);
            //}
        }

    //}

}


// 特殊なケースに緊急対応するためのアドホック格子部品
// 1マスサイズの格子（縦 or 横）を追加する
//
// badge_support(ix, iy, direction) 
//     ix, iy = 格子座標 where ix = 0,1,2,3,4, iy = 0,1,2 左下が (0,0)
//     direction = 1 (縦) or 2 （横)
//
module badge_support(ix, iy, direction) {

    translate([0, 0, -0.5])
    minkowski() {
        linear_extrude(height = 1, center = false, convexity = 10,
                           twist = 0, slices = 20, scale = 1.0) {

            if (direction == 1) {
                translate([grid_width/2+ix*grid_width-thick/2, iy*grid_height, -0.5])
                   square([thick, grid_height]);
            }
            if (direction == 2) {
                translate([ix*grid_width, grid_height/2+iy*grid_height-thick/2, 0])
                   square([grid_width, thick]);
            }
        }
        sphere(r=0.5, $fn=8);
    }      

}

// 名札の背景本体
module badge_body() {
    // SIJPロゴ
    translate([width-12, 2])
       rotate([0, 0, 20]) scale([1.0,1.0,2.0]) logo(15, 15);

    // ストラップ取り付け部
    minkowski() {
        linear_extrude(height = 1, center = false, convexity = 10,
                           twist = 0, slices = 20, scale = 1.0) {
            translate([width/2-16, height+7])
                    square([32, 2]);
            translate([width/2-15-1, height])
                    square([2, 7]);
            translate([width/2+15-1, height])
                    square([2, 7]);
        }
        sphere(r=1.0, $fn=8);
    }

    // 外周
    minkowski() {
        linear_extrude(height = 1, center = false, convexity = 10,
                           twist = 0, slices = 20, scale = 1.0) {
            difference(){
                square([width, height]);
                translate([thick_outer/2, thick_outer/2])
                    square([width-thick_outer, height-thick_outer]);
            }
        }
        sphere(r=1.0, $fn=8);
    }

    // 格子（縦）
    translate([0, 0, -0.5])
    minkowski() {
        linear_extrude(height = 1, center = false, convexity = 10,
                           twist = 0, slices = 20, scale = 1.0) {

           for (ix = [1:grid_cx-1]) {
                translate([ix*grid_width-thick/2, 0, -0.5])
                   square([thick, height]);
           }

        }
        sphere(r=0.5, $fn=8);
    }      

    // 格子（横）
    translate([0, 0, -0.5])
    minkowski() {
        linear_extrude(height = 1.0, center = false, convexity = 10,
                           twist = 0, slices = 20, scale = 1.0) {

           for (iy = [1:grid_cy-1]) {
                translate([0, iy*grid_height-thick/2, 0])
                   square([width, thick]);
           }
        }
        sphere(r=0.5, $fn=8);
    }      
}


//
// SIJP ロゴ
//
module logo(w, h) {
    t = 1;
    grid_cx = w/2;
    grid_cy = h/2;
    px = 12;
    py = 12;

    translate([0, 0, -0.5]) cube([11, 11, 0.5]);
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
