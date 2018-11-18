kerf = 0.5;
kerft = kerf * 2;

seg_kw = 19;
seg_w = seg_kw - kerft;
seg_sh = 12;
seg_mh = 56;
seg_kth = (seg_sh * 2) + seg_mh;
seg_th = seg_kth - kerft;

wall_w = 1.2 + 1.5;
wall_ws = 0.6 + 0.75;
wall_h = 19.0;
bot_h  = 1.2;
tot_h  = wall_h + bot_h;

gap_ww = 11.0;
gap_wl = 6.0;
gap_tl = 1.5;
gap_tt = 3.5;

union() {
  difference() {
    polyhedron(
      points = [
        [-seg_w/2, -seg_mh/2, 0],
        [0, -seg_th/2, 0],
        [seg_w/2, -seg_mh/2, 0],
        [seg_w/2, seg_mh/2, 0],
        [0, seg_th/2, 0],
        [-seg_w/2, seg_mh/2, 0],
        [-seg_w/2, -seg_mh/2, tot_h],
        [0, -seg_th/2, tot_h],
        [seg_w/2, -seg_mh/2, tot_h],
        [seg_w/2, seg_mh/2, tot_h],
        [0, seg_th/2, tot_h],
        [-seg_w/2, seg_mh/2, tot_h],
      ],
      faces =  [
        [0, 1, 2, 3, 4, 5],
        [0, 5, 11, 6],
        [1, 0, 6, 7],
        [2, 1, 7, 8],
        [3, 2, 8, 9],
        [4, 3, 9, 10],
        [5, 4, 10, 11],
        [11, 10, 9, 8, 7, 6]
      ]
    );
    translate([0, 0, tot_h-3]) {
      polyhedron(
        points = [
          [-seg_w/2+wall_ws/2, -seg_mh/2+wall_ws/2, 0],
          [0, -seg_th/2+wall_w/2, 0],
          [seg_w/2-wall_ws/2, -seg_mh/2+wall_ws/2, 0],
          [seg_w/2-wall_ws/2, seg_mh/2-wall_ws/2, 0],
          [0, seg_th/2-wall_w/2, 0],
          [-seg_w/2+wall_ws/2, seg_mh/2-wall_ws/2, 0],
          [-seg_w/2+wall_ws/2, -seg_mh/2+wall_ws/2, tot_h],
          [0, -seg_th/2+wall_w/2, tot_h],
          [seg_w/2-wall_ws/2, -seg_mh/2+wall_ws/2, tot_h],
          [seg_w/2-wall_ws/2, seg_mh/2-wall_ws/2, tot_h],
          [0, seg_th/2-wall_w/2, tot_h],
          [-seg_w/2+wall_ws/2, seg_mh/2-wall_ws/2, tot_h],
        ],
        faces =  [
          [0, 1, 2, 3, 4, 5],
          [0, 5, 11, 6],
          [1, 0, 6, 7],
          [2, 1, 7, 8],
          [3, 2, 8, 9],
          [4, 3, 9, 10],
          [5, 4, 10, 11],
          [11, 10, 9, 8, 7, 6]
        ]
      );
    }
    translate([0, 0, bot_h]) {
      polyhedron(
        points = [
          [-seg_w/2+wall_ws, -seg_mh/2+wall_ws, 0],
          [0, -seg_th/2+wall_w, 0],
          [seg_w/2-wall_ws, -seg_mh/2+wall_ws, 0],
          [seg_w/2-wall_ws, seg_mh/2-wall_ws, 0],
          [0, seg_th/2-wall_w, 0],
          [-seg_w/2+wall_ws, seg_mh/2-wall_ws, 0],
          [-seg_w/2+wall_ws, -seg_mh/2+wall_ws, tot_h],
          [0, -seg_th/2+wall_w, tot_h],
          [seg_w/2-wall_ws, -seg_mh/2+wall_ws, tot_h],
          [seg_w/2-wall_ws, seg_mh/2-wall_ws, tot_h],
          [0, seg_th/2-wall_w, tot_h],
          [-seg_w/2+wall_ws, seg_mh/2-wall_ws, tot_h],
        ],
        faces =  [
          [0, 1, 2, 3, 4, 5],
          [0, 5, 11, 6],
          [1, 0, 6, 7],
          [2, 1, 7, 8],
          [3, 2, 8, 9],
          [4, 3, 9, 10],
          [5, 4, 10, 11],
          [11, 10, 9, 8, 7, 6]
        ]
      );
      translate([0,0,bot_h+.55]) {
        translate([0,0,-(gap_tt-gap_tl)/2]) {
          cube([gap_ww, 100, gap_tl], center=true);
        }
        cube([gap_wl, 100, gap_tt], center=true);
      }
    }
    cube([seg_w/2,seg_mh,10],center=true);
  }
  translate([0,0,bot_h/2]) {
    cube([1.2,seg_mh,bot_h],center=true);
    cube([seg_w/2,1.2,bot_h],center=true);
  }
}