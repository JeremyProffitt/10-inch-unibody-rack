/**
 * 10-Inch Unibody Server Rack (6U) - "Just a Rack"
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
 *   Handle cutouts bridge only 5mm (wall thickness) - trivially printable.
 *   Nut pocket diamond bevels are self-supporting (pointed ceiling).
 *
 * Bambu Labs H2D Build Volume (single nozzle): 325 x 320 x 325 mm
 * This model footprint: 264 x 286.7 mm (fits within 325 x 320 bed)
 */

// =========================================
// DIMENSIONS (all values in millimeters)
// =========================================

// --- Printer Constraints (Bambu Labs H2D, single nozzle) ---
printer_max_x_mm = 325;
printer_max_y_mm = 320;
printer_max_z_mm = 325;

// --- 10-Inch Rack Standard (derived from IEC 60297 / EIA-310) ---
rack_panel_width_mm         = 254.0;     // 10" = total front panel width
rack_rail_to_rail_center_mm = 236.525;   // 9.312" mounting hole center-to-center
rack_rail_width_mm          = 15.875;    // 0.625" width of each mounting rail
rack_clear_opening_mm       = 222.25;    // 8.75" clear space between rail inner edges
rack_unit_height_mm         = 44.45;     // 1U = 1.75"

// Vertical hole pattern within each U (measured from bottom of each U)
rack_hole_offset_1_mm = 6.35;           // 0.25"
rack_hole_offset_2_mm = 22.225;         // 0.875"
rack_hole_offset_3_mm = 38.10;          // 1.50"

// --- Design Parameters ---
wall_thickness_mm      = 5.0;           // Wall thickness on all sides
rack_units             = 6;             // Number of rack units
rack_depth_mm          = 200.0;         // Total front-to-back depth
rail_depth_mm          = 30.0;          // How far mounting rails extend from front face
rail_margin_mm         = 5.0;           // Extra space above/below mounting holes
mount_hole_diameter_mm = 6.5;           // Clearance hole for M6 / #12-24 screws
edge_radius_mm         = 8.0;           // Fillet radius on outer vertical edges

// --- M6 Nut Trap Parameters ---
enable_nut_traps        = true;         // Set false for simple through-holes only
nut_across_flats_mm     = 10.0;         // M6 hex nut across flats
nut_thickness_mm        = 5.0;          // M6 hex nut thickness
nut_tolerance_mm        = 0.3;          // Print clearance tolerance
nut_pocket_af_mm        = nut_across_flats_mm + nut_tolerance_mm;   // 10.3mm
nut_pocket_depth_mm     = nut_thickness_mm + nut_tolerance_mm;       // 5.3mm
nut_hex_od_mm           = nut_pocket_af_mm / cos(30);                // ~11.9mm across corners
nut_bevel_height_mm     = 1.0;          // Inverted V bevel below pocket for printability
nut_z_start_mm          = rail_depth_mm - nut_pocket_depth_mm
                          - nut_bevel_height_mm - 1.0;               // Position in rail
nut_slot_width_mm       = nut_pocket_af_mm;                          // 10.3mm

// --- Handle Cutouts (side walls, near top, rotated 90 deg) ---
// Long axis runs along Z (depth), short axis along Y (height)
// Stadium shape: corner radius = half of short dimension (fully rounded, no sharp corners)
handle_slot_length_mm   = 90.0;         // Along Z (rack depth direction)
handle_slot_width_mm    = 30.0;         // Along Y (rack height direction)
handle_slot_radius_mm   = 5.0;          // Small rounded corners (rectangle, not stadium)
handle_fillet_radius_mm = 2.0;          // Fillet on edges where handle meets wall exterior
handle_top_offset_mm    = 50.0;         // Distance from rack top to handle top edge
grip_bar_diameter_mm    = 18.0;         // Cylindrical grab bar at top of handle cutout

// --- Computed Dimensions ---
rack_height_mm      = rack_units * rack_unit_height_mm;                              // 266.7mm
outer_width_mm      = rack_panel_width_mm + 2 * wall_thickness_mm;                   // 264mm
outer_height_mm     = rack_height_mm + 2 * wall_thickness_mm + 2 * rail_margin_mm;   // 286.7mm
inner_height_mm     = outer_height_mm - 2 * wall_thickness_mm;                       // 276.7mm
inner_corner_radius_mm = max(0.1, edge_radius_mm - wall_thickness_mm);               // 3mm

// Mounting area Y bounds (holes only - rails extend full inner height)
mount_area_y_start_mm = wall_thickness_mm + rail_margin_mm;                          // 10mm
mount_area_y_end_mm   = mount_area_y_start_mm + rack_height_mm;                      // 276.7mm

// Mounting hole X positions (from outer left edge)
mount_hole_x_left_mm  = wall_thickness_mm +
    (rack_panel_width_mm - rack_rail_to_rail_center_mm) / 2;                         // ~13.74mm
mount_hole_x_right_mm = outer_width_mm - mount_hole_x_left_mm;                       // ~250.26mm

// Rail inner face X positions (facing rack interior)
rail_left_inner_x_mm  = wall_thickness_mm + rack_rail_width_mm;                      // 20.875mm
rail_right_inner_x_mm = outer_width_mm - wall_thickness_mm - rack_rail_width_mm;     // 243.125mm

// Handle position: 50mm from top of rack, centered along depth
handle_y_center_mm  = outer_height_mm - handle_top_offset_mm
                      - handle_slot_width_mm / 2;                                    // 221.7mm
handle_z_center_mm  = rack_depth_mm / 2;                                             // 100mm

// --- Print Fit Assertions ---
assert(outer_width_mm <= printer_max_x_mm,
    str("Width ", outer_width_mm, "mm exceeds printer X=", printer_max_x_mm, "mm"));
assert(outer_height_mm <= printer_max_y_mm,
    str("Height ", outer_height_mm, "mm exceeds printer Y=", printer_max_y_mm, "mm"));
assert(rack_depth_mm <= printer_max_z_mm,
    str("Depth ", rack_depth_mm, "mm exceeds printer Z=", printer_max_z_mm, "mm"));

$fn = 48;

// =========================================
// MODULES
// =========================================

/**
 * Rounded Box
 *
 * Box with filleted edges along Z axis (vertical in print = no supports).
 * XY cross-section is a rounded rectangle.
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
 * Inner Cavity
 *
 * Interior void with rounded corners matching outer shell.
 * Extends through front and back (open both ends).
 */
module inner_cavity() {
    ir = inner_corner_radius_mm;
    translate([wall_thickness_mm, wall_thickness_mm, -1]) {
        hull() {
            translate([ir, ir, 0])
                cylinder(h = rack_depth_mm + 2, r = ir);
            translate([rack_panel_width_mm - ir, ir, 0])
                cylinder(h = rack_depth_mm + 2, r = ir);
            translate([ir, inner_height_mm - ir, 0])
                cylinder(h = rack_depth_mm + 2, r = ir);
            translate([rack_panel_width_mm - ir, inner_height_mm - ir, 0])
                cylinder(h = rack_depth_mm + 2, r = ir);
        }
    }
}

/**
 * Mounting Rail
 *
 * Rectangular strip at the front of the rack interior.
 * Extends full inner height (flush with top and bottom walls)
 * for structural rigidity. Mounting holes are inset by rail_margin.
 */
module mounting_rail(x_start) {
    translate([x_start, wall_thickness_mm, 0])
        cube([rack_rail_width_mm, inner_height_mm, rail_depth_mm]);
}

/**
 * Mounting Holes
 *
 * Screw clearance holes for one side. 3 holes per U, EIA-310 pattern.
 * Positioned within the rail_margin-inset mounting area.
 */
module mounting_holes(x_pos) {
    offsets = [rack_hole_offset_1_mm, rack_hole_offset_2_mm, rack_hole_offset_3_mm];
    for (u = [0 : rack_units - 1]) {
        for (i = [0 : 2]) {
            y_pos = mount_area_y_start_mm + u * rack_unit_height_mm + offsets[i];
            translate([x_pos, y_pos, -1])
                cylinder(h = rail_depth_mm + 2, d = mount_hole_diameter_mm);
        }
    }
}

/**
 * Nut Traps - Left Side
 *
 * M6 hex nut pockets behind screw holes with internal access slots.
 * Slots open on the rail inner face (toward rack interior) only.
 * NOT visible from the exterior.
 *
 * Each trap has:
 *   1. Hex pocket for the nut (rotated 30 deg for flat-to-slot alignment)
 *   2. Rectangular slot from rail inner face to pocket (nut slides in from inside rack)
 *   3. Diamond bevel above pocket (pointed ceiling for support-free printing)
 */
module nut_traps_left() {
    offsets = [rack_hole_offset_1_mm, rack_hole_offset_2_mm, rack_hole_offset_3_mm];
    for (u = [0 : rack_units - 1]) {
        for (i = [0 : 2]) {
            y_pos = mount_area_y_start_mm + u * rack_unit_height_mm + offsets[i];

            // Hex nut pocket
            translate([mount_hole_x_left_mm, y_pos, nut_z_start_mm])
                rotate([0, 0, 30])
                    cylinder(h = nut_pocket_depth_mm, d = nut_hex_od_mm, $fn = 6);

            // Internal slot from rail inner face to nut pocket
            translate([mount_hole_x_left_mm - nut_pocket_af_mm / 2,
                       y_pos - nut_slot_width_mm / 2,
                       nut_z_start_mm])
                cube([rail_left_inner_x_mm - mount_hole_x_left_mm + nut_pocket_af_mm / 2 + 1,
                      nut_slot_width_mm,
                      nut_pocket_depth_mm]);

            // Inverted V bevel below nut pocket, spanning full rail width
            hull() {
                translate([wall_thickness_mm,
                           y_pos - nut_hex_od_mm / 2,
                           nut_z_start_mm])
                    cube([rack_rail_width_mm, nut_hex_od_mm, 0.01]);
                translate([wall_thickness_mm,
                           y_pos - 0.005,
                           nut_z_start_mm - nut_bevel_height_mm])
                    cube([rack_rail_width_mm, 0.01, 0.01]);
            }
        }
    }
}

/**
 * Nut Traps - Right Side
 *
 * Mirror of left side. Slots open on right rail inner face (toward rack interior).
 */
module nut_traps_right() {
    offsets = [rack_hole_offset_1_mm, rack_hole_offset_2_mm, rack_hole_offset_3_mm];
    for (u = [0 : rack_units - 1]) {
        for (i = [0 : 2]) {
            y_pos = mount_area_y_start_mm + u * rack_unit_height_mm + offsets[i];

            // Hex nut pocket
            translate([mount_hole_x_right_mm, y_pos, nut_z_start_mm])
                rotate([0, 0, 30])
                    cylinder(h = nut_pocket_depth_mm, d = nut_hex_od_mm, $fn = 6);

            // Internal slot from rail inner face to nut pocket
            translate([rail_right_inner_x_mm - 1,
                       y_pos - nut_slot_width_mm / 2,
                       nut_z_start_mm])
                cube([mount_hole_x_right_mm + nut_pocket_af_mm / 2 - rail_right_inner_x_mm + 1,
                      nut_slot_width_mm,
                      nut_pocket_depth_mm]);

            // Inverted V bevel below nut pocket, spanning full rail width
            hull() {
                translate([rail_right_inner_x_mm,
                           y_pos - nut_hex_od_mm / 2,
                           nut_z_start_mm])
                    cube([rack_rail_width_mm, nut_hex_od_mm, 0.01]);
                translate([rail_right_inner_x_mm,
                           y_pos - 0.005,
                           nut_z_start_mm - nut_bevel_height_mm])
                    cube([rack_rail_width_mm, 0.01, 0.01]);
            }
        }
    }
}

/**
 * Handle Cutout
 *
 * Stadium-shaped slot through side wall for carrying the rack.
 * Long axis along Z (depth), short axis along Y (height).
 * Positioned 50mm from top of rack.
 *
 * Stadium shape = fully rounded ends (no sharp corners anywhere).
 * All edges where the handle meets the wall exterior are filleted
 * using minkowski with a sphere for a smooth, comfortable grip.
 *
 * Parameters:
 *   x_start: X position to begin cutout (just outside the wall)
 */
module handle_cutout(x_start) {
    fr = handle_fillet_radius_mm;
    r = handle_slot_radius_mm - fr;    // Pre-shrunk corner radius (3mm)

    // Pre-shrunk half-extents (minkowski will expand by fr)
    half_w = handle_slot_width_mm / 2 - fr;   // Y half-extent before minkowski
    half_l = handle_slot_length_mm / 2 - fr;  // Z half-extent before minkowski
    dy = half_w - r;  // Y offset to corner cylinder centers
    dz = half_l - r;  // Z offset to corner cylinder centers

    translate([x_start + fr, handle_y_center_mm, handle_z_center_mm])
        minkowski() {
            hull() {
                for (sy = [-1, 1]) {
                    for (sz = [-1, 1]) {
                        translate([0, sy * dy, sz * dz])
                            rotate([0, 90, 0])
                                cylinder(h = wall_thickness_mm + 2 - 2 * fr, r = r);
                    }
                }
            }
            sphere(r = fr, $fn = 16);
        }
}

/**
 * Grip Bar
 *
 * Cylindrical grab bar with rounded (hemispherical) ends inside a handle cutout.
 * Positioned at the top edge of the handle opening so upper half is embedded
 * in the wall above, lower half protrudes into the handle opening as a grip.
 * Spans the full handle length along Z.
 *
 * Parameters:
 *   wall_x_center: X center of the wall containing this grip bar
 */
module grip_bar(wall_x_center) {
    r = grip_bar_diameter_mm / 2;
    bar_y = handle_y_center_mm + handle_slot_width_mm / 2
            + grip_bar_diameter_mm / 2 - 3;  // Bar 3mm down into handle opening
    z_start = handle_z_center_mm - handle_slot_length_mm / 2 - 15;
    z_end   = handle_z_center_mm + handle_slot_length_mm / 2 + 15;

    // Capsule: hull of two spheres (rounded ends)
    hull() {
        translate([wall_x_center, bar_y, z_start + r])
            sphere(r = r, $fn = 32);
        translate([wall_x_center, bar_y, z_end - r])
            sphere(r = r, $fn = 32);
    }
}

/**
 * Complete Rack Assembly
 *
 * Unibody 10-inch server rack:
 *   1. Outer shell with rounded vertical edges
 *   2. Inner cavity (open front and back)
 *   3. Full-height mounting rails (flush with top/bottom walls)
 *   4. Screw holes in rail_margin-inset mounting area (EIA-310)
 *   5. Internal M6 nut traps with diamond bevels (slots face rack interior)
 *   6. Filleted stadium handle cutouts 50mm from top
 *   7. 18mm grip bars at top of each handle
 *
 * BOUNDING BOX: [0, 0, 0] to [264, 286.7, 200]
 */
module rack() {
    union() {
        difference() {
            union() {
                // Outer shell minus inner cavity
                difference() {
                    rounded_box(outer_width_mm, outer_height_mm, rack_depth_mm, edge_radius_mm);
                    inner_cavity();
                }

                // Mounting rails (full inner height)
                mounting_rail(wall_thickness_mm);
                mounting_rail(outer_width_mm - wall_thickness_mm - rack_rail_width_mm);
            }

            // Mounting screw holes (inset by rail_margin)
            mounting_holes(mount_hole_x_left_mm);
            mounting_holes(mount_hole_x_right_mm);

            // Internal M6 nut traps with diamond bevels
            if (enable_nut_traps) {
                nut_traps_left();
                nut_traps_right();
            }

            // Filleted stadium handle cutouts
            handle_cutout(-1);
            handle_cutout(outer_width_mm - wall_thickness_mm);
        }

        // Grip bars inside handle cutouts (added back after cutout subtraction)
        grip_bar(wall_thickness_mm / 2);                            // Left wall
        grip_bar(outer_width_mm - wall_thickness_mm / 2);           // Right wall
    }
}

// =========================================
// DEBUG / VISUALIZATION
// =========================================

module debug_axes(length = 50) {
    color("red")   cylinder(h = length, r = 1, $fn = 16);
    color("green") rotate([0, 90, 0]) cylinder(h = length, r = 1, $fn = 16);
    color("blue")  rotate([-90, 0, 0]) cylinder(h = length, r = 1, $fn = 16);
}

module assembly_colored() {
    color("DimGray", 0.9) rack();
}

module assembly_xray() {
    color("SteelBlue", 0.4) rack();
}

// =========================================
// DEFAULT RENDER
// =========================================

assembly_colored();
