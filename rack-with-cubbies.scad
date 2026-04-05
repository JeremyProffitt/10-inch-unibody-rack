/**
 * 10-Inch Unibody Server Rack (6U) with Side Cubbies
 * Prints in one piece on Bambu Labs H2D - front face down, no supports
 *
 * Extends the right side of the rack by 55mm with horizontal shelves
 * every 4 inches, creating storage cubbies alongside the rack.
 *
 * Coordinate System (print orientation):
 *   X = Rack width  (positive = right when facing rack front)
 *   Y = Rack height (positive = up in use orientation; along bed Y in print)
 *   Z = Rack depth  (positive = toward back; upward in print orientation)
 *
 * Origin: Front-bottom-left corner of outer shell
 *
 * Print Orientation:
 *   Front face (Z=0) placed on build plate.
 *   All walls are vertical in print - zero supports required.
 *   Cubby shelves are vertical thin walls in print - no bridging.
 *   Nut pocket diamond bevels are self-supporting.
 *
 * Bambu Labs H2D Build Volume (single nozzle): 325 x 320 x 325 mm
 * This model footprint: 319 x 286.7 mm (fits within 325 x 320 bed)
 */

// =========================================
// DIMENSIONS (all values in millimeters)
// =========================================

// --- Printer Constraints (Bambu Labs H2D, single nozzle) ---
printer_max_x_mm = 325;
printer_max_y_mm = 320;
printer_max_z_mm = 325;

// --- 10-Inch Rack Standard (derived from IEC 60297 / EIA-310) ---
rack_panel_width_mm         = 254.0;
rack_rail_to_rail_center_mm = 236.525;
rack_rail_width_mm          = 15.875;
rack_clear_opening_mm       = 222.25;
rack_unit_height_mm         = 44.45;

rack_hole_offset_1_mm = 6.35;
rack_hole_offset_2_mm = 22.225;
rack_hole_offset_3_mm = 38.10;

// --- Design Parameters ---
wall_thickness_mm      = 5.0;
rack_units             = 6;
rack_depth_mm          = 200.0;
rail_depth_mm          = 30.0;
rail_margin_mm         = 5.0;
mount_hole_diameter_mm = 6.5;
edge_radius_mm         = 8.0;

// --- M6 Nut Trap Parameters ---
enable_nut_traps        = true;
nut_across_flats_mm     = 10.0;
nut_thickness_mm        = 5.0;
nut_tolerance_mm        = 0.3;
nut_pocket_af_mm        = nut_across_flats_mm + nut_tolerance_mm;
nut_pocket_depth_mm     = nut_thickness_mm + nut_tolerance_mm;
nut_hex_od_mm           = nut_pocket_af_mm / cos(30);
nut_bevel_height_mm     = 1.0;          // Inverted V bevel below pocket for printability
nut_z_start_mm          = rail_depth_mm - nut_pocket_depth_mm
                          - nut_bevel_height_mm - 1.0;
nut_slot_width_mm       = nut_pocket_af_mm;

// --- Handle Cutouts ---
handle_slot_length_mm   = 90.0;
handle_slot_width_mm    = 30.0;
handle_slot_radius_mm   = 5.0;          // Small rounded corners (rectangle, not stadium)
handle_fillet_radius_mm = 2.0;
handle_top_offset_mm    = 50.0;
grip_bar_diameter_mm    = 18.0;         // Cylindrical grab bar at top of handle cutout

// --- Cubby Extension Parameters ---
cubby_width_mm          = 44.0;         // Total extension width (sized so full envelope fits H2D with 4mm clearance)
shelf_spacing_mm        = 101.6;        // 4 inches between shelves

// --- Computed Dimensions ---
rack_height_mm      = rack_units * rack_unit_height_mm;
outer_width_mm      = rack_panel_width_mm + 2 * wall_thickness_mm;                   // 264mm
outer_height_mm     = rack_height_mm + 2 * wall_thickness_mm + 2 * rail_margin_mm;   // 286.7mm
inner_height_mm     = outer_height_mm - 2 * wall_thickness_mm;                       // 276.7mm
inner_corner_radius_mm = max(0.1, edge_radius_mm - wall_thickness_mm);

// Total width including cubby
total_outer_width_mm = outer_width_mm + cubby_width_mm;                              // 308mm
cubby_inner_width_mm = cubby_width_mm - wall_thickness_mm;                           // 39mm
num_shelves = floor(inner_height_mm / shelf_spacing_mm);                             // 2

// Mounting area Y bounds
mount_area_y_start_mm = wall_thickness_mm + rail_margin_mm;
mount_area_y_end_mm   = mount_area_y_start_mm + rack_height_mm;

// Mounting hole X positions
mount_hole_x_left_mm  = wall_thickness_mm +
    (rack_panel_width_mm - rack_rail_to_rail_center_mm) / 2;
mount_hole_x_right_mm = outer_width_mm - mount_hole_x_left_mm;

// Rail inner face X positions
rail_left_inner_x_mm  = wall_thickness_mm + rack_rail_width_mm;
rail_right_inner_x_mm = outer_width_mm - wall_thickness_mm - rack_rail_width_mm;

// Handle position
handle_y_center_mm  = outer_height_mm - handle_top_offset_mm
                      - handle_slot_width_mm / 2;
handle_z_center_mm  = rack_depth_mm / 2;

// --- Print Fit Assertions (including grip bar protrusion) ---
grip_bar_protrusion_mm = grip_bar_diameter_mm / 2 - wall_thickness_mm / 2;           // 6.5mm
total_envelope_x_mm = total_outer_width_mm + 2 * grip_bar_protrusion_mm;             // 321mm
assert(total_envelope_x_mm <= printer_max_x_mm,
    str("X envelope ", total_envelope_x_mm, "mm exceeds printer X=", printer_max_x_mm, "mm"));
assert(outer_height_mm <= printer_max_y_mm,
    str("Height ", outer_height_mm, "mm exceeds printer Y=", printer_max_y_mm, "mm"));
assert(rack_depth_mm <= printer_max_z_mm,
    str("Depth ", rack_depth_mm, "mm exceeds printer Z=", printer_max_z_mm, "mm"));

$fn = 48;

// =========================================
// MODULES
// =========================================

module rounded_box(w, h, d, r) {
    hull() {
        translate([r, r, 0])     cylinder(h = d, r = r);
        translate([w-r, r, 0])   cylinder(h = d, r = r);
        translate([r, h-r, 0])   cylinder(h = d, r = r);
        translate([w-r, h-r, 0]) cylinder(h = d, r = r);
    }
}

/**
 * Rack Inner Cavity
 *
 * Interior void for the rack portion (left side).
 * Open front and back.
 */
module rack_inner_cavity() {
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
 * Cubby Inner Cavity
 *
 * Interior void for the cubby section (right side extension).
 * Separated from rack by the divider wall (original right wall, 5mm thick).
 * Open front and back.
 */
module cubby_inner_cavity() {
    ir = inner_corner_radius_mm;
    // Starts at Z=wall_thickness (behind 5mm front wall), open at back
    cubby_depth = rack_depth_mm - wall_thickness_mm + 1;
    translate([outer_width_mm, wall_thickness_mm, wall_thickness_mm]) {
        hull() {
            translate([ir, ir, 0])
                cylinder(h = cubby_depth, r = ir);
            translate([cubby_inner_width_mm - ir, ir, 0])
                cylinder(h = cubby_depth, r = ir);
            translate([ir, inner_height_mm - ir, 0])
                cylinder(h = cubby_depth, r = ir);
            translate([cubby_inner_width_mm - ir, inner_height_mm - ir, 0])
                cylinder(h = cubby_depth, r = ir);
        }
    }
}

/**
 * Cubby Shelves
 *
 * Horizontal shelves every 4 inches within the cubby section.
 * In print orientation these are vertical thin walls - no bridging issues.
 */
module cubby_shelves() {
    cubby_depth = rack_depth_mm - wall_thickness_mm;  // Behind front wall to open back
    for (i = [1 : num_shelves]) {
        shelf_y = wall_thickness_mm + i * shelf_spacing_mm;
        if (shelf_y + wall_thickness_mm < outer_height_mm - wall_thickness_mm) {
            translate([outer_width_mm, shelf_y, wall_thickness_mm])
                cube([cubby_inner_width_mm, wall_thickness_mm, cubby_depth]);
        }
    }
}

/**
 * Mounting Rail - extends full inner height
 */
module mounting_rail(x_start) {
    translate([x_start, wall_thickness_mm, 0])
        cube([rack_rail_width_mm, inner_height_mm, rail_depth_mm]);
}

/**
 * Mounting Holes - inset by rail_margin
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
 * Internal slots facing rack interior. Not visible from exterior.
 * Diamond bevel on pocket ceiling for support-free printing.
 */
module nut_traps_left() {
    offsets = [rack_hole_offset_1_mm, rack_hole_offset_2_mm, rack_hole_offset_3_mm];
    for (u = [0 : rack_units - 1]) {
        for (i = [0 : 2]) {
            y_pos = mount_area_y_start_mm + u * rack_unit_height_mm + offsets[i];

            translate([mount_hole_x_left_mm, y_pos, nut_z_start_mm])
                rotate([0, 0, 30])
                    cylinder(h = nut_pocket_depth_mm, d = nut_hex_od_mm, $fn = 6);

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
 * Internal slots facing rack interior.
 */
module nut_traps_right() {
    offsets = [rack_hole_offset_1_mm, rack_hole_offset_2_mm, rack_hole_offset_3_mm];
    for (u = [0 : rack_units - 1]) {
        for (i = [0 : 2]) {
            y_pos = mount_area_y_start_mm + u * rack_unit_height_mm + offsets[i];

            translate([mount_hole_x_right_mm, y_pos, nut_z_start_mm])
                rotate([0, 0, 30])
                    cylinder(h = nut_pocket_depth_mm, d = nut_hex_od_mm, $fn = 6);

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
 * Filleted stadium-shaped slot. Minkowski with sphere rounds all edges
 * where the handle meets the wall exterior for comfortable grip.
 */
module handle_cutout(x_start) {
    fr = handle_fillet_radius_mm;
    r = handle_slot_radius_mm - fr;

    half_w = handle_slot_width_mm / 2 - fr;
    half_l = handle_slot_length_mm / 2 - fr;
    dy = half_w - r;
    dz = half_l - r;

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
 * Cylindrical grab bar with hemispherical ends inside a handle cutout.
 * Upper half embedded in wall, lower half protrudes as a grip surface.
 */
module grip_bar(wall_x_center) {
    r = grip_bar_diameter_mm / 2;
    bar_y = handle_y_center_mm + handle_slot_width_mm / 2
            + grip_bar_diameter_mm / 2 - 3;  // Bar 3mm down into handle opening
    z_start = handle_z_center_mm - handle_slot_length_mm / 2 - 15;
    z_end   = handle_z_center_mm + handle_slot_length_mm / 2 + 15;

    hull() {
        translate([wall_x_center, bar_y, z_start + r])
            sphere(r = r, $fn = 32);
        translate([wall_x_center, bar_y, z_end - r])
            sphere(r = r, $fn = 32);
    }
}

/**
 * Complete Rack with Cubbies Assembly
 *
 * Unibody 10-inch server rack with 55mm cubby extension on right side.
 * Original right wall becomes divider. Shelves every 4" in cubby.
 * Grip bars in both handle cutouts.
 *
 * BOUNDING BOX: [0, 0, 0] to [319, 286.7, 200]
 */
module rack_with_cubbies() {
    union() {
        difference() {
            union() {
                // Outer shell minus both cavities (leaves divider wall)
                difference() {
                    rounded_box(total_outer_width_mm, outer_height_mm, rack_depth_mm, edge_radius_mm);
                    rack_inner_cavity();
                    cubby_inner_cavity();
                }

                // Mounting rails (full inner height)
                mounting_rail(wall_thickness_mm);
                mounting_rail(outer_width_mm - wall_thickness_mm - rack_rail_width_mm);

                // Cubby shelves
                cubby_shelves();
            }

            // Mounting screw holes
            mounting_holes(mount_hole_x_left_mm);
            mounting_holes(mount_hole_x_right_mm);

            // Internal M6 nut traps
            if (enable_nut_traps) {
                nut_traps_left();
                nut_traps_right();
            }

            // Filleted handle cutouts - left outer wall and right outer wall
            handle_cutout(-1);
            handle_cutout(total_outer_width_mm - wall_thickness_mm);
        }

        // Grip bars inside handle cutouts
        grip_bar(wall_thickness_mm / 2);                                    // Left wall
        grip_bar(total_outer_width_mm - wall_thickness_mm / 2);             // Right wall
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
    color("DimGray", 0.9) rack_with_cubbies();
}

module assembly_xray() {
    color("SteelBlue", 0.4) rack_with_cubbies();
}

// =========================================
// DEFAULT RENDER
// =========================================

assembly_colored();
