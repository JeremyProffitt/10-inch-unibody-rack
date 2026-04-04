/**
 * 10-Inch Unibody Server Rack (6U)
 * Prints in one piece on Bambu Labs H2D - front face down, no supports
 *
 * Coordinate System (print orientation):
 *   X = Rack width  (positive = right when facing rack front)
 *   Y = Rack height (positive = up in use orientation; along bed Y in print)
 *   Z = Rack depth  (positive = toward back; upward in print orientation)
 *
 * Origin: Front-bottom-left corner of rack outer shell
 *
 * Print Orientation:
 *   Front face (Z=0) placed on build plate.
 *   All walls are vertical in print - zero supports required.
 *   Side handle cutouts bridge only 5mm (wall thickness) - trivially printable.
 *
 * Bambu Labs H2D Build Volume (single nozzle): 325 x 320 x 325 mm
 * This model footprint: 264 x 276.7 mm (fits within 325 x 320 bed)
 */

// =========================================
// DIMENSIONS (all values in millimeters)
// =========================================

// --- Printer Constraints (Bambu Labs H2D, single nozzle) ---
printer_max_x_mm = 325;
printer_max_y_mm = 320;
printer_max_z_mm = 325;

// --- 10-Inch Rack Standard (derived from IEC 60297 / EIA-310) ---
rack_panel_width_mm       = 254.0;     // 10" = total front panel width
rack_rail_to_rail_center_mm = 236.525; // 9.312" mounting hole center-to-center
rack_rail_width_mm        = 15.875;    // 0.625" width of each mounting rail
rack_clear_opening_mm     = 222.25;    // 8.75" clear space between rail inner edges
rack_unit_height_mm       = 44.45;     // 1U = 1.75"

// Vertical hole pattern within each U (measured from bottom of each U)
rack_hole_offset_1_mm = 6.35;         // 0.25"
rack_hole_offset_2_mm = 22.225;       // 0.875"
rack_hole_offset_3_mm = 38.10;        // 1.50"

// --- Design Parameters ---
wall_thickness_mm      = 5.0;         // Wall thickness on all sides
rack_units             = 6;           // Number of rack units
rack_depth_mm          = 200.0;       // Total front-to-back depth
rail_depth_mm          = 15.0;        // How far mounting rails extend from front face
mount_hole_diameter_mm = 6.5;         // Clearance hole for M6 / #12-24 screws
edge_radius_mm         = 8.0;         // Fillet radius on outer vertical edges

// Handle cutouts (side walls)
handle_length_mm        = 90.0;       // Along Y (rack height direction)
handle_width_mm         = 30.0;       // Along Z (rack depth direction)
handle_corner_radius_mm = 10.0;       // Rounded corners on handle slot

// --- Computed Dimensions ---
rack_height_mm      = rack_units * rack_unit_height_mm;               // 266.7mm for 6U
outer_width_mm      = rack_panel_width_mm + 2 * wall_thickness_mm;    // 264mm
outer_height_mm     = rack_height_mm + 2 * wall_thickness_mm;         // 276.7mm
inner_corner_radius_mm = max(0.1, edge_radius_mm - wall_thickness_mm); // 3mm

// Handle position - centered on side wall
handle_y_center_mm  = outer_height_mm / 2;
handle_z_center_mm  = rack_depth_mm / 2;

// Mounting hole X positions (from outer left edge)
mount_hole_x_left_mm  = wall_thickness_mm +
    (rack_panel_width_mm - rack_rail_to_rail_center_mm) / 2;          // ~13.74mm
mount_hole_x_right_mm = outer_width_mm - mount_hole_x_left_mm;        // ~250.26mm

// --- Print Fit Assertions ---
assert(outer_width_mm <= printer_max_x_mm,
    str("Rack width ", outer_width_mm, "mm exceeds printer X limit ", printer_max_x_mm, "mm"));
assert(outer_height_mm <= printer_max_y_mm,
    str("Rack height ", outer_height_mm, "mm exceeds printer Y limit ", printer_max_y_mm, "mm"));
assert(rack_depth_mm <= printer_max_z_mm,
    str("Rack depth ", rack_depth_mm, "mm exceeds printer Z limit ", printer_max_z_mm, "mm"));

$fn = 48;

// =========================================
// COMPONENT INDEX
// =========================================
/**
 * | Component        | Origin [X,Y,Z]       | Size [W,H,D]           | Description                    |
 * |------------------|----------------------|------------------------|--------------------------------|
 * | outer_shell      | [0, 0, 0]            | [264, 276.7, 200]      | Rounded outer box              |
 * | inner_cavity     | [5, 5, -1]           | [254, 266.7, 202]      | Interior void (open front+back)|
 * | left_rail        | [5, 5, 0]            | [15.875, 266.7, 15]    | Left mounting rail             |
 * | right_rail       | [243.1, 5, 0]        | [15.875, 266.7, 15]    | Right mounting rail            |
 * | mount_holes_L    | [13.74, *, -1]       | [dia 6.5, -, 17]       | Left side screw holes (18x)    |
 * | mount_holes_R    | [250.26, *, -1]      | [dia 6.5, -, 17]       | Right side screw holes (18x)   |
 * | handle_left      | [-1, 93.4, 85]       | [7, 90, 30]            | Left side carry cutout         |
 * | handle_right     | [258, 93.4, 85]      | [7, 90, 30]            | Right side carry cutout        |
 */

// =========================================
// MODULES
// =========================================

/**
 * Rounded Box
 *
 * Creates a box with filleted edges along the Z axis (depth direction).
 * In print orientation these are the vertical edges - no supports needed.
 * XY cross-section is a rounded rectangle; Z extent is straight.
 *
 * BOUNDING BOX: [0,0,0] to [w, h, d]
 */
module rounded_box(w, h, d, r) {
    hull() {
        translate([r, r, 0])     cylinder(h = d, r = r);
        translate([w-r, r, 0])   cylinder(h = d, r = r);
        translate([r, h-r, 0])   cylinder(h = d, r = r);
        translate([w-r, h-r, 0]) cylinder(h = d, r = r);
    }
}

/**
 * Rounded Cavity
 *
 * Inner void with rounded corners matching the outer shell.
 * Maintains uniform wall thickness at the corners.
 * Extends through front (Z=-1) and back (Z=depth+1) for clean boolean.
 *
 * POSITION: Translated to [wall, wall, -1] before use
 * BOUNDING BOX: [wall, wall, -1] to [wall+panel_w, wall+rack_h, depth+1]
 */
module inner_cavity() {
    ir = inner_corner_radius_mm;
    translate([wall_thickness_mm, wall_thickness_mm, -1]) {
        hull() {
            translate([ir, ir, 0])
                cylinder(h = rack_depth_mm + 2, r = ir);
            translate([rack_panel_width_mm - ir, ir, 0])
                cylinder(h = rack_depth_mm + 2, r = ir);
            translate([ir, rack_height_mm - ir, 0])
                cylinder(h = rack_depth_mm + 2, r = ir);
            translate([rack_panel_width_mm - ir, rack_height_mm - ir, 0])
                cylinder(h = rack_depth_mm + 2, r = ir);
        }
    }
}

/**
 * Mounting Rail
 *
 * Rectangular strip at the front of the rack interior.
 * Provides screw engagement surface for rack-mount equipment.
 *
 * Parameters:
 *   x_start: X position of rail left edge
 *
 * BOUNDING BOX: [x_start, wall, 0] to [x_start+rail_width, wall+rack_height, rail_depth]
 */
module mounting_rail(x_start) {
    translate([x_start, wall_thickness_mm, 0])
        cube([rack_rail_width_mm, rack_height_mm, rail_depth_mm]);
}

/**
 * Mounting Holes
 *
 * Creates all screw clearance holes for one side's mounting rail.
 * 3 holes per rack unit, following EIA-310 vertical spacing pattern:
 *   Hole spacing within 1U: 15.875mm, 15.875mm, 12.70mm (repeating)
 *
 * Parameters:
 *   x_pos: X position of hole centers
 *
 * ALIGNMENT: Holes centered on rail width, extending through rail depth
 */
module mounting_holes(x_pos) {
    offsets = [rack_hole_offset_1_mm, rack_hole_offset_2_mm, rack_hole_offset_3_mm];

    for (u = [0 : rack_units - 1]) {
        for (i = [0 : 2]) {
            y_pos = wall_thickness_mm + u * rack_unit_height_mm + offsets[i];
            translate([x_pos, y_pos, -1])
                cylinder(h = rail_depth_mm + 2, d = mount_hole_diameter_mm);
        }
    }
}

/**
 * Handle Cutout
 *
 * Rounded rectangular slot through a side wall for carrying the rack.
 * The slot is oriented with its long axis along Y (rack height) and
 * its short axis along Z (rack depth).
 *
 * In print orientation, the top edge of this cutout bridges only 5mm
 * (the wall thickness along X) - trivially printable without supports.
 *
 * Parameters:
 *   x_start: X position to start the cutout (slightly outside the wall)
 *
 * BOUNDING BOX: [x_start, y_center-length/2, z_center-width/2]
 *            to [x_start+wall+2, y_center+length/2, z_center+width/2]
 */
module handle_cutout(x_start) {
    y_start = handle_y_center_mm - handle_length_mm / 2;
    z_start = handle_z_center_mm - handle_width_mm / 2;
    r = handle_corner_radius_mm;

    translate([x_start, y_start + r, z_start + r])
        hull() {
            for (dy = [0, handle_length_mm - 2 * r]) {
                for (dz = [0, handle_width_mm - 2 * r]) {
                    translate([0, dy, dz])
                        rotate([0, 90, 0])
                            cylinder(h = wall_thickness_mm + 2, r = r);
                }
            }
        }
}

/**
 * Complete Rack Assembly
 *
 * Unibody 10-inch server rack combining:
 *   1. Outer shell with rounded vertical edges
 *   2. Inner cavity (open front and back)
 *   3. Left and right mounting rails at front face
 *   4. Mounting screw holes through rails
 *   5. Handle cutouts on both side walls
 *
 * POSITION: Origin at front-bottom-left corner
 * BOUNDING BOX: [0, 0, 0] to [264, 276.7, 200]
 *
 * CONNECTS TO:
 *   - Build plate: Z=0 face (front of rack) sits on bed
 *   - Equipment: Mounts via screw holes in rails at Z=0..rail_depth
 */
module rack() {
    difference() {
        union() {
            // Outer shell minus inner cavity
            difference() {
                rounded_box(outer_width_mm, outer_height_mm, rack_depth_mm, edge_radius_mm);
                inner_cavity();
            }

            // Left mounting rail
            mounting_rail(wall_thickness_mm);

            // Right mounting rail
            mounting_rail(outer_width_mm - wall_thickness_mm - rack_rail_width_mm);
        }

        // Mounting screw holes - left side
        mounting_holes(mount_hole_x_left_mm);

        // Mounting screw holes - right side
        mounting_holes(mount_hole_x_right_mm);

        // Handle cutout - left wall
        handle_cutout(-1);

        // Handle cutout - right wall
        handle_cutout(outer_width_mm - wall_thickness_mm);
    }
}

// =========================================
// DEBUG / VISUALIZATION
// =========================================

// Render coordinate axes at origin (length = 50mm)
module debug_axes(length = 50) {
    color("red")   cylinder(h = length, r = 1, $fn = 16);               // Z (depth)
    color("green") rotate([0, 90, 0]) cylinder(h = length, r = 1, $fn = 16); // X (width)
    color("blue")  rotate([-90, 0, 0]) cylinder(h = length, r = 1, $fn = 16); // Y (height)
}

// Color-coded view for visual inspection
module assembly_colored() {
    color("DimGray", 0.9) rack();
}

// Transparent view showing internal structure
module assembly_xray() {
    color("SteelBlue", 0.4) rack();
}

// =========================================
// DEFAULT RENDER
// =========================================

assembly_colored();
