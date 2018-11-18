wall_w = 1.6;

spot_d = 15.0;
spot_r = spot_d / 2;
spot_td = spot_d + (wall_w * 2);
spot_id = 13.4;
spot_ir = spot_id / 2;
spot_tr = spot_td / 2;
spot_bh = 1.2;
spot_ih = 19.0;
spot_th = spot_bh + spot_ih;
gap_h = 3.5;
gap_ih = 3.5;
gap_iw = 6.0;
gap_w = 11.0;

difference() {
  cylinder(r = spot_tr, h = spot_th);
  translate([0,0,spot_bh]) {
    cylinder(r=spot_ir, h=spot_th);
    translate([0,0,gap_ih/2]) {
      cube([gap_w,spot_td+1,gap_ih], center=true);
    }
    translate([0,0,gap_h/2]) {
      cube([gap_iw,spot_td+1,gap_h], center=true);
    }
  }
  translate([0,0,(spot_th-3)]) {
    cylinder(r = spot_r, h = spot_th);
  }
}