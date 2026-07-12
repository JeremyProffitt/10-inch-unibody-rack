/**
 * Waveshare 7-inch LCD + Raspberry Pi Case - Portrait
 *
 * One LCD rotated 90 degrees counter-clockwise in a removable lid. The Pi is
 * floor-mounted inside a closed solid-bottom base with 10 mm cable passages.
 * Change lcd_angle_from_table_deg to regenerate base depth and rear height.
 */

case_layout = "portrait";
lcd_angle_from_table_deg = 35;
part = "assembly";
render_mode = "assembly";

include <waveshare-7inch-lcd-case-common.inc>
