/**
 * Shared generator for Waveshare 7-inch LCD + Raspberry Pi desktop cases.
 *
 * Coordinate System (print orientation):
 *   X = case width  (positive = right when facing the LCD)
 *   Y = case height (positive = toward the top of the LCD)
 *   Z = case depth  (positive = behind the LCD; upward while printing)
 *
 * Origin: Front-bottom-left corner of the case.
 * Z=0 is the front face and is placed on the build plate.
 *
 * COMPONENT INDEX
 *   case_face_slab            [0,0,0] to [case_width,case_height,5]
 *   case_side_cheek (left)    X=[0,5], trapezoid in YZ; left rear/table rail
 *   case_side_cheek (right)   X=[W-5,W], trapezoid in YZ; right rear/table rail
 *   case_bottom_wall          Y=[0,5], rear edge follows table-contact plane
 *   case_top_wall             Y=[H-5,H], rear edge follows table-contact plane
 *   lcd_window_cutout         one per LCD cell; exact existing-panel opening
 *   lcd_mounting_bosses       four per LCD cell; PCB alignment and support
 *   lcd_screw_holes           four per LCD cell; M3 clearance through front
 *   pi_mounting_bosses        four in upper-right service region; Pi 4/5 pitch
 *   connector_access_cutouts  rear-open notches through top/right case walls
 *
 * Alignment notes:
 *   - Landscape cells retain the source panel coordinate system.
 *   - Portrait cells rotate the source panel 90 degrees counter-clockwise.
 *   - LCD connectors are on viewer-right in landscape and viewer-top in portrait.
 *   - The Raspberry Pi is rotated 90 degrees counter-clockwise so USB/Ethernet
 *     faces the case top and USB-C/micro-HDMI faces the case right.
 */

// =========================================
// PRINTER AND SOURCE-PANEL DIMENSIONS
// =========================================

printer_max_x_mm = 325.00;
printer_max_y_mm = 320.00;
printer_max_z_mm = 325.00;

source_panel_width_mm = 254.00;
source_panel_height_mm = 133.35;
panel_thickness_mm = 5.00;
wall_thickness_mm = 5.00;
case_corner_radius_mm = 4.00;
feature_corner_radius_mm = 1.00;

// Exact opening and placement inherited from waveshare-7inch-lcd-panel.scad.
lcd_window_width_mm = 156.00;
lcd_window_height_mm = 89.00;
lcd_window_offset_x_mm = 1.00;
lcd_window_offset_y_mm = 4.00;
lcd_window_bevel_mm = 3.00;

lcd_pcb_width_mm = 164.90;
lcd_pcb_height_mm = 124.27;
lcd_module_thickness_mm = 8.30;
lcd_pcb_thickness_mm = 1.60;
lcd_hole_spacing_x_mm = 156.90;
lcd_hole_spacing_y_mm = 114.96;
lcd_hole_diameter_mm = 3.25;
lcd_boss_diameter_mm = 7.00;
lcd_boss_length_mm = lcd_module_thickness_mm - lcd_pcb_thickness_mm;
lcd_screw_inset_diameter_mm = 5.00;
lcd_screw_inset_depth_mm = 2.00;
lcd_perimeter_clearance_mm = 0.50;
source_panel_cell_margin_mm = max(
    0,
    wall_thickness_mm + lcd_perimeter_clearance_mm
        - (source_panel_height_mm - lcd_pcb_height_mm) / 2);
expanded_panel_height_mm = source_panel_height_mm
    + 2 * source_panel_cell_margin_mm;

// =========================================
// CASE, STAND, AND SERVICE-BAY DIMENSIONS
// =========================================

inter_panel_gap_mm = 5.00;
connector_clearance_mm = 25.40;
minimum_case_right_extension_mm = connector_clearance_mm + wall_thickness_mm;

// Portrait rotation moves the LCD connector edge to the top. The larger top
// extension preserves the 25.4 mm cable chase and fits the rotated Pi footprint.
portrait_top_clearance_mm = 45.00;
portrait_top_extension_mm = portrait_top_clearance_mm + wall_thickness_mm;

case_bottom_depth_mm = 42.00;

// =========================================
// RASPBERRY PI 4/5 MOUNTING DIMENSIONS
// =========================================

pi_board_width_mm = 85.00;
pi_board_height_mm = 56.00;
pi_hole_spacing_x_mm = 58.00;
pi_hole_spacing_y_mm = 49.00;
pi_hole_inset_x_mm = 3.50;
pi_hole_inset_y_mm = 3.50;
pi_oriented_width_mm = pi_board_height_mm;
pi_oriented_height_mm = pi_board_width_mm;
pi_edge_gap_mm = 2.00;
pi_lcd_min_gap_mm = 2.00;
pi_standoff_height_mm = 9.00;
pi_boss_diameter_mm = 7.00;
pi_pilot_hole_diameter_mm = 2.20;
pi_pilot_hole_depth_mm = 7.00;
pi_component_clearance_mm = 18.00;

pi_board_plane_z_mm = panel_thickness_mm + pi_standoff_height_mm;

// =========================================
// CONNECTOR ACCESS AND BOOLEAN DIMENSIONS
// =========================================

io_front_lip_depth_mm = 9.00;
pi_access_margin_mm = 4.00;
pi_right_access_height_mm = 72.00;
lcd_connector_access_y0_mm = 70.00;
lcd_connector_access_height_mm = 52.00;
lcd_connector_access_margin_mm = 4.00;
boolean_overlap_mm = 0.50;
boolean_thin_slice_mm = 0.02;
debug_axis_length_mm = 50.00;
debug_axis_radius_mm = 0.80;
debug_board_thickness_mm = 1.60;
debug_connector_envelope_depth_mm = 20.00;
debug_envelope_separation_mm = 0.05;

$fn = 48;

// =========================================
// LAYOUT COMPUTATION
// =========================================

layout_is_portrait = case_layout == "portrait" || case_layout == "dual_portrait";
lcd_columns = case_layout == "dual_portrait" ? 2 : 1;
lcd_rows = case_layout == "dual_landscape" ? 2 : 1;
lcd_cell_width_mm = layout_is_portrait
    ? expanded_panel_height_mm
    : source_panel_width_mm;
lcd_cell_height_mm = layout_is_portrait
    ? source_panel_width_mm
    : expanded_panel_height_mm;
layout_content_width_mm = lcd_columns * lcd_cell_width_mm
    + (lcd_columns - 1) * inter_panel_gap_mm;
layout_content_height_mm = lcd_rows * lcd_cell_height_mm
    + (lcd_rows - 1) * inter_panel_gap_mm;
lcd_connector_edge_x_mm = (source_panel_width_mm + lcd_pcb_width_mm) / 2;
landscape_case_right_extension_mm = max(
    minimum_case_right_extension_mm,
    lcd_connector_edge_x_mm + connector_clearance_mm
        + pi_oriented_width_mm + pi_edge_gap_mm + wall_thickness_mm
        - source_panel_width_mm);
case_right_extension_mm = layout_is_portrait
    ? minimum_case_right_extension_mm
    : landscape_case_right_extension_mm;
case_width_mm = layout_content_width_mm + case_right_extension_mm;
case_height_mm = layout_content_height_mm
    + (layout_is_portrait ? portrait_top_extension_mm : 0);

case_rear_edge_rise_mm = case_height_mm * tan(lcd_angle_from_table_deg);
case_top_depth_mm = case_bottom_depth_mm + case_rear_edge_rise_mm;
case_bottom_wall_inner_depth_mm = case_bottom_depth_mm
    + wall_thickness_mm * tan(lcd_angle_from_table_deg);
case_top_wall_inner_depth_mm = case_top_depth_mm
    - wall_thickness_mm * tan(lcd_angle_from_table_deg);
pi_board_x0_mm = case_width_mm - wall_thickness_mm - pi_edge_gap_mm
    - pi_oriented_width_mm;
pi_board_y0_mm = case_height_mm - wall_thickness_mm - pi_edge_gap_mm
    - pi_oriented_height_mm;

portrait_connector_access_x0_mm = source_panel_cell_margin_mm
    + source_panel_height_mm
    - (lcd_connector_access_y0_mm + lcd_connector_access_height_mm)
    - lcd_connector_access_margin_mm;
portrait_connector_access_width_mm = lcd_connector_access_height_mm
    + 2 * lcd_connector_access_margin_mm;
last_portrait_connector_access_x1_mm = (lcd_columns - 1)
    * (lcd_cell_width_mm + inter_panel_gap_mm)
    + portrait_connector_access_x0_mm + portrait_connector_access_width_mm;

lcd_pcb_x0_mm = (source_panel_width_mm - lcd_pcb_width_mm) / 2;
lcd_pcb_y0_mm = (source_panel_height_mm - lcd_pcb_height_mm) / 2;
lcd_hole_inset_x_mm = (lcd_pcb_width_mm - lcd_hole_spacing_x_mm) / 2;
lcd_hole_inset_y_mm = (lcd_pcb_height_mm - lcd_hole_spacing_y_mm) / 2;
lcd_window_x0_mm = (source_panel_width_mm - lcd_window_width_mm) / 2
    + lcd_window_offset_x_mm;
lcd_window_y0_mm = (source_panel_height_mm - lcd_window_height_mm) / 2
    + lcd_window_offset_y_mm;

lcd_hole_positions_mm = [
    [lcd_pcb_x0_mm + lcd_hole_inset_x_mm,
     lcd_pcb_y0_mm + lcd_hole_inset_y_mm],
    [lcd_pcb_x0_mm + lcd_pcb_width_mm - lcd_hole_inset_x_mm,
     lcd_pcb_y0_mm + lcd_hole_inset_y_mm],
    [lcd_pcb_x0_mm + lcd_hole_inset_x_mm,
     lcd_pcb_y0_mm + lcd_pcb_height_mm - lcd_hole_inset_y_mm],
    [lcd_pcb_x0_mm + lcd_pcb_width_mm - lcd_hole_inset_x_mm,
     lcd_pcb_y0_mm + lcd_pcb_height_mm - lcd_hole_inset_y_mm]
];

pi_hole_positions_mm = [
    [pi_hole_inset_x_mm, pi_hole_inset_y_mm],
    [pi_hole_inset_x_mm + pi_hole_spacing_x_mm, pi_hole_inset_y_mm],
    [pi_hole_inset_x_mm, pi_hole_inset_y_mm + pi_hole_spacing_y_mm],
    [pi_hole_inset_x_mm + pi_hole_spacing_x_mm,
     pi_hole_inset_y_mm + pi_hole_spacing_y_mm]
];

// =========================================
// DESIGN AND PRINT-FIT ASSERTIONS
// =========================================

assert(case_layout == "landscape" || case_layout == "portrait"
    || case_layout == "dual_portrait" || case_layout == "dual_landscape",
    str("Unsupported case_layout: ", case_layout));
assert(lcd_angle_from_table_deg >= 15 && lcd_angle_from_table_deg < 60,
    "lcd_angle_from_table_deg must be between 15 and 60 degrees");
assert(connector_clearance_mm >= 25.40,
    "Right-side connector clearance must remain at least 25.4 mm");
assert(case_width_mm <= printer_max_x_mm,
    str("Case width ", case_width_mm, " exceeds printer X=", printer_max_x_mm));
assert(case_height_mm <= printer_max_y_mm,
    str("Case height ", case_height_mm, " exceeds printer Y=", printer_max_y_mm));
assert(case_top_depth_mm <= printer_max_z_mm,
    str("Case depth ", case_top_depth_mm, " exceeds printer Z=", printer_max_z_mm,
        "; reduce lcd_angle_from_table_deg"));
assert(case_bottom_depth_mm >= pi_board_plane_z_mm + pi_component_clearance_mm,
    "case_bottom_depth_mm does not clear the Raspberry Pi component envelope");
assert(source_panel_cell_margin_mm + lcd_pcb_y0_mm
        >= wall_thickness_mm + lcd_perimeter_clearance_mm,
    "LCD PCB does not clear the case perimeter wall");
assert(pi_board_x0_mm >= 0 && pi_board_y0_mm >= 0,
    "Raspberry Pi footprint falls outside the case face");
assert(!layout_is_portrait
        ? pi_board_x0_mm >= lcd_pcb_x0_mm + lcd_pcb_width_mm + pi_lcd_min_gap_mm
        : pi_board_y0_mm >= lcd_pcb_x0_mm + lcd_pcb_width_mm + pi_lcd_min_gap_mm,
    "Raspberry Pi footprint overlaps the nearest LCD PCB envelope");
assert(layout_is_portrait
        ? pi_board_x0_mm >= last_portrait_connector_access_x1_mm + pi_lcd_min_gap_mm
        : pi_board_x0_mm >= lcd_connector_edge_x_mm + connector_clearance_mm,
    "Raspberry Pi footprint obstructs the LCD connector corridor");

// =========================================
// PRIMITIVES AND PLACEMENT HELPERS
// =========================================

/**
 * Rounded Rectangular Prism
 * Parameters: w, h, d, r are width, height, depth, and XY corner radius.
 * Bounding box: [0,0,0] to [w,h,d].
 * Alignment: Z-parallel rounded edges remain support-free face-down.
 */
module rounded_rect_prism(w, h, d, r) {
    hull() {
        translate([r, r, 0]) cylinder(h = d, r = r);
        translate([w - r, r, 0]) cylinder(h = d, r = r);
        translate([r, h - r, 0]) cylinder(h = d, r = r);
        translate([w - r, h - r, 0]) cylinder(h = d, r = r);
    }
}

/**
 * LCD Cell Transform
 * Parameters: column and row select an arranged source-panel cell.
 * Bounding box: one 254x135.27 landscape cell or 135.27x254 portrait cell.
 * Alignment: source features gain a 0.96 mm PCB-clearance border; portrait is
 * CCW so the viewer-right connector edge faces +Y.
 */
module lcd_cell_transform(column, row) {
    cell_x_mm = column * (lcd_cell_width_mm + inter_panel_gap_mm);
    cell_y_mm = row * (lcd_cell_height_mm + inter_panel_gap_mm);
    if (layout_is_portrait) {
        translate([
            cell_x_mm + source_panel_cell_margin_mm + source_panel_height_mm,
            cell_y_mm,
            0
        ])
            rotate([0, 0, 90]) children();
    } else {
        translate([cell_x_mm, cell_y_mm + source_panel_cell_margin_mm, 0])
            children();
    }
}

/**
 * Every LCD Cell
 * Parameters: none; passes children through each configured cell transform.
 * Bounding box: [0,0,0] to [layout_content_width,layout_content_height,*].
 * Alignment: cells are separated by inter_panel_gap_mm when dual.
 */
module every_lcd_cell() {
    for (column = [0 : lcd_columns - 1]) {
        for (row = [0 : lcd_rows - 1]) {
            lcd_cell_transform(column, row) children();
        }
    }
}

// =========================================
// LCD FEATURES
// =========================================

/**
 * LCD Window Cutout
 * Parameters: none; uses the inherited source-panel opening and front bevel.
 * Bounding box: [x0-bevel,y0-bevel,-overlap] through the panel thickness.
 * Alignment: centered as in waveshare-7inch-lcd-panel.scad (+1 X, +4 Y).
 */
module lcd_window_cutout() {
    hull() {
        translate([
            lcd_window_x0_mm - lcd_window_bevel_mm,
            lcd_window_y0_mm - lcd_window_bevel_mm,
            -boolean_overlap_mm
        ])
            rounded_rect_prism(
                lcd_window_width_mm + 2 * lcd_window_bevel_mm,
                lcd_window_height_mm + 2 * lcd_window_bevel_mm,
                boolean_thin_slice_mm,
                feature_corner_radius_mm);
        translate([
            lcd_window_x0_mm,
            lcd_window_y0_mm,
            panel_thickness_mm + boolean_overlap_mm - boolean_thin_slice_mm
        ])
            rounded_rect_prism(
                lcd_window_width_mm,
                lcd_window_height_mm,
                boolean_thin_slice_mm,
                feature_corner_radius_mm);
    }
}

/**
 * LCD Mounting Bosses
 * Parameters: none; creates four 7 mm bosses at Waveshare PCB holes.
 * Bounding box: Z=[panel_thickness,panel_thickness+lcd_boss_length].
 * Alignment: boss tips meet the PCB back when the glass meets the bezel back.
 */
module lcd_mounting_bosses() {
    for (position_mm = lcd_hole_positions_mm) {
        translate([position_mm[0], position_mm[1], panel_thickness_mm]) {
            cylinder(
                h = feature_corner_radius_mm,
                d1 = lcd_boss_diameter_mm + 2 * feature_corner_radius_mm,
                d2 = lcd_boss_diameter_mm);
            translate([0, 0, feature_corner_radius_mm])
                cylinder(
                    h = lcd_boss_length_mm - feature_corner_radius_mm,
                    d = lcd_boss_diameter_mm);
        }
    }
}

/**
 * LCD Screw Holes
 * Parameters: none; subtracts four M3 clearance holes through face and bosses.
 * Bounding box: each cylinder spans the complete face/boss stack along Z.
 * Alignment: concentric with Waveshare PCB holes; screws install from front.
 */
module lcd_screw_holes() {
    for (position_mm = lcd_hole_positions_mm) {
        translate([position_mm[0], position_mm[1], -boolean_overlap_mm])
            cylinder(
                h = panel_thickness_mm + lcd_boss_length_mm
                    + 2 * boolean_overlap_mm,
                d = lcd_hole_diameter_mm);
    }
}

/**
 * LCD Screw Head Insets
 * Parameters: none; subtracts four shallow front counterbores.
 * Bounding box: Z=[-overlap,lcd_screw_inset_depth].
 * Alignment: concentric with the M3 holes and below the display surface.
 */
module lcd_screw_head_insets() {
    for (position_mm = lcd_hole_positions_mm) {
        translate([position_mm[0], position_mm[1], -boolean_overlap_mm])
            cylinder(
                h = lcd_screw_inset_depth_mm + boolean_overlap_mm,
                d = lcd_screw_inset_diameter_mm);
    }
}

// =========================================
// CASE SHELL
// =========================================

/**
 * Case Face Slab
 * Parameters: none.
 * Bounding box: [0,0,0] to [case_width,case_height,panel_thickness].
 * Alignment: front surface is the build-plate contact plane at Z=0.
 */
module case_face_slab() {
    rounded_rect_prism(
        case_width_mm,
        case_height_mm,
        panel_thickness_mm,
        case_corner_radius_mm);
}

/**
 * Case Side Cheek
 * Parameter: x_start_mm places the left or right 5 mm cheek.
 * Bounding box: X=[x_start,x_start+wall], Y=[0,H], Z=[panel,top depth].
 * Alignment: sloped rear edge is the table-contact rail in use orientation.
 */
module case_side_cheek(x_start_mm) {
    hull() {
        translate([x_start_mm, 0, panel_thickness_mm - boolean_overlap_mm])
            cube([wall_thickness_mm, boolean_thin_slice_mm, boolean_thin_slice_mm]);
        translate([x_start_mm, case_height_mm - boolean_thin_slice_mm,
                   panel_thickness_mm - boolean_overlap_mm])
            cube([wall_thickness_mm, boolean_thin_slice_mm, boolean_thin_slice_mm]);
        translate([x_start_mm, 0,
                   case_bottom_depth_mm - boolean_thin_slice_mm])
            cube([wall_thickness_mm, boolean_thin_slice_mm, boolean_thin_slice_mm]);
        translate([x_start_mm, case_height_mm - boolean_thin_slice_mm,
                   case_top_depth_mm - boolean_thin_slice_mm])
            cube([wall_thickness_mm, boolean_thin_slice_mm, boolean_thin_slice_mm]);
    }
}

/**
 * Case Bottom Wall
 * Parameters: none.
 * Bounding box: X=[0,W], Y=[0,wall], Z=[panel,bottom-inner depth].
 * Alignment: rear edge follows the same table plane as both side cheeks.
 */
module case_bottom_wall() {
    hull() {
        translate([0, 0, panel_thickness_mm - boolean_overlap_mm])
            cube([
                case_width_mm,
                boolean_thin_slice_mm,
                case_bottom_depth_mm - panel_thickness_mm + boolean_overlap_mm
            ]);
        translate([
            0,
            wall_thickness_mm - boolean_thin_slice_mm,
            panel_thickness_mm - boolean_overlap_mm
        ])
            cube([
                case_width_mm,
                boolean_thin_slice_mm,
                case_bottom_wall_inner_depth_mm - panel_thickness_mm
                    + boolean_overlap_mm
            ]);
    }
}

/**
 * Case Top Wall
 * Parameters: none.
 * Bounding box: X=[0,W], Y=[H-wall,H], Z=[panel,top depth].
 * Alignment: rear edge follows the table plane; connector notches stay open.
 */
module case_top_wall() {
    hull() {
        translate([
            0,
            case_height_mm - wall_thickness_mm,
            panel_thickness_mm - boolean_overlap_mm
        ])
            cube([
                case_width_mm,
                boolean_thin_slice_mm,
                case_top_wall_inner_depth_mm - panel_thickness_mm
                    + boolean_overlap_mm
            ]);
        translate([
            0,
            case_height_mm - boolean_thin_slice_mm,
            panel_thickness_mm - boolean_overlap_mm
        ])
            cube([
                case_width_mm,
                boolean_thin_slice_mm,
                case_top_depth_mm - panel_thickness_mm + boolean_overlap_mm
            ]);
    }
}

// =========================================
// RASPBERRY PI MOUNT AND ACCESS
// =========================================

/**
 * Raspberry Pi Hole Transform
 * Parameters: none; transforms Pi 4/5 hole coordinates by 90 degrees CCW.
 * Bounding box: the transformed holes occupy a 49x58 mm pitch.
 * Alignment: board USB edge faces +Y and power/video edge faces +X.
 */
module every_pi_hole() {
    for (position_mm = pi_hole_positions_mm) {
        translate([
            pi_board_x0_mm + pi_board_height_mm - position_mm[1],
            pi_board_y0_mm + position_mm[0],
            0
        ]) children();
    }
}

/**
 * Raspberry Pi Mounting Bosses
 * Parameters: none; four self-tapping M2.5 pilot bosses.
 * Bounding box: Z=[panel_thickness,pi_board_plane_z].
 * Alignment: bosses rise only from solid service-panel material, not LCD areas.
 */
module pi_mounting_bosses() {
    every_pi_hole()
        translate([0, 0, panel_thickness_mm])
            cylinder(h = pi_standoff_height_mm, d = pi_boss_diameter_mm);
}

/**
 * Raspberry Pi Pilot Holes
 * Parameters: none; subtracts four 2.2 mm blind pilot holes.
 * Bounding box: the final 7 mm of each Pi boss along Z.
 * Alignment: accepts M2.5 self-tapping screws inserted from the open rear.
 */
module pi_pilot_holes() {
    every_pi_hole()
        translate([
            0,
            0,
            pi_board_plane_z_mm - pi_pilot_hole_depth_mm
        ])
            cylinder(
                h = pi_pilot_hole_depth_mm + boolean_overlap_mm,
                d = pi_pilot_hole_diameter_mm);
}

/**
 * Raspberry Pi Right Access
 * Parameters: none; opens the USB-C/micro-HDMI edge through the right cheek.
 * Bounding box: rear-open notch at +X beside the lower portion of the Pi edge.
 * Alignment: also provides general cable egress and tool access.
 */
module pi_right_access_cutout() {
    translate([
        case_width_mm - wall_thickness_mm - boolean_overlap_mm,
        pi_board_y0_mm - pi_access_margin_mm,
        io_front_lip_depth_mm
    ])
        cube([
            wall_thickness_mm + 2 * boolean_overlap_mm,
            pi_right_access_height_mm,
            case_top_depth_mm + boolean_overlap_mm
        ]);
}

/**
 * Raspberry Pi Top Access
 * Parameters: none; opens the USB/Ethernet edge through the top wall.
 * Bounding box: rear-open notch at +Y across the transformed Pi width.
 * Alignment: board edge sits pi_edge_gap_mm inside the wall for plug insertion.
 */
module pi_top_access_cutout() {
    translate([
        pi_board_x0_mm - pi_access_margin_mm,
        case_height_mm - wall_thickness_mm - boolean_overlap_mm,
        io_front_lip_depth_mm
    ])
        cube([
            pi_oriented_width_mm + 2 * pi_access_margin_mm,
            wall_thickness_mm + 2 * boolean_overlap_mm,
            case_top_depth_mm + boolean_overlap_mm
        ]);
}

/**
 * LCD Connector Access
 * Parameters: none; one broad rear-open notch per physical connector edge.
 * Bounding box: right cheek for landscape, top wall for portrait.
 * Alignment: connector edge is +X landscape and +Y after CCW portrait rotation.
 */
module lcd_connector_access_cutouts() {
    if (layout_is_portrait) {
        for (column = [0 : lcd_columns - 1]) {
            cell_x_mm = column * (lcd_cell_width_mm + inter_panel_gap_mm);
            translate([
                cell_x_mm + portrait_connector_access_x0_mm,
                case_height_mm - wall_thickness_mm - boolean_overlap_mm,
                io_front_lip_depth_mm
            ])
                cube([
                    portrait_connector_access_width_mm,
                    wall_thickness_mm + 2 * boolean_overlap_mm,
                    case_top_depth_mm + boolean_overlap_mm
                ]);
        }
    } else {
        for (row = [0 : lcd_rows - 1]) {
            cell_y_mm = row * (lcd_cell_height_mm + inter_panel_gap_mm);
            translate([
                case_width_mm - wall_thickness_mm - boolean_overlap_mm,
                cell_y_mm + source_panel_cell_margin_mm
                    + lcd_connector_access_y0_mm
                    - lcd_connector_access_margin_mm,
                io_front_lip_depth_mm
            ])
                cube([
                    wall_thickness_mm + 2 * boolean_overlap_mm,
                    lcd_connector_access_height_mm
                        + 2 * lcd_connector_access_margin_mm,
                    case_top_depth_mm + boolean_overlap_mm
                ]);
        }
    }
}

// =========================================
// FINAL PRINTABLE ASSEMBLY
// =========================================

/**
 * LCD Raspberry Pi Case
 * Parameters: none; produces the complete single-piece printable case.
 * Bounding box: [0,0,0] to [case_width,case_height,case_top_depth].
 * Alignment: print the front face at Z=0; the rear remains open.
 */
module lcd_raspberry_pi_case() {
    difference() {
        union() {
            case_face_slab();
            case_side_cheek(0);
            case_side_cheek(case_width_mm - wall_thickness_mm);
            case_bottom_wall();
            case_top_wall();
            every_lcd_cell() lcd_mounting_bosses();
            pi_mounting_bosses();
        }

        every_lcd_cell() lcd_window_cutout();
        every_lcd_cell() lcd_screw_holes();
        every_lcd_cell() lcd_screw_head_insets();
        pi_pilot_holes();
        pi_right_access_cutout();
        pi_top_access_cutout();
        lcd_connector_access_cutouts();
    }
}

// =========================================
// DEBUG AND VISUALIZATION
// =========================================

/**
 * Debug Axes
 * Parameter: length_mm controls axis length.
 * Bounding box: axis cylinders extend from the origin in +X/+Y/+Z.
 * Alignment: red=X, green=Y, blue=Z.
 */
module debug_axes(length_mm = debug_axis_length_mm) {
    color("Red")
        rotate([0, 90, 0]) cylinder(h = length_mm, r = debug_axis_radius_mm);
    color("Green")
        rotate([-90, 0, 0]) cylinder(h = length_mm, r = debug_axis_radius_mm);
    color("Blue")
        cylinder(h = length_mm, r = debug_axis_radius_mm);
}

/**
 * Debug Hardware Envelopes
 * Parameters: none; shows LCD PCBs and the rotated Raspberry Pi board.
 * Bounding box: transparent reference bodies remain inside the case envelope.
 * Alignment: LCDs sit on boss tips; Pi sits on its four service-area bosses.
 */
module debug_hardware_envelopes() {
    color("DarkSlateGray", 0.60)
        every_lcd_cell()
            translate([
                lcd_pcb_x0_mm,
                lcd_pcb_y0_mm,
                panel_thickness_mm + lcd_boss_length_mm
                    + debug_envelope_separation_mm
            ])
                cube([
                    lcd_pcb_width_mm,
                    lcd_pcb_height_mm,
                    debug_board_thickness_mm
                ]);

    color("ForestGreen", 0.70)
        translate([
            pi_board_x0_mm,
            pi_board_y0_mm,
            pi_board_plane_z_mm + debug_envelope_separation_mm
        ])
            cube([
                pi_oriented_width_mm,
                pi_oriented_height_mm,
                debug_board_thickness_mm
            ]);

    color("DarkOrange", 0.35)
        every_lcd_cell()
            translate([
                lcd_connector_edge_x_mm + debug_envelope_separation_mm,
                lcd_connector_access_y0_mm,
                panel_thickness_mm + debug_envelope_separation_mm
            ])
                cube([
                    connector_clearance_mm
                        - 2 * debug_envelope_separation_mm,
                    lcd_connector_access_height_mm,
                    debug_connector_envelope_depth_mm
                ]);
}

/**
 * Assembly Colored
 * Parameters: none; renders the complete printable case in one opaque color.
 * Bounding box: [0,0,0] to [case_width,case_height,case_top_depth].
 * Alignment: identical to the exported STL with its front at Z=0.
 */
module assembly_colored() {
    color("LightSlateGray") lcd_raspberry_pi_case();
}

/**
 * Assembly X-Ray
 * Parameters: none; overlays LCD, cable, and Pi envelopes on a transparent case.
 * Bounding box: remains within the complete configured case envelope.
 * Alignment: hardware references sit just above their mounting surfaces.
 */
module assembly_xray() {
    color("SteelBlue", 0.25) lcd_raspberry_pi_case();
    debug_hardware_envelopes();
}

if (render_mode == "xray") {
    assembly_xray();
} else if (render_mode == "debug") {
    assembly_xray();
    debug_axes();
} else {
    assembly_colored();
}
