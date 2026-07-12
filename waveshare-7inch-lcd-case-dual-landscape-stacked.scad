/**
 * Waveshare 7-inch LCD + Raspberry Pi Case - Dual Landscape Stacked
 *
 * Two source panels in landscape orientation arranged in two vertical rows.
 * The common right bay serves both LCDs and one Pi 4/5 mount drives both.
 * Change lcd_angle_from_table_deg to regenerate the required case depth.
 */

case_layout = "dual_landscape";
lcd_angle_from_table_deg = 35;
render_mode = "assembly";

include <waveshare-7inch-lcd-case-common.inc>
