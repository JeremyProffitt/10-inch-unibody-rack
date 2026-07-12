/**
 * Waveshare 7-inch LCD + Raspberry Pi Case - Dual Portrait Side-by-Side
 *
 * Two source panels rotated 90 degrees counter-clockwise and arranged in two
 * columns. A common top chase serves both LCDs; one Pi 4/5 mount drives both.
 * Change lcd_angle_from_table_deg to regenerate the required case depth.
 */

case_layout = "dual_portrait";
lcd_angle_from_table_deg = 35;
render_mode = "assembly";

include <waveshare-7inch-lcd-case-common.inc>
