/**
 * Waveshare 7-inch LCD + Raspberry Pi Case - Dual Landscape Stacked
 *
 * Two stacked landscape LCDs share a removable lid above a closed solid-bottom
 * base. One floor-mounted Pi 4/5 sits behind them; cable passages are 10 mm.
 * Change lcd_angle_from_table_deg to regenerate base depth and rear height.
 */

case_layout = "dual_landscape";
lcd_angle_from_table_deg = 35;
part = "assembly";
render_mode = "assembly";

include <waveshare-7inch-lcd-case-common.inc>
