/**
 * Shared generator for closed Waveshare 7-inch LCD + Raspberry Pi cases.
 *
 * ASSEMBLED COORDINATE SYSTEM
 *   X = case width across the display
 *   Y = case footprint depth on the table
 *   Z = height above the table
 *
 * PRINT ORIENTATION
 *   Base: solid floor at Z=0, walls and Pi bosses grow upward.
 *   Lid:  LCD front at Z=0, face-down; skirt and LCD bosses grow upward.
 *
 * COMPONENT INDEX
 *   case_base             solid floor, four continuous walls, Pi bosses
 *   base_floor            [0,0,0] to [base_width,base_depth,5]
 *   base_side_wall        5 mm side walls with sloped lid-contact edges
 *   base_front_wall       5 mm wall at Y=0
 *   base_rear_wall        5 mm wall at Y=base_depth
 *   pi_mounting_bosses    four floor-mounted Pi 4/5 bosses
 *   case_lid              LCD faceplate with outside cap skirt
 *   lid_plate             front plate holding LCD openings and screws
 *   lid_outer_skirt       two outside side rails locating the removable lid
 *   lcd_mounting_bosses   four per display on the lid underside
 *   cable_notches         localized 10 mm passages in base and lid skirt
 *
 * The Pi is always mounted to the solid base behind the LCD lid. It never
 * shares the LCD mounting plate. The default assembly places the lid at
 * lcd_angle_from_table_deg and derives base footprint/depth from that angle.
 */

// =========================================
// PRINTER AND COMMON CASE DIMENSIONS
// =========================================

printer_max_x_mm = 325.00;
printer_max_y_mm = 320.00;
printer_max_z_mm = 325.00;

wall_thickness_mm = 5.00;
floor_thickness_mm = 5.00;
lid_thickness_mm = 5.00;
case_corner_radius_mm = 4.00;
feature_corner_radius_mm = 1.00;
lcd_perimeter_clearance_mm = 0.50;

lid_skirt_thickness_mm = 2.00;
lid_skirt_clearance_mm = 0.40;
lid_skirt_depth_mm = 4.00;
lid_overhang_mm = lid_skirt_thickness_mm + lid_skirt_clearance_mm;

base_front_height_mm = 55.00;
inter_panel_gap_mm = 5.00;
connector_clearance_mm = 25.40;
case_right_extension_mm = connector_clearance_mm + wall_thickness_mm;
portrait_top_extension_mm = connector_clearance_mm + wall_thickness_mm;

// =========================================
// WAVESHARE LCD DIMENSIONS
// =========================================

source_panel_width_mm = 254.00;
source_panel_height_mm = 133.35;

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

// =========================================
// RASPBERRY PI 4/5 DIMENSIONS
// =========================================

pi_board_width_mm = 85.00;
pi_board_height_mm = 56.00;
pi_board_thickness_mm = 1.60;
pi_hole_spacing_x_mm = 58.00;
pi_hole_spacing_y_mm = 49.00;
pi_hole_inset_x_mm = 3.50;
pi_hole_inset_y_mm = 3.50;
pi_wall_gap_mm = 2.00;
pi_standoff_height_mm = 9.00;
pi_boss_diameter_mm = 7.00;
pi_pilot_hole_diameter_mm = 2.20;
pi_pilot_hole_depth_mm = 7.00;
pi_component_clearance_mm = 18.00;
electronics_vertical_gap_mm = 8.00;

pi_hole_positions_mm = [
    [pi_hole_inset_x_mm, pi_hole_inset_y_mm],
    [pi_hole_inset_x_mm + pi_hole_spacing_x_mm, pi_hole_inset_y_mm],
    [pi_hole_inset_x_mm, pi_hole_inset_y_mm + pi_hole_spacing_y_mm],
    [pi_hole_inset_x_mm + pi_hole_spacing_x_mm,
     pi_hole_inset_y_mm + pi_hole_spacing_y_mm]
];

// =========================================
// LOCALIZED CABLE PASSAGES
// =========================================

cable_hole_width_mm = 10.00;
cable_notch_depth_mm = 12.00;
cable_boolean_margin_mm = 0.50;

// Approximate cable-routing positions, not connector-shaped wall openings.
pi_front_cable_x_offsets_mm = [12.00, 30.00, 48.00];
pi_right_cable_y_offsets_mm = [18.00, 40.00];

// =========================================
// BOOLEAN, DEBUG, AND FACET DIMENSIONS
// =========================================

boolean_overlap_mm = 0.50;
boolean_thin_slice_mm = 0.02;
debug_axis_length_mm = 50.00;
debug_axis_radius_mm = 0.80;
debug_envelope_separation_mm = 0.05;

$fn = 48;

// =========================================
// LAYOUT AND ANGLE COMPUTATION
// =========================================

layout_is_portrait = case_layout == "portrait" || case_layout == "dual_portrait";
lcd_columns = case_layout == "dual_portrait" ? 2 : 1;
lcd_rows = case_layout == "dual_landscape" ? 2 : 1;

// The margin grows with angle because a vertical base wall projects farther
// across the underside of the tilted lid than its nominal 5 mm thickness.
source_panel_cell_margin_mm = max(
    0,
    wall_thickness_mm / cos(lcd_angle_from_table_deg)
        + lcd_perimeter_clearance_mm - lcd_pcb_y0_mm);
expanded_panel_height_mm = source_panel_height_mm
    + 2 * source_panel_cell_margin_mm;

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

case_panel_width_mm = layout_content_width_mm + case_right_extension_mm;
case_panel_height_mm = layout_content_height_mm
    + (layout_is_portrait ? portrait_top_extension_mm : 0);

base_width_mm = case_panel_width_mm;
base_depth_mm = case_panel_height_mm * cos(lcd_angle_from_table_deg);
base_rear_height_mm = base_front_height_mm
    + case_panel_height_mm * sin(lcd_angle_from_table_deg);

lid_width_mm = case_panel_width_mm + 2 * lid_overhang_mm;
lid_height_mm = case_panel_height_mm + 2 * lid_overhang_mm;
lid_part_depth_mm = max(
    lid_thickness_mm + lid_skirt_depth_mm,
    lid_thickness_mm + lcd_boss_length_mm);

pi_board_x0_mm = base_width_mm - wall_thickness_mm
    - pi_wall_gap_mm - pi_board_width_mm;
pi_board_y0_mm = wall_thickness_mm + pi_wall_gap_mm;
pi_board_plane_z_mm = floor_thickness_mm + pi_standoff_height_mm;

pi_front_cable_x_centers_mm = [
    for (offset_mm = pi_front_cable_x_offsets_mm)
        pi_board_x0_mm + offset_mm
];
pi_right_cable_y_centers_mm = [
    for (offset_mm = pi_right_cable_y_offsets_mm)
        pi_board_y0_mm + offset_mm
];

function base_top_z_mm(y_mm) = base_front_height_mm
    + y_mm * tan(lcd_angle_from_table_deg);

// =========================================
// FIT AND HARDWARE ASSERTIONS
// =========================================

assert(case_layout == "landscape" || case_layout == "portrait"
    || case_layout == "dual_portrait" || case_layout == "dual_landscape",
    str("Unsupported case_layout: ", case_layout));
assert(part == "assembly" || part == "base" || part == "lid",
    str("Unsupported part: ", part));
assert(lcd_angle_from_table_deg >= 15 && lcd_angle_from_table_deg < 60,
    "lcd_angle_from_table_deg must be between 15 and 60 degrees");
assert(connector_clearance_mm >= 25.40,
    "LCD connector service region must remain at least 25.4 mm");
assert(cable_hole_width_mm == 10.00,
    "Wall cable passages must remain 10 mm wide");
assert(source_panel_cell_margin_mm + lcd_pcb_y0_mm
        >= wall_thickness_mm / cos(lcd_angle_from_table_deg)
            + lcd_perimeter_clearance_mm,
    "LCD PCB does not clear the closed base wall");
assert(pi_board_x0_mm >= wall_thickness_mm
        && pi_board_y0_mm >= wall_thickness_mm,
    "Raspberry Pi does not fit on the solid base floor");
assert(base_front_height_mm
        - (lid_thickness_mm + lcd_module_thickness_mm)
            * cos(lcd_angle_from_table_deg)
        >= pi_board_plane_z_mm + pi_board_thickness_mm
            + pi_component_clearance_mm + electronics_vertical_gap_mm,
    "Front enclosure height does not separate Pi and LCD hardware");
assert(base_width_mm <= printer_max_x_mm,
    str("Base width ", base_width_mm, " exceeds printer X"));
assert(base_depth_mm <= printer_max_y_mm,
    str("Base depth ", base_depth_mm, " exceeds printer Y"));
assert(base_rear_height_mm <= printer_max_z_mm,
    str("Base height ", base_rear_height_mm, " exceeds printer Z"));
assert(lid_width_mm <= printer_max_x_mm,
    str("Lid width ", lid_width_mm, " exceeds printer X"));
assert(lid_height_mm <= printer_max_y_mm,
    str("Lid height ", lid_height_mm, " exceeds printer Y"));
assert(lid_part_depth_mm <= printer_max_z_mm,
    str("Lid depth ", lid_part_depth_mm, " exceeds printer Z"));

// =========================================
// SHARED PRIMITIVES AND TRANSFORMS
// =========================================

/**
 * Rounded Rectangular Prism
 * Parameters: w, h, d, r define width, height, depth, and XY radius.
 * Bounding box: [0,0,0] to [w,h,d].
 * Alignment: vertical rounded edges are support-free in both print layouts.
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
 * Parameters: column and row select one arranged LCD feature cell.
 * Bounding box: source panel plus the angle-derived perimeter clearance.
 * Alignment: all features are offset by lid_overhang_mm on the cap plate.
 */
module lcd_cell_transform(column, row) {
    cell_x_mm = column * (lcd_cell_width_mm + inter_panel_gap_mm);
    cell_y_mm = row * (lcd_cell_height_mm + inter_panel_gap_mm);
    if (layout_is_portrait) {
        translate([
            lid_overhang_mm + cell_x_mm + source_panel_cell_margin_mm
                + source_panel_height_mm,
            lid_overhang_mm + cell_y_mm,
            0
        ])
            rotate([0, 0, 90]) children();
    } else {
        translate([
            lid_overhang_mm + cell_x_mm,
            lid_overhang_mm + cell_y_mm + source_panel_cell_margin_mm,
            0
        ]) children();
    }
}

/**
 * Every LCD Cell
 * Parameters: none; repeats children through the configured display layout.
 * Bounding box: contained by the central case_panel region of the lid.
 * Alignment: dual layouts use a 5 mm solid separator band.
 */
module every_lcd_cell() {
    for (column = [0 : lcd_columns - 1]) {
        for (row = [0 : lcd_rows - 1]) {
            lcd_cell_transform(column, row) children();
        }
    }
}

/**
 * Assembled Lid Transform
 * Parameters: none; maps the flat printable lid onto the sloped base rim.
 * Bounding box: cap overhang surrounds the complete base footprint.
 * Alignment: lid back face contacts the base at lcd_angle_from_table_deg.
 */
module assembled_lid_transform() {
    translate([
        -lid_overhang_mm,
        -lid_overhang_mm * cos(lcd_angle_from_table_deg)
            - lid_thickness_mm * sin(lcd_angle_from_table_deg),
        base_front_height_mm
            - lid_overhang_mm * sin(lcd_angle_from_table_deg)
            + lid_thickness_mm * cos(lcd_angle_from_table_deg)
    ])
        rotate([lcd_angle_from_table_deg, 0, 0])
            mirror([0, 0, 1]) children();
}

// =========================================
// LCD LID FEATURES
// =========================================

/**
 * LCD Window Cutout
 * Parameters: none; preserves the existing 156 x 89 mm back opening.
 * Bounding box: the front opening adds a 3 mm bevel on every edge.
 * Alignment: front opening is larger and narrows with print Z.
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
            lid_thickness_mm + boolean_overlap_mm - boolean_thin_slice_mm
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
 * Parameters: none; creates four lid-mounted supports per LCD.
 * Bounding box: Z=[lid_thickness,lid_thickness+lcd_boss_length].
 * Alignment: LCD glass faces the lid; PCB remains wholly above the Pi floor.
 */
module lcd_mounting_bosses() {
    for (position_mm = lcd_hole_positions_mm) {
        translate([position_mm[0], position_mm[1], lid_thickness_mm]) {
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
 * Parameters: none; subtracts four M3 clearance holes through lid and bosses.
 * Bounding box: through the complete lid/boss stack along print Z.
 * Alignment: inherits the exact Waveshare four-hole pattern.
 */
module lcd_screw_holes() {
    for (position_mm = lcd_hole_positions_mm) {
        translate([position_mm[0], position_mm[1], -boolean_overlap_mm])
            cylinder(
                h = lid_thickness_mm + lcd_boss_length_mm
                    + 2 * boolean_overlap_mm,
                d = lcd_hole_diameter_mm);
    }
}

/**
 * LCD Screw Head Insets
 * Parameters: none; subtracts shallow front counterbores.
 * Bounding box: Z=[0,lcd_screw_inset_depth].
 * Alignment: concentric with the LCD M3 holes.
 */
module lcd_screw_head_insets() {
    for (position_mm = lcd_hole_positions_mm) {
        translate([position_mm[0], position_mm[1], -boolean_overlap_mm])
            cylinder(
                h = lcd_screw_inset_depth_mm + boolean_overlap_mm,
                d = lcd_screw_inset_diameter_mm);
    }
}

/**
 * Lid Plate
 * Parameters: none; full removable front cap carrying every LCD.
 * Bounding box: [0,0,0] to [lid_width,lid_height,lid_thickness].
 * Alignment: front face Z=0 prints on the build plate.
 */
module lid_plate() {
    rounded_rect_prism(
        lid_width_mm,
        lid_height_mm,
        lid_thickness_mm,
        case_corner_radius_mm);
}

/**
 * Lid Outer Skirt
 * Parameters: none; two cap rails fitting outside the left/right base walls.
 * Bounding box: full lid Y on the first/last 2 mm of X, behind the plate.
 * Alignment: rails follow the tilt axis, so they cannot bind front/rear walls.
 */
module lid_outer_skirt() {
    translate([0, 0, lid_thickness_mm])
        cube([
            lid_skirt_thickness_mm,
            lid_height_mm,
            lid_skirt_depth_mm
        ]);
    translate([
        lid_width_mm - lid_skirt_thickness_mm,
        0,
        lid_thickness_mm
    ])
        cube([
            lid_skirt_thickness_mm,
            lid_height_mm,
            lid_skirt_depth_mm
        ]);
}

/**
 * Lid Cable Notches
 * Parameters: none; matches the two right-wall 10 mm cable passages.
 * Bounding box: localized openings through the right side cap rail.
 * Alignment: front passages need no relief because there is no front rail.
 */
module lid_cable_notches() {
    local_hole_width_mm = cable_hole_width_mm
        / cos(lcd_angle_from_table_deg);
    for (y_center_mm = pi_right_cable_y_centers_mm) {
        local_y_center_mm = lid_overhang_mm
            + y_center_mm / cos(lcd_angle_from_table_deg);
        translate([
            lid_width_mm - lid_skirt_thickness_mm - boolean_overlap_mm,
            local_y_center_mm - local_hole_width_mm / 2,
            lid_thickness_mm - boolean_overlap_mm
        ])
            cube([
                lid_skirt_thickness_mm + 2 * boolean_overlap_mm,
                local_hole_width_mm,
                lid_skirt_depth_mm + 2 * boolean_overlap_mm
            ]);
    }
}

/**
 * Complete LCD Lid
 * Parameters: none; printable cap with LCDs, skirt, and cable passages.
 * Bounding box: [0,0,0] to [lid_width,lid_height,lid_part_depth].
 * Alignment: print face-down; install over the outside of the base walls.
 */
module case_lid() {
    difference() {
        union() {
            lid_plate();
            lid_outer_skirt();
            every_lcd_cell() lcd_mounting_bosses();
        }
        every_lcd_cell() lcd_window_cutout();
        every_lcd_cell() lcd_screw_holes();
        every_lcd_cell() lcd_screw_head_insets();
        lid_cable_notches();
    }
}

// =========================================
// SOLID-BOTTOM BASE
// =========================================

/**
 * Base Floor
 * Parameters: none; solid bottom supporting the Pi mounting bosses.
 * Bounding box: [0,0,0] to [base_width,base_depth,floor_thickness].
 * Alignment: flat Z=0 surface prints directly on the build plate.
 */
module base_floor() {
    rounded_rect_prism(
        base_width_mm,
        base_depth_mm,
        floor_thickness_mm,
        case_corner_radius_mm);
}

/**
 * Base Side Wall
 * Parameter: x_start_mm selects left or right wall.
 * Bounding box: X wall thickness, full base Y, Z to the sloped lid plane.
 * Alignment: top edge follows base_top_z_mm(y) exactly.
 */
module base_side_wall(x_start_mm) {
    hull() {
        translate([x_start_mm, 0, 0])
            cube([
                wall_thickness_mm,
                boolean_thin_slice_mm,
                base_front_height_mm
            ]);
        translate([x_start_mm, base_depth_mm - boolean_thin_slice_mm, 0])
            cube([
                wall_thickness_mm,
                boolean_thin_slice_mm,
                base_rear_height_mm
            ]);
    }
}

/**
 * Base Front Wall
 * Parameters: none; continuous wall containing three small cable notches.
 * Bounding box: X=[0,W], Y=[0,wall], Z to the sloped lid plane.
 * Alignment: connects both side walls and the solid floor.
 */
module base_front_wall() {
    hull() {
        translate([0, 0, 0])
            cube([
                base_width_mm,
                boolean_thin_slice_mm,
                base_front_height_mm
            ]);
        translate([0, wall_thickness_mm - boolean_thin_slice_mm, 0])
            cube([
                base_width_mm,
                boolean_thin_slice_mm,
                base_top_z_mm(wall_thickness_mm)
            ]);
    }
}

/**
 * Base Rear Wall
 * Parameters: none; uninterrupted rear enclosure wall.
 * Bounding box: X=[0,W], final 5 mm of base Y, Z to rear lid plane.
 * Alignment: closes the enclosure behind all hardware.
 */
module base_rear_wall() {
    hull() {
        translate([0, base_depth_mm - wall_thickness_mm, 0])
            cube([
                base_width_mm,
                boolean_thin_slice_mm,
                base_top_z_mm(base_depth_mm - wall_thickness_mm)
            ]);
        translate([0, base_depth_mm - boolean_thin_slice_mm, 0])
            cube([
                base_width_mm,
                boolean_thin_slice_mm,
                base_rear_height_mm
            ]);
    }
}

/**
 * Base Walls
 * Parameters: none; combines and corner-clips all four continuous walls.
 * Bounding box: base footprint through the variable-height lid plane.
 * Alignment: rounded outer corner envelope matches floor and lid cap.
 */
module base_walls() {
    intersection() {
        union() {
            base_side_wall(0);
            base_side_wall(base_width_mm - wall_thickness_mm);
            base_front_wall();
            base_rear_wall();
        }
        rounded_rect_prism(
            base_width_mm,
            base_depth_mm,
            base_rear_height_mm + boolean_overlap_mm,
            case_corner_radius_mm);
    }
}

/**
 * Raspberry Pi Mounting Bosses
 * Parameters: none; four vertical bosses attached to the solid floor.
 * Bounding box: Z=[floor_thickness,pi_board_plane_z].
 * Alignment: Pi lies flat behind the LCD lid with USB right, power/video front.
 */
module pi_mounting_bosses() {
    for (position_mm = pi_hole_positions_mm) {
        translate([
            pi_board_x0_mm + position_mm[0],
            pi_board_y0_mm + position_mm[1],
            floor_thickness_mm
        ])
            cylinder(h = pi_standoff_height_mm, d = pi_boss_diameter_mm);
    }
}

/**
 * Raspberry Pi Pilot Holes
 * Parameters: none; subtracts 2.2 mm blind holes for M2.5 screws.
 * Bounding box: final 7 mm of each Pi mounting boss.
 * Alignment: screws install from the open base before the lid is fitted.
 */
module pi_pilot_holes() {
    for (position_mm = pi_hole_positions_mm) {
        translate([
            pi_board_x0_mm + position_mm[0],
            pi_board_y0_mm + position_mm[1],
            pi_board_plane_z_mm - pi_pilot_hole_depth_mm
        ])
            cylinder(
                h = pi_pilot_hole_depth_mm + boolean_overlap_mm,
                d = pi_pilot_hole_diameter_mm);
    }
}

/**
 * Front Cable Notches
 * Parameters: none; three 10 mm passages for Pi power and video cabling.
 * Bounding box: localized openings in the top 12 mm of the front wall.
 * Alignment: open at the sloped rim, avoiding unsupported roofs.
 */
module front_cable_notches() {
    for (x_center_mm = pi_front_cable_x_centers_mm) {
        translate([
            x_center_mm - cable_hole_width_mm / 2,
            -boolean_overlap_mm,
            base_front_height_mm - cable_notch_depth_mm
        ])
            cube([
                cable_hole_width_mm,
                wall_thickness_mm + 2 * boolean_overlap_mm,
                cable_notch_depth_mm
                    + wall_thickness_mm * tan(lcd_angle_from_table_deg)
                    + 2 * boolean_overlap_mm
            ]);
    }
}

/**
 * Right Cable Notches
 * Parameters: none; two 10 mm passages for USB/network cable routing.
 * Bounding box: localized sloped-bottom openings in the right wall top edge.
 * Alignment: each notch follows the lid plane and stays open during printing.
 */
module right_cable_notches() {
    for (y_center_mm = pi_right_cable_y_centers_mm) {
        y0_mm = y_center_mm - cable_hole_width_mm / 2;
        y1_mm = y_center_mm + cable_hole_width_mm / 2;
        hull() {
            translate([
                base_width_mm - wall_thickness_mm - boolean_overlap_mm,
                y0_mm,
                base_top_z_mm(y0_mm) - cable_notch_depth_mm
            ])
                cube([
                    wall_thickness_mm + 2 * boolean_overlap_mm,
                    boolean_thin_slice_mm,
                    cable_notch_depth_mm + boolean_overlap_mm
                ]);
            translate([
                base_width_mm - wall_thickness_mm - boolean_overlap_mm,
                y1_mm - boolean_thin_slice_mm,
                base_top_z_mm(y1_mm) - cable_notch_depth_mm
            ])
                cube([
                    wall_thickness_mm + 2 * boolean_overlap_mm,
                    boolean_thin_slice_mm,
                    cable_notch_depth_mm + boolean_overlap_mm
                ]);
        }
    }
}

/**
 * Complete Solid-Bottom Base
 * Parameters: none; closed tray with Pi mounting and small cable passages.
 * Bounding box: [0,0,0] to [base_width,base_depth,base_rear_height].
 * Alignment: print floor-down; install Pi before pressing on the lid.
 */
module case_base() {
    difference() {
        union() {
            base_floor();
            base_walls();
            pi_mounting_bosses();
        }
        pi_pilot_holes();
        front_cable_notches();
        right_cable_notches();
    }
}

// =========================================
// DEBUG AND ASSEMBLY RENDERS
// =========================================

/**
 * Debug LCD Screens
 * Parameters: none; dark reference planes fill LCD windows in assembly renders.
 * Bounding box: one nominal window per configured LCD at the lid front.
 * Alignment: sits just outside printable geometry and is never exported as part.
 */
module debug_lcd_screens() {
    color("MidnightBlue")
        every_lcd_cell()
            translate([
                lcd_window_x0_mm,
                lcd_window_y0_mm,
                -debug_envelope_separation_mm
            ])
                rounded_rect_prism(
                    lcd_window_width_mm,
                    lcd_window_height_mm,
                    boolean_thin_slice_mm,
                    feature_corner_radius_mm);
}

/**
 * Debug Hardware Envelopes
 * Parameters: none; displays Pi and LCD PCB locations inside the closed case.
 * Bounding box: all envelopes remain inside the assembled enclosure.
 * Alignment: Pi is floor-mounted; LCD PCBs follow the removable lid.
 */
module debug_hardware_envelopes() {
    color("ForestGreen", 0.75)
        translate([
            pi_board_x0_mm,
            pi_board_y0_mm,
            pi_board_plane_z_mm + debug_envelope_separation_mm
        ])
            cube([
                pi_board_width_mm,
                pi_board_height_mm,
                pi_board_thickness_mm
            ]);

    color("DarkSlateGray", 0.60)
        assembled_lid_transform()
            every_lcd_cell()
                translate([
                    lcd_pcb_x0_mm,
                    lcd_pcb_y0_mm,
                    lid_thickness_mm + lcd_boss_length_mm
                        + debug_envelope_separation_mm
                ])
                    cube([
                        lcd_pcb_width_mm,
                        lcd_pcb_height_mm,
                        lcd_pcb_thickness_mm
                    ]);
}

/**
 * Debug Axes
 * Parameter: length_mm controls axis length from the assembly origin.
 * Bounding box: cylinders extend along +X, +Y, and +Z.
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
 * Assembly Colored
 * Parameters: none; closed enclosure preview with installed screen references.
 * Bounding box: base plus the small lid cap overhang.
 * Alignment: base floor lies on table Z=0 and LCD plane uses selected angle.
 */
module assembly_colored() {
    color("SlateGray") case_base();
    assembled_lid_transform() {
        color("LightGray") case_lid();
        debug_lcd_screens();
    }
}

/**
 * Assembly X-Ray
 * Parameters: none; transparent closed enclosure with internal hardware.
 * Bounding box: matches the assembled base and lid.
 * Alignment: verifies Pi is behind the LCD lid and clear of all walls.
 */
module assembly_xray() {
    color("SteelBlue", 0.22) case_base();
    color("LightSteelBlue", 0.22)
        assembled_lid_transform() case_lid();
    debug_hardware_envelopes();
    debug_axes();
}

if (part == "base") {
    case_base();
} else if (part == "lid") {
    case_lid();
} else if (render_mode == "xray") {
    assembly_xray();
} else {
    assembly_colored();
}
