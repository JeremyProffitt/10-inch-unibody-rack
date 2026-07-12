/**
 * Waveshare 7-inch LCD + Raspberry Pi Case - Portrait
 *
 * One source panel rotated 90 degrees counter-clockwise. The right-side
 * service bay is retained and a top chase serves the rotated LCD connectors.
 * Change lcd_angle_from_table_deg to regenerate the required case depth.
 */

case_layout = "portrait";
lcd_angle_from_table_deg = 35;
render_mode = "assembly";

include <waveshare-7inch-lcd-case-common.inc>
